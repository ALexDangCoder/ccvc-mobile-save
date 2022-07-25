import 'package:ccvc_mobile/data/di/module.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/diem_danh_module/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/cap_nhat_bien_so_xe_request.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/dang_ky_thong_tin_xe_moi_request.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/dialog/show_toast.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension QuanLyNhanDienBienSoXeCubit on DiemDanhCubit {
  Future<void> getDanhSachBienSoXe() async {
    showLoading();
    final result = await diemDanhRepo.danhSachBienSoXe(
      HiveLocal.getDataUser()?.userId ?? '',
      ApiConstants.PAGE_BEGIN,
      ApiConstants.DEFAULT_PAGE_SIZE,
    );
    result.when(
      success: (res) {
        if (res.items?.isEmpty == true) {
          nhanDienbienSoxeSubject.sink.add(false);
        } else {
          nhanDienbienSoxeSubject.sink.add(true);
        }
        danhSachBienSoXeSubject.sink.add(res.items ?? []);
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        }
      },
    );
    showContent();
  }

  Future<void> xoaBienSoXe(String id) async {
    showLoading();
    final result = await diemDanhRepo.deleteBienSoXe(id);
    result.when(
      success: (res) {
        showContent();
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        }
        showContent();
      },
    );
  }

  Future<void> dangKyThongTinXeMoi(
      {required String bienKiemSoat,
      required String fileId,
      required BuildContext context}) async {
    final dangKyThongTinXeMoiRequest = DangKyThongTinXeMoiRequest(
      loaiSoHuu: loaiSoHuu ?? DanhSachBienSoXeConst.XE_CAN_BO,
      userId: HiveLocal.getDataUser()?.userId ?? '',
      bienKiemSoat: bienKiemSoat,
      loaiXeMay: xeMay ?? DanhSachBienSoXeConst.XE_MAY,
      fileId: fileId,
    );
    showLoading();
    final result =
        await diemDanhRepo.dangKyThongTinXeMoi(dangKyThongTinXeMoiRequest);
    result.when(
      success: (res) {
        eventBus.fire(ApiSuccessAttendance(false));
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        }
      },
    );
    showContent();
  }

  ///update number plate, driver license
  Future<void> capNhatBienSoxe({
    required String bienKiemSoat,
    required String id,
    required String fileId,
    required BuildContext context,
  }) async {
    showLoading();
    final capNhatBienSoXeRequest = CapNhatBienSoXeRequest(
      id: id,
      loaiSoHuu: loaiSoHuu ?? DanhSachBienSoXeConst.XE_CAN_BO,
      userId: HiveLocal.getDataUser()?.userId ?? '',
      bienKiemSoat: bienKiemSoat,
      loaiXeMay: xeMay ?? DanhSachBienSoXeConst.XE_MAY,
      fileId: fileId,
    );
    final result = await diemDanhRepo.capNhatBienSoXe(capNhatBienSoXeRequest);
    result.when(
      success: (res) {
        toast.showToast(
          child: ShowToast(
            color: colorE9F9F1,
            icon: ImageAssets.ic_tick_showToast,
            text: S.current.luu_du_lieu_thanh_cong,
          ),
          gravity: ToastGravity.BOTTOM,
        );
        eventBus.fire(ApiSuccessAttendance(true));
      },
      error: (error) {
        if (error is NoNetworkException || error is TimeoutException) {
          MessageConfig.show(
            title: S.current.no_internet,
            messState: MessState.error,
          );
        }
      },
    );
    showContent();
  }

  ///delete image
  Future<void> deleteImage(String id) async {
    showLoading();
    final result = await diemDanhRepo.deleteImage(id);
    result.when(
      success: (success) {
        showContent();
      },
      error: (error) {
        showContent();
      },
    );
  }

  /// post image select
  Future<String> postImageResgiter({
    required bool isTao,
    required String bienKiemSoat,
    String? id,
    String? fileId,
    required BuildContext context,
  }) async {
    showLoading();
    final result = await diemDanhRepo.postFileModel(
      '',
      ApiConstants.BIEN_SO_XE_TYPE,
      ApiConstants.BIEN_SO_XE_ENTITY,
      false,
      fileItemBienSoXe,
    );
    result.when(
      success: (success) {
        if (isTao) {
          dangKyThongTinXeMoi(
            bienKiemSoat: bienKiemSoat,
            fileId: success.data?.first ?? '',
            context: context,
          );
        } else {
          capNhatBienSoxe(
            bienKiemSoat: bienKiemSoat,
            id: id ?? '',
            fileId: success.data!.isEmpty
                ? (fileId ?? '')
                : success.data?.first ?? '',
            context: context,
          );
        }
      },
      error: (error) {
        return '';
      },
    );
    return '';
  }

  ///get url bien so xe
  String? getUrlImageBienSoXe(String? id) {
    if (id != null) {
      return '${getUrlDomain(baseOption: BaseURLOption.GATE_WAY)}${ApiConstants.GET_FILE}/$id/$tokken';
    }
    return null;
  }
}
