import 'package:ccvc_mobile/data/request/lich_hop/moi_tham_gia_hop.dart';

class DonViModel {
  String id = '';
  String name = '';
  String tenCanBo = '';
  String chucVu = '';
  String canBoId = '';
  String noidung = '';
  String dauMoiLienHe = '';
  String email = '';
  String sdt = '';
  int vaiTroThamGia = 0;
  String tenDonVi = '';
  int status = 0;
  int type = 0;
  String donViId = '';
  String userId = '';
  String tenCoQuan = '';
  bool isCheck = false;

  //param sử dụng tại tạo lịch làm việc
  int? soLuong = 0;
  String uuid = DateTime.now().microsecondsSinceEpoch.toString();

  String get title => '$tenCanBo ${tenDonVi.isNotEmpty ? '- $tenDonVi' : ''}';

  DonViModel({
    this.id = '',
    this.name = '',
    this.tenCanBo = '',
    this.chucVu = '',
    this.canBoId = '',
    this.dauMoiLienHe = '',
    this.noidung = '',
    this.email = '',
    this.sdt = '',
    this.vaiTroThamGia = 0,
    this.tenDonVi = '',
    this.status = 0,
    this.type = 0,
    this.donViId = '',
    this.userId = '',
    this.tenCoQuan = '',
    this.soLuong,
  });

  MoiThamGiaHopRequest convertTrongHeThong(String lichHopId) {
    return MoiThamGiaHopRequest(
      canBoId: userId.isEmpty ? null : userId,
      donViId: vaiTroThamGia == 1
          ? (id.isEmpty ? null : id)
          : (donViId.isEmpty ? null : donViId),
      vaiTroThamGia: vaiTroThamGia,
      DonViId: vaiTroThamGia == 1
          ? (id.isEmpty ? null : id)
          : (donViId.isEmpty ? null : donViId),
      chucVu: chucVu,
      hoTen: tenCanBo,
      status: status,
      tenDonVi: tenDonVi,
      type: type,
      userId: userId,
    );
  }

  MoiThamGiaHopRequest convertNgoaiHeThong(String lichHopId) {
    return MoiThamGiaHopRequest(
      dauMoiLienHe: dauMoiLienHe,
      email: email,
      GhiChu: '',
      soDienThoai: sdt,
      TenCoQuan: tenCoQuan.isEmpty ? tenDonVi : tenCoQuan,
      vaiTroThamGia: vaiTroThamGia,
      dauMoi: dauMoiLienHe,
      Email: email,
      noiDungLamViec: noidung,
      SoDienThoai: sdt,
      tenCanBo: tenCanBo,
      tenDonVi: tenDonVi,
    );
  }
}

class Node<T> {
  late T value;
  Node<T>? parent;
  bool expand = false;
  bool isTickChildren = false;
  bool isCallApi = false;
  CheckBox isCheck = CheckBox();
  int level = 0;
  List<Node<T>> children = [];

  Node(T init) {
    value = init;
  }

  List<T> toList() {
    final res = <T>[];
    res.add(value);
    for (final Node<T> e in children) {
      res.addAll(e.toList());
    }
    return res;
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

  List<DonViModel> setSelected(bool isSelected) {
    final listChildren = <DonViModel>[];
    isCheck.isCheck = isSelected;
    setSelectedAllChild(isSelected, children, listChildren);
    return listChildren;
  }

  void setSelectedAllChild(
      bool isSelected, List<Node> children, List<DonViModel> listChildren) {
    for (int i = 0; i < children.length; i++) {
      children[i].isCheck.isCheck = isSelected;
      listChildren.add(children[i].value);
      if (children[i].children.isNotEmpty) {
        setSelectedAllChild(isSelected, children[i].children, listChildren);
      }
    }
  }

  bool isCheckALl() {
    if (children.isEmpty) {
      return isCheck.isCheck;
    }
    final dataCheck = children.map((e) => e.isCheck.isCheck);
    isCheck.isCheck = !dataCheck.contains(false);
    return !children.map((e) => e.isCheck.isCheck).contains(false);
  }

  void isCheckTickChildren() {
    if (parent == null) {
      if (children
          .where((element) => element.isCheck.isCheck || element.isTickChildren)
          .isNotEmpty) {
        isTickChildren = true;
      } else {
        isTickChildren = false;
      }
      return;
    } else {
      if (parent!.children
          .where((element) => element.isCheck.isCheck  || element.isTickChildren)
          .isNotEmpty) {
        parent!.isTickChildren = true;
      } else {
        parent!.isTickChildren = false;
      }
      parent!.isCheckTickChildren();
    }
    if(!isCheck.isCheck) {
      isTickChildren = false;
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
