
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/luong_xu_ly_nhiem_vu_model.dart';

class XemLuongXuLyNhiemVuResponse {
  dynamic data;

  bool? isSuccess;

  XemLuongXuLyNhiemVuResponse({this.data, this.isSuccess});

  XemLuongXuLyNhiemVuResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = json['Data'];
    }

    isSuccess = json['IsSuccess'];
  }

  NodePhanXuLy<DonViLuongNhiemVuModel>? toDomain() {
    if (data?.isNotEmpty ?? false) {
      final rootTree = data ?? {};

      NodePhanXuLy<DonViLuongNhiemVuModel> node =
          NodePhanXuLy<DonViLuongNhiemVuModel>(
              Data.fromJson(rootTree).toDomain());
      _makeBuildTree(node, rootTree['children'] ?? []);
      return node;
    }
  }

  void _makeBuildTree(
      NodePhanXuLy<DonViLuongNhiemVuModel> node, List<dynamic> children) {
    if (children.isNotEmpty) {
      for (var element in children) {
        Map<String, dynamic> data = element as Map<String, dynamic>;

        NodePhanXuLy<DonViLuongNhiemVuModel> nodeTree =
            NodePhanXuLy<DonViLuongNhiemVuModel>(
          Data.fromJson(data).toDomain(),
        );

        node.addChild(nodeTree);
        _makeBuildTree(nodeTree, data['children']);
      }
    }
  }
}

class Data {
  String? id;
  String? ten;
  String? tenNguoiTao;
  String? trangThai;
  String? maTrangThai;
  String? tenDonVi;
  String? vaiTro;
  String? chucVu;
  Data(
      {this.id,
      this.ten,
      this.trangThai,
      this.maTrangThai,
      this.tenDonVi,
      this.tenNguoiTao,
      this.vaiTro});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    tenNguoiTao = json['tenNguoiTao'];
    trangThai = json['trangThai'];
    maTrangThai = json['maTrangThai'];
    tenDonVi = json['tenDonVi'];
    vaiTro = json['vaiTro'];
    chucVu = json['chucVu'];
  }

  DonViLuongNhiemVuModel toDomain() => DonViLuongNhiemVuModel(
      taskId: id,
      ten: ten,
      trangThai: trangThai,
      maTrangThai: maTrangThai,
      tenDonVi: tenDonVi,
      tenNguoiTao: tenNguoiTao,
      vaiTro: vaiTro,
    chucVu: chucVu ?? '',
  );
}
