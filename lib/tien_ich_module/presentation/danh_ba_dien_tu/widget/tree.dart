import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';
import 'package:rxdart/rxdart.dart';

class TreeDanhBaDienTu<T> {
  List<NodeHSCV> tree = [];

  void initTree({required List<TreeDonViDanhBA> listNode}) {
    try {
      for (int i = 0; i < listNode.length; i++) {
        final NodeHSCV node = NodeHSCV.createNode(value: listNode[i]);
        node.isHasChild = isDaPhanXuLy(node, listNode);
        tree.add(node);
      }
    } catch (e) {
      e.toString();
    }
  }

  bool isDaPhanXuLy(NodeHSCV value, List<TreeDonViDanhBA> listChild) {
    if (value.value.iDDonViCha.trim() == '') {
      return true;
    } else {
      for (var i in listChild) {
        if (i.iDDonViCha == value.value.id) {
          return true;
        }
      }

      return false;
    }
  }

  void addChild({required TreeDonViDanhBA value}) {
    tree.add(NodeHSCV.createNode(value: value));
  }

  List<NodeHSCV> getChild(String iDDonViCha) {
    final List<NodeHSCV> res = [];
    for (int i = 0; i < tree.length; i++) {
      if (tree[i].iDDonViCha == iDDonViCha &&
          tree[i].iDDonViCha != tree[i].value.id) res.add(tree[i]);
    }

    return res;
  }

  NodeHSCV? getRoot() {
    for (int i = 0; i < tree.length; i++) {
      if (tree[i].iDDonViCha == tree[i].value.id) return tree[i];
    }

    return tree.firstWhere((element) => element.iDDonViCha == element.value.id);
  }
}

class NodeHSCV {
  TreeDonViDanhBA value;
  String? iDDonViCha;
  bool isHasChild;
  bool isExpand;

  NodeHSCV({
    required this.value,
    required this.iDDonViCha,
    this.isHasChild = false,
    this.isExpand = true,
  });

  factory NodeHSCV.createNode({required TreeDonViDanhBA value}) {
    return NodeHSCV(
      value: value,
      iDDonViCha: value.iDDonViCha.trim() == '' ? value.id : value.iDDonViCha,
    );
  }

  bool getExpand(bool? isInSearching) {
    if (isInSearching != null) {
      return isInSearching;
    }
    if ((value.iDDonViCha).isEmpty || !value.hasDonViCon) {
      return true;
    }
    return false;
  }
}

class NodeCubit {
  List<NodeHSCV> tree;

  BehaviorSubject<List<NodeHSCV>> listTreeXLPhanXuLySubject =
      BehaviorSubject<List<NodeHSCV>>();

  NodeCubit({required this.tree});

  void init() {
    listTreeXLPhanXuLySubject.sink.add(tree);
  }
}
