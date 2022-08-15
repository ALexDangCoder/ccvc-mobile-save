import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/them_don_vi_widget/bloc/them_don_vi_state.dart';
import 'package:rxdart/rxdart.dart';

import '../them_don_vi_widget.dart';

class ThemDonViCubit extends BaseCubit<ThemDonViState> {
  ThemDonViCubit() : super(MainStateInitial()) {
    _selectDonVi.sink.add(selectNode);
  }

  List<Node<DonViModel>> listTree = [];
  Timer? _debounce;
  List<Node<DonViModel>> selectNode = [];
  final List<RemoveItemTree> listIdDonViRemove = [];
  Node<DonViModel>? selectNodeOnlyValue;
  BehaviorSubject<bool> themDonViSubject = BehaviorSubject();
  BehaviorSubject<bool> validateDonVi = BehaviorSubject();
  List<DonViModel> listDonVi = [];

  ///
  final BehaviorSubject<List<Node<DonViModel>>> _getTree =
      BehaviorSubject<List<Node<DonViModel>>>();

  Stream<List<Node<DonViModel>>> get getTree => _getTree.stream;

  final BehaviorSubject<List<Node<DonViModel>>> _selectDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();

  Stream<List<Node<DonViModel>>> get selectDonVi => _selectDonVi.stream;

  List<Node<DonViModel>> get selectDonViValue => _selectDonVi.valueOrNull ?? [];

  Sink<List<Node<DonViModel>>> get selectDonViSink => _selectDonVi.sink;

  final BehaviorSubject<Node<DonViModel>?> _selectOnlyDonVi =
      BehaviorSubject<Node<DonViModel>?>();

  Stream<Node<DonViModel>?> get selectOnlyDonVi => _selectOnlyDonVi.stream;

  Sink<Node<DonViModel>?> get sinkSelectOnlyDonVi => _selectOnlyDonVi.sink;
  List<Node<DonViModel>> listData = [];

  void getTreeDonVi(List<Node<DonViModel>> tree, {bool isDonVi = false}) {
    final data = <Node<DonViModel>>[];
    for (final vl in tree) {
      Node<DonViModel>? nodeAdd = vl;
      if (isDonVi) {
        for (final donViRemove in listIdDonViRemove) {
          nodeAdd = vl.removeFirstWhere(
            (element) => donViRemove.donViId == element.id,
          );
        }
      }
      if (nodeAdd != null) {
        data.add(vl.coppyWith());
      }
    }
    _getTree.sink.add(data);
    listTree = data;
  }

  void getTreeInit(List<Node<DonViModel>> tree) {
    _getTree.sink.add(tree);
    listTree = tree;
  }

  void getParentStart(Node<DonViModel> node){
    if(node.level == 0){
      listTree.clear();
      listTree = [node];
      _getTree.sink.add(listTree);
    } else {
      getParentStart(node.parent!);
    }
  }

  void addSelectNode(Node<DonViModel> node, {required bool isCheck}) {
    if (isCheck) {
      selectNode.add(node);
    } else {
      selectNode.removeWhere((element) => element.value.id == node.value.id);
    }
    final listSelectNode = selectNode;
    _selectDonVi.sink.add(listSelectNode);
  }

  void addSelectParent(Node<DonViModel> node, {required bool isCheck}) {
    if (isCheck) {
      selectNode.add(node);
    } else {
      selectNode.remove(node);
    }
    _selectDonVi.sink.add(selectNode);
  }

  bool _isCheckChildrenIsSelectNode(Node<DonViModel> node) {
    if (node.children.isNotEmpty) {
      for (final element in node.children) {
        final check = selectNode.contains(element);
        if (check) {
          return true;
        }
      }
    }
    return false;
  }

  void selectNodeOnly(Node<DonViModel> node) {
    selectNodeOnlyValue = node;
    _selectOnlyDonVi.sink.add(node);
  }

  void removeTag(Node<DonViModel> node) {
    selectNode.remove(node);
    _selectDonVi.sink.add(selectNode);
    node.isCheck.isCheck =
        false; //dùng tham chiếu không phải loop lại tree để xét lại checkbox
    _getTree.sink.add(listTree);
  }

  void removeCheckBox(Node<DonViModel> node) {
    selectNode.removeWhere((element) => element.value.id == node.value.id);
    _selectDonVi.sink.add(selectNode);
    _getTree.sink.add(_getTree.value);
  }

  List<CacheDonVi> listCacheDonVi = [];

  void saveCached() {
    listCacheDonVi.clear();
    for (int i = 0; i < selectNode.length; i++) {
      listCacheDonVi.add(CacheDonVi(selectNode[i]));
    }
  }

  void clearData() {
    for (final element in selectNode) {
      element.isCheck.isCheck = false;
    }
    selectNode.clear();
    for (final element in listCacheDonVi) {
      element.node.isCheck.isCheck = true;
      selectNode.add(element.node);
    }
    _selectDonVi.add(selectNode);
  }

  void initSelectNode(List<DonViModel> value) {
    selectNode.clear();
    for (final element in listTree) {
      element.removeCkeckBox();
      for (final vl in value) {
        final node = Node<DonViModel>(vl);
        final result = element.search(node);
        if (result != null) {
          selectNode.add(result);
          result.isCheck.isCheck = true;
        }
      }
    }
    _getTree.sink.add(listTree);
  }

  String keySearchChonNguoi = '';

  void onSearch(String search) {
    final String textSearch = search.trim();
    keySearchChonNguoi = textSearch;
    if (_debounce != null) {
      if (_debounce!.isActive) _debounce!.cancel();
    }
    final List<Node<DonViModel>> listNode = [];
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (textSearch.isNotEmpty) {
        for (final node in listTree) {
          final nodeSearch = _searchNode(node, textSearch);
          if (nodeSearch != null) {
            listNode.add(nodeSearch);
          }
        }
        _getTree.sink.add(listNode);
      } else {
        _getTree.sink.add(listTree);
      }
    });
  }

  Node<DonViModel>? _searchNode(Node<DonViModel> node, String search) {
    final Set<Node<DonViModel>> listNodeSearch = {};
    _listSearch(listNodeSearch, node, search);
    if (listNodeSearch.isNotEmpty &&
        listNodeSearch.where((element) => element.parent == null).isNotEmpty) {
      final parent =
          listNodeSearch.where((element) => element.parent == null).first;
      final Node<DonViModel> treeSearch = Node.init(parent);
      _makeBuildTreeSearch(treeSearch, listNodeSearch);
      return treeSearch;
    }
    return null;
  }

  void _makeBuildTreeSearch(
    Node<DonViModel> node,
    Set<Node<DonViModel>> listNodeSearch,
  ) {
    final children = listNodeSearch
        .where((element) => element.parent?.value.id == node.value.id);
    if (children.isNotEmpty) {
      for (final vl in children) {
        final Node<DonViModel> treeSearch = Node.init(vl);
        treeSearch.expand = true;
        node.addChild(treeSearch);

        _makeBuildTreeSearch(treeSearch, listNodeSearch);
      }
    }
  }

  void _listSearch(
    Set<Node<DonViModel>> list,
    Node<DonViModel> node,
    String search,
  ) {
    if (node.value.name
        .toLowerCase()
        .vietNameseParse()
        .contains(search.toLowerCase().vietNameseParse())) {
      list.add(node);
      if (node.parent != null) {
        _addParent(list, node);
      }
    }
    if (node.children.isNotEmpty) {
      for (final vl in node.children) {
        _listSearch(list, vl, search);
      }
    }
  }

  void _addParent(Set<Node<DonViModel>> list, Node<DonViModel> node) {
    if (node.parent != null) {
      list.add(node.parent!);
      _addParent(list, node.parent!);
    } else {
      return;
    }
  }

  void dispose() {
    _getTree.close();
  }
}

class CacheDonVi {
  Node<DonViModel> node;

  CacheDonVi(this.node);
}
