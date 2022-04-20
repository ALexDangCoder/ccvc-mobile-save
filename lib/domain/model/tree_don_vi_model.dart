class DonViModel {
  // DauMoiLienHe: ""
  // Email: "1@1.com"
  // GhiChu: "1"
  // SoDienThoai: "13456446313"
  // TenCoQuan: "1"
  // VaiTroThamGia: 5
  // dauMoi: ""
  // email: "1@1.com"
  // id: null
  // noiDungLamViec: "1"
  // soDienThoai: "13456446313"
  // tenCanBo: "1"
  // tenDonVi: "1"

  String id = '';
  String dauMoiLienHe = '';
  String email = '';
  String sdt = '';
  int VaiTroThamGia = 0;
  String tenDonVi = '';
  String name = '';
  String tenCanBo = '';
  String chucVu = '';
  String canBoId = '';
  String noidung = '';

  DonViModel({
    required this.id,
    required this.name,
    this.dauMoiLienHe = '',
    this.email = '',
    this.sdt = '',
    this.VaiTroThamGia = 0,
    this.tenDonVi = '',
    this.tenCanBo = '',
    this.chucVu = '',
    this.canBoId = '',
    this.noidung = '',
  });
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

  Node.copyWith(Node<T> node) {
    value = node.value;
    parent = node.parent;
    expand = node.expand;
    isCheck = node.isCheck;
    level = node.level;
  }

  Node<T> coppyWith() {
    final Node<T> node = Node.copyWith(this);
    for (final vl in children) {
      node.addChild(vl.coppyWith());
    }
    return node;
  }
}

class CheckBox {
  //dùng tham chiếu để đỡ phải duyệt tree
  bool isCheck = false;

  CheckBox({this.isCheck = false});
}
