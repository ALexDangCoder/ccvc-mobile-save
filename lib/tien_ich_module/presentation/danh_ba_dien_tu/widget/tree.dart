import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';
import 'package:rxdart/rxdart.dart';

class Tree<T> {
  List<NodeHSCV> tree = [];

  void initTree({required List<TreeDonViDanhBA> listNode}) {
    try {
      for (int i = 0; i < listNode.length; i++) {
        NodeHSCV node = NodeHSCV.createNode(value: listNode[i]);
        node.isHasChild = IsDaPhanXuLy(node, listNode);
        tree.add(node);
      }
    } catch (e) {}
  }

  bool IsDaPhanXuLy(NodeHSCV value, List<TreeDonViDanhBA> listChild) {
    if (value.value.iD_DonVi_Cha.trim() == '') {
      return true;
    } else {
      for (var i in listChild) {
        if (i.iD_DonVi_Cha == value.value.id) {
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
    List<NodeHSCV> res = [];
    for (int i = 0; i < tree.length; i++) {
      if (tree[i].iD_DonVi_Cha == iDDonViCha &&
          tree[i].iD_DonVi_Cha != tree[i].value.id) res.add(tree[i]);
    }

    return res;
  }

  NodeHSCV? getRoot() {
    for (int i = 0; i < tree.length; i++) {
      if (tree[i].iD_DonVi_Cha == tree[i].value.id) return tree[i];
    }

    return tree
        .firstWhere((element) => element.iD_DonVi_Cha == element.value.id);
  }
}

class NodeHSCV {
  TreeDonViDanhBA value;
  String? iD_DonVi_Cha;
  int colorNode;
  String vaiTro;
  bool isHasChild;

  NodeHSCV(
      {required this.value,
      required this.iD_DonVi_Cha,
      required this.colorNode,
      this.vaiTro = '',
      this.isHasChild = false});

  factory NodeHSCV.createNode({required TreeDonViDanhBA value}) {
    int getColor(TreeDonViDanhBA data) {
      return 0xFFFFFFFF;
    }

    return NodeHSCV(
        value: value,
        iD_DonVi_Cha:
            value.iD_DonVi_Cha.trim() == '' ? value.id : value.iD_DonVi_Cha,
        colorNode: getColor(value),
        vaiTro: '',
        isHasChild: false);
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
