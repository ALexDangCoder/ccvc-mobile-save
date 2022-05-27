import 'package:ccvc_mobile/domain/model/luong_xu_ly/don_vi_xu_ly_vb_den.dart';
import 'package:ccvc_mobile/domain/model/node_phan_xu_ly.dart';

class LuongXuLyVanBanDenResponse {
  List<dynamic>? data;

  bool? isSuccess;

  LuongXuLyVanBanDenResponse({this.data, this.isSuccess});

  LuongXuLyVanBanDenResponse.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = json['Data'];
    }

    isSuccess = json['IsSuccess'];
  }

  NodePhanXuLy<DonViLuongModel>? toDomain() {
    if (data?.isNotEmpty ?? false) {
      final rootTree = data?.last ?? {};
      NodePhanXuLy<DonViLuongModel> node = NodePhanXuLy<DonViLuongModel>(
          Item.fromJson(rootTree['Item']).toDomain());
      _makeBuildTree(node, rootTree['Children'] ?? []);
      return node;
    }
  }

  void _makeBuildTree(
      NodePhanXuLy<DonViLuongModel> node, List<dynamic> children) {
    if (children.isNotEmpty) {
      for (var element in children) {
        Map<String, dynamic> data = element as Map<String, dynamic>;

        NodePhanXuLy<DonViLuongModel> nodeTree = NodePhanXuLy<DonViLuongModel>(
          Item.fromJson(data['Item']).toDomain(),
        );

        node.addChild(nodeTree);
        _makeBuildTree(nodeTree, data['Children']);
      }
    }
  }
}

class Item {
  String? id;
  String? parentId;
  String? ten;
  String? tenNguoiTao;
  String? maTrangThai;
  String? trangThai;
  String? tenDonVi;
  String? vaiTro;

  String? taskId;
  String? canBoTaoId;
  String? type;
  String? chucVu;
  int? level;
  String? avatar;
  String? avatarCommon;
  bool? isBaoCaoLanhDao;
  bool? isCaNhan;

  Item(
      {this.id,
      this.parentId,
      this.ten,
      this.tenNguoiTao,
      this.maTrangThai,
      this.trangThai,
      this.tenDonVi,
      this.vaiTro,
      this.taskId,
      this.canBoTaoId,
      this.type,
      this.chucVu,
      this.level});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    parentId = json['ParentId'];
    ten = json['Ten'];
    tenNguoiTao = json['TenNguoiTao'];
    maTrangThai = json['MaTrangThai'];
    trangThai = json['TrangThai'];
    tenDonVi = json['TenDonVi'];
    vaiTro = json['VaiTro'];
    avatar = json['Avatar'];
    taskId = json['TaskId'];
    canBoTaoId = json['CanBoTaoId'];
    type = json['Type'];
    chucVu = json['ChucVu'];
    level = json['Level'];
    avatarCommon = json['AvatarCommon'];
    isBaoCaoLanhDao = json['IsBaoCaoLanhDao'];
    isCaNhan = json['IsCaNhan'];
  }

  DonViLuongModel toDomain() => DonViLuongModel(
      parentId: parentId,
      ten: ten,
      tenNguoiTao: tenNguoiTao,
      maTrangThai: maTrangThai,
      trangThai: trangThai,
      tenDonVi: tenDonVi,
      vaiTro: vaiTro,
      avatar: avatar,
      avatarCommon: avatarCommon,
      isBaoCaoLanhDao: isBaoCaoLanhDao,
      taskId: taskId,
      canBoTaoId: canBoTaoId,
      type: type,
      chucVu: chucVu,
      level: level,
      isCaNhan: isCaNhan);
}
