import 'dart:io';

import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/nhan_dien_khuon_mat_ui_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/type_api_diem_danh.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:image_picker/image_picker.dart';

extension QuanLyNhanDienKhuonMatCubit on DiemDanhCubit {
  List<NhanDienKhuonMatUIModel> get listDataKhongDeoKinh => [
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChinhDien,
          title: S.current.anh_mat_nhin_chinh_dien,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_CHINH_DIEN,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangPhai,
          title: S.current.anh_mat_nhin_sang_phai,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_CHINH_SANG_PHAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangTrai,
          title: S.current.anh_mat_nhin_sang_trai,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_CHINH_SANG_TRAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuTrenXuong,
          title: S.current.anh_chup_mat_tu_tren_xuong,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_TU_TREN_XUONG,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuDuoiLen,
          title: S.current.anh_chup_mat_tu_duoi_len,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_TU_DUOI_LEN,
        ),
      ];

  List<NhanDienKhuonMatUIModel> get listDataDeoKinh => [
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChinhDienDeoKinh,
          title: S.current.anh_mat_nhin_chinh_dien,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_CHINH_DIEN,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangPhaiDeoKinh,
          title: S.current.anh_mat_nhin_sang_phai,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_CHINH_SANG_PHAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangTraiDeoKinh,
          title: S.current.anh_mat_nhin_sang_trai,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_CHINH_SANG_TRAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuTrenXuongDeoKinh,
          title: S.current.anh_chup_mat_tu_tren_xuong,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_TU_TREN_XUONG,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuDuoiLenDeoKinh,
          title: S.current.anh_chup_mat_tu_duoi_len,
          entityName: TypeApiDiemDanh.KHUON_MAT,
          fileTypeUpload: TypeApiDiemDanh.NHIN_TU_DUOI_LEN,
        ),
      ];

  /// Get from gallery
  Future<void> getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      imagePickerSubject.add(File(image.path));
    }
  }

  Future<void> postImage(
    String fileTypeUpload,
    String entityName,
    List<File> files,
  ) async {
    showLoading();
    final result = await diemDanhRepo.postFileModel(
      dataUser?.userId ?? '',
      fileTypeUpload,
      entityName,
      false,
      files,
    );

    result.when(
      success: (success) {
        MessageConfig.show(title: success.message ?? '');
        showContent();
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        showContent();
      },
    );
  }
}
