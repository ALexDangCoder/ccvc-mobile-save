import 'package:ccvc_mobile/widgets/thanh_phan_tham_gia/fake_date_tao_lich_hop.dart';

class DonViModel {
  String id = '';
  String name = '';
  String tenCanBo = '';
  String chucVu = '';
  String noidung = '';

  DonViModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['tenDonVi'];
  }

  DonViModel(
      {required this.id,
      required this.name,
      this.tenCanBo = '',
      this.chucVu = ''});
}

class Node<T> {
  late T value;
  Node<T>? parent;
  bool expand = false;
  CheckBox isCheck = CheckBox();
  int level = 0;
  List<Node<T>> children = [];

  Node(T init) {
    value = init;
  }

  Node.init(Node<T> node) {
    value = node.value;
    parent = node.parent;
    expand = node.expand;
    isCheck = node.isCheck;
  }

  Node<DonViModel>? search(Node<DonViModel> node) {
    final nodeTree = value as DonViModel;
    if (node.value.id == nodeTree.id) {
      return this as Node<DonViModel>;
    } else {
      if (children.isNotEmpty) {
        for (final vl in children) {
          final found = vl.search(node);
          if (found != null) {
            return found;
          }
        }
      }
      return null;
    }
  }

  void removeCkeckBox() {
    isCheck.isCheck = false;
    if (children.isNotEmpty) {
      for (final vl in children) {
        vl.removeCkeckBox();
      }
    }
  }

  void addChild(Node<T> child) {
    child.level = level + 1;
    children.add(child);
    child.parent = this;
  }
}

class CheckBox {
  //dùng tham chiếu để đỡ phải duyệt tree
  bool isCheck = false;
}

List<Node<DonViModel>> batTree() {
  final data = FakeDataTaoLich.dataTree;
  List<Node<DonViModel>> listTree = [];
  data.forEach((element) {
    Node<DonViModel> tree = Node(DonViModel.fromJson(element));
    tree.expand = true;
    final childern = element['children'] as List<dynamic>;
    _makeBuildTree(tree, childern);
    listTree.add(tree);
  });
  return listTree;
}

void _makeBuildTree(Node<DonViModel> tree, List<dynamic> list) {
  if (list.isNotEmpty) {
    for (var vl in list) {
      Node<DonViModel> treeNode = Node(DonViModel.fromJson(vl));
      final childern = vl['children'] as List<dynamic>;
      tree.addChild(treeNode);
      _makeBuildTree(treeNode, childern);
    }
  }
}
