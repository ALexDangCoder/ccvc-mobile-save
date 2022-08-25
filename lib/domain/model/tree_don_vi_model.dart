import 'package:ccvc_mobile/data/request/lich_hop/moi_tham_gia_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';

enum TypeFileShowDonVi {
  HO_VA_TEN,
  TEN_CAN_BO,
  CHUC_VU,
  NOI_DUNG,
  DAU_MOI_LIEN_HE,
  EMAIL,
  SDT,
  TEN_DON_VI,
  TEN_CO_QUAN,
  SO_LUONG
}

extension TypeFileShowDonViEx on TypeFileShowDonVi {
  String valueDonViModel(DonViModel donViModel) {
    switch (this) {
      case TypeFileShowDonVi.HO_VA_TEN:
        return donViModel.name;
      case TypeFileShowDonVi.TEN_CAN_BO:
        return donViModel.tenCanBo;
      case TypeFileShowDonVi.CHUC_VU:
        return donViModel.chucVu;
      case TypeFileShowDonVi.NOI_DUNG:
        return donViModel.noidung;
      case TypeFileShowDonVi.DAU_MOI_LIEN_HE:
        return donViModel.dauMoiLienHe;
      case TypeFileShowDonVi.EMAIL:
        return donViModel.email;
      case TypeFileShowDonVi.SDT:
        return donViModel.sdt;
      case TypeFileShowDonVi.TEN_DON_VI:
        return donViModel.tenDonVi;
      case TypeFileShowDonVi.TEN_CO_QUAN:
        return donViModel.tenCoQuan;
      case TypeFileShowDonVi.SO_LUONG:
        return donViModel.soLuong.toString();
    }
  }
}

class CuCanBoTreeDonVi extends DonViModel {
  String? confirmDate;
  bool? isConfirm;
  String? parentId;
  String? scheduleId;
  String? userName;
  String? hoTen;

  CuCanBoTreeDonVi.empty();

  CuCanBoTreeDonVi({
    String id = '',
    String name = '',
    String canBoId = '',
    int status = 0,
    String userId = '',
    String tenDonVi = '',
    String taskContent = '',
    String donViId = '',
    String tenCanBo = '',
    bool isXoa = false,
    this.confirmDate,
    this.isConfirm,
    this.parentId,
    this.scheduleId,
    this.userName,
    this.hoTen,
  }) : super(
          id: id,
          name: name,
          canBoId: canBoId,
          status: status,
          userId: userId,
          tenDonVi: tenDonVi,
          noidung: taskContent,
          donViId: donViId,
          isXoa: isXoa,
          tenCanBo: tenCanBo,
        );
}

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
  bool? isXoa;

  DonViModel copyWith() => DonViModel(
        id: id,
        name: name,
        tenCanBo: tenCanBo,
        chucVu: chucVu,
        canBoId: canBoId,
        noidung: noidung,
        dauMoiLienHe: dauMoiLienHe,
        email: email,
        sdt: sdt,
        vaiTroThamGia: vaiTroThamGia,
        tenDonVi: tenDonVi,
        status: status,
        type: type,
        donViId: donViId,
        userId: userId,
        tenCoQuan: tenCoQuan,
        soLuong: soLuong,
        isXoa: isXoa,
      )..isCheck = isCheck;

  //param sử dụng tại tạo lịch làm việc
  int soLuong = 0;
  String uuid = DateTime.now().microsecondsSinceEpoch.toString();

  String get title => '$tenCanBo ${tenDonVi.isNotEmpty ? '- $tenDonVi' : ''}';

  CuCanBoTreeDonVi get toCuCanBoTreeDonVi => CuCanBoTreeDonVi(
        id: id,
        name: name,
        canBoId: canBoId,
        status: status,
        userId: userId,
        tenDonVi: tenDonVi,
        taskContent: noidung,
        donViId: donViId,
        tenCanBo: tenCanBo,
      );

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
    this.soLuong = 0,
    this.isXoa,
  });

  NguoiChutriModel convertToNguoiChuTriModel() {
    return NguoiChutriModel(
      id: id,
      tenDonVi: tenDonVi,
      donViId: donViId,
      hoTen: tenCanBo,
      userId: userId,
      chucVu: chucVu,
    );
  }

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

  DonViModel.empty();
}

class Node<T> {
  late T value;
  Node<T>? parent;
  bool expand = false;
  TickChildren isTickChildren = TickChildren();
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
    isCallApi = node.isCallApi;
    isCheck = node.isCheck;
    isTickChildren = node.isTickChildren;
  }

  Node<DonViModel>? search(Node<DonViModel> node, {int? level}) {
    if (level != null) {
      final nodeTree = value as DonViModel;
      if (node.value.id == nodeTree.id && level == this.level) {
        return this as Node<DonViModel>;
      } else {
        if (children.isNotEmpty) {
          for (final vl in children) {
            final found = vl.search(node, level: level);
            if (found != null) {
              return found;
            }
          }
        }
        return null;
      }
    } else {
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
          .where((element) =>
              element.isCheck.isCheck || element.isTickChildren.isTick)
          .isNotEmpty) {
        isTickChildren.isTick = true;
      } else {
        isTickChildren.isTick = false;
      }
      return;
    } else {
      if (parent!.children
          .where((element) =>
              element.isCheck.isCheck || element.isTickChildren.isTick)
          .isNotEmpty) {
        parent!.isTickChildren.isTick = true;
      } else {
        parent!.isTickChildren.isTick = false;
      }
      parent!.isCheckTickChildren();
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

  void addChildMember(Node<T> child) {
    children.insert(0, child);
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

  Node<T>? removeFirstWhere(bool Function(T element) compare) {
    if (compare.call(value)) {
      return null;
    } else {
      for (int i = 0; i < children.length; i++) {
        if (children[i].removeFirstWhere(compare) == null) {
          children.removeAt(i);
          break;
        }
      }
      return this;
    }
  }
}

class CheckBox {
  //dùng tham chiếu để đỡ phải duyệt tree
  bool isCheck = false;

  CheckBox({this.isCheck = false});
}

class TickChildren {
  bool isTick = false;

  TickChildren({this.isTick = false});
}
