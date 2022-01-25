import 'dart:async';

import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/them_don_vi_widget/bloc/them_don_vi_state.dart';
import 'package:rxdart/rxdart.dart';

class ThemDonViCubit extends BaseCubit<ThemDonViState> {
  ThemDonViCubit() : super(MainStateInitial());
  List<Node<DonViModel>> listTree = [];
  Timer? _debounce;
  final List<Node<DonViModel>> selectNode = [];

  ///
  final BehaviorSubject<List<Node<DonViModel>>> _getTree =
      BehaviorSubject<List<Node<DonViModel>>>();
  Stream<List<Node<DonViModel>>> get getTree => _getTree.stream;

  final BehaviorSubject<List<Node<DonViModel>>> _selectDonVi =
      BehaviorSubject<List<Node<DonViModel>>>();
  Stream<List<Node<DonViModel>>> get selectDonVi => _selectDonVi.stream;

  void getTreeDonVi() {
    final result = batTree();
    _getTree.sink.add(result);
    listTree = result;
  }

  void addSelectNode(Node<DonViModel> node, {required bool isCheck}) {
    if (isCheck) {
      selectNode.add(node);
    } else {
      selectNode.remove(node);
    }
    _selectDonVi.sink.add(selectNode);
  }

  void removeTag(Node<DonViModel> node) {
    selectNode.remove(node);
    _selectDonVi.sink.add(selectNode);
    node.isCheck.isCheck =
        false; //dùng tham chiếu không phải loop lại tree để xét lại checkbox
    _getTree.sink.add(listTree);
  }

  void initSelectNode(List<Node<DonViModel>> value) {


  }

  void onSearch(String search) {
    final String textSearch = search.trim();
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
