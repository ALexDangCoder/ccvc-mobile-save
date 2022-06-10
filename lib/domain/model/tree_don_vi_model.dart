import 'package:ccvc_mobile/data/request/lich_hop/moi_tham_gia_hop.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';

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

  //param sử dụng tại tạo lịch làm việc
  bool? isSendEmail = false;
  int? soLuong = 0;

  String get title => '$tenCanBo ${tenDonVi.isNotEmpty ? '- $tenDonVi' : ''}';

  DonViModel({
    required this.id,
    required this.name,
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

  // MoiThamGiaHopRequest convertTrongHeThong() {
  //   return MoiThamGiaHopRequest(
  //     VaiTroThamGia: vaiTroThamGia,
  //     noiDungLamViec: noidung,
  //     tenCanBo: tenCanBo,
  //     tenDonVi:  vaiTroThamGia == 1 ? name : tenDonVi,
  //     status: status,
  //     type: type,
  //     userId: userId,
  //     donViId: vaiTroThamGia == 1
  //         ? (id.isEmpty ? null : id)
  //         : (donViId.isEmpty ? null : donViId),
  //     CanBoId: canBoId.isEmpty ? null : canBoId,
  //     chucVu: chucVu,
  //   );
  // }
  MoiThamGiaHopRequest convertTrongHeThong(String lichHopId){
    return MoiThamGiaHopRequest(
      canBoId: canBoId.isEmpty ? null : canBoId,
      donViId: vaiTroThamGia == 1
              ? (id.isEmpty ? null : id)
              : (donViId.isEmpty ? null : donViId),
      email: email,
      lichHopId: lichHopId,
      tenCanBo: tenCanBo,
       tenCoQuan: tenCoQuan,
      vaiTroThamGia: vaiTroThamGia,
      soDienThoai: sdt,
      createAt: DateTime.now().formatApiTaoBieuQuyet,
    );
  }

  MoiThamGiaHopRequest convertNgoaiHeThong(String lichHopId) {
    return MoiThamGiaHopRequest(
       dauMoiLienHe: dauMoiLienHe,
      createAt: DateTime.now().formatApiTaoBieuQuyet,
      soDienThoai: sdt,
      vaiTroThamGia: vaiTroThamGia,
      tenCoQuan: tenCoQuan,
       tenCanBo: tenCanBo,
      email: email,
      lichHopId: lichHopId,
    );
  }

  //MoiHopRequest(
//       DauMoiLienHe: dauMoiLienHe,
//       GhiChu: '',
//       TenCoQuan: tenCoQuan,
//       VaiTroThamGia: vaiTroThamGia,
//       dauMoi: dauMoiLienHe,
//       email: email,
//       noiDungLamViec: noidung,
//       soDienThoai: sdt,
//       tenDonVi: tenDonVi,
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
