import 'dart:io';
import 'package:ccvc_mobile/data/di/module.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/get_all_files_id_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/dang_ky_thong_tin_xe_moi_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/danh_sach_bien_so_xe_request.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension QuanLyNhanDienBienSoXeCubit on DiemDanhCubit {
  Future<void> postDanhSachBienSoXe() async {
    final danhSachBienSoXeRequest = DanhSachBienSoXeRequest(
        userId: HiveLocal.getDataUser()?.userId ?? '',
        pageIndex: 1,
        pageSize: 10);
    showLoading();
    final result = await diemDanhRepo.danhSachBienSoXe(danhSachBienSoXeRequest);
    result.when(
      success: (res) {
        if (res.items?.isEmpty == true) {
          nhanDienbienSoxeSubject.sink.add(false);
        } else {
          nhanDienbienSoxeSubject.sink.add(true);
        }
        danhSachBienSoXeSubject.sink.add(res.items ?? []);
        showContent();
      },
      error: (error) {
        showContent();
      },
    );
  }

  Future xoaBienSoXe(String id) async {
    showLoading();
    final result = await diemDanhRepo.deleteBienSoXe(id);
    result.when(success: (res) {
      showContent();
    }, error: (err) {
      showContent();
    });
  }

  Future<void> dangKyThongTinXeMoi(
      String bienKiemSoat, BuildContext context) async {
    final dangKyThongTinXeMoiRequest = DangKyThongTinXeMoiRequest(
      loaiSoHuu: loaiSoHuu ?? DanhSachBienSoXeConst.XE_CAN_BO,
      userId: HiveLocal.getDataUser()?.userId ?? '',
      bienKiemSoat: bienKiemSoat,
      loaiXeMay: xeMay ?? DanhSachBienSoXeConst.XE_MAY,
    );
    showLoading();
    final result =
        await diemDanhRepo.dangKyThongTinXeMoi(dangKyThongTinXeMoiRequest);
    result.when(
      success: (res) {
        showContent();
        toast.showToast(
          child: ShowToast(
            color:colorE9F9F1 ,
            icon: ImageAssets.ic_tick_showToast,
            text: S.current.luu_du_lieu_thanh_cong,
          ),
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.pop(context,true);
      },
      error: (error) {
        showContent();
      },
    );
  }

  /// post image select
  Future<String> postImageResgiter(
    String idCreateResgiter,
    String fileTypeUpload,
    String entityName,
    List<File> files,
  ) async {
    final result = await diemDanhRepo.postFileModel(
      idCreateResgiter,
      fileTypeUpload,
      entityName,
      false,
      files,
    );
    result.when(
      success: (success) {
        MessageConfig.show(title: success.message ?? '');
        return success.data?.first;
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        return '';
      },
    );
    return '';
  }
  ///get url bien so xe
  String? getUrlImageBienSoXe({required String fileTypeUpload, String? id}) {
    if (id != null) {
      return '${getUrlDomain(baseOption: BaseURLOption.GATE_WAY)}${ApiConstants.GET_FILE}/$id/$tokken';
    }
    return null;
  }
}
