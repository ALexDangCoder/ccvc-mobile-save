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
    final thongKeDiemDanhCaNhanRequest = DanhSachBienSoXeRequest(
      userId: HiveLocal.getDataUser()?.userId ?? '',
    );
    showLoading();
    final result =
        await diemDanhRepo.danhSachBienSoXe(thongKeDiemDanhCaNhanRequest);
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

  Future<void> dangKyThongTinXeMoi(String bienKiemSoat,BuildContext context) async {
    final dangKyThongTinXeMoiRequest = DangKyThongTinXeMoiRequest(
      loaiSoHuu: loaiSoHuu??DanhSachBienSoXeConst.XE_CAN_BO,
      userId: HiveLocal.getDataUser()?.userId ?? '',
      bienKiemSoat: bienKiemSoat,
      loaiXeMay: xeMay??DanhSachBienSoXeConst.XE_MAY,
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
}
