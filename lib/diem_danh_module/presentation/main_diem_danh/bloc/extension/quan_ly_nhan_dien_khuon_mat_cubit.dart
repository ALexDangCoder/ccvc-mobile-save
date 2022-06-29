import 'dart:io';

import 'package:ccvc_mobile/data/di/module.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/get_all_files_id_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/nhan_dien_khuon_mat_ui_model.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';

extension QuanLyNhanDienKhuonMatCubit on DiemDanhCubit {
  List<NhanDienKhuonMatUIModel> get listDataKhongDeoKinh => [
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChinhDien,
          title: S.current.anh_mat_nhin_chinh_dien,
          entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_CHINH_DIEN,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangPhai,
          title: S.current.anh_mat_nhin_sang_phai,
          entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_CHINH_SANG_PHAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangTrai,
          title: S.current.anh_mat_nhin_sang_trai,
          entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_CHINH_SANG_TRAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuTrenXuong,
          title: S.current.anh_chup_mat_tu_tren_xuong,
          entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_TU_TREN_XUONG,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuDuoiLen,
          title: S.current.anh_chup_mat_tu_duoi_len,
          entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_TU_DUOI_LEN,
        ),
      ];

  List<NhanDienKhuonMatUIModel> get listDataDeoKinh => [
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChinhDienDeoKinh,
          title: S.current.anh_mat_nhin_chinh_dien,
          entityName: ApiConstants.KHUON_MAT_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_CHINH_DIEN,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangPhaiDeoKinh,
          title: S.current.anh_mat_nhin_sang_phai,
          entityName: ApiConstants.KHUON_MAT_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_CHINH_SANG_PHAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhNhinSangTraiDeoKinh,
          title: S.current.anh_mat_nhin_sang_trai,
          entityName: ApiConstants.KHUON_MAT_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_CHINH_SANG_TRAI,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuTrenXuongDeoKinh,
          title: S.current.anh_chup_mat_tu_tren_xuong,
          entityName: ApiConstants.KHUON_MAT_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_TU_TREN_XUONG,
        ),
        NhanDienKhuonMatUIModel(
          image: ImageAssets.imgAnhChupMatTuDuoiLenDeoKinh,
          title: S.current.anh_chup_mat_tu_duoi_len,
          entityName: ApiConstants.KHUON_MAT_DEO_KINH,
          fileTypeUpload: ApiConstants.NHIN_TU_DUOI_LEN,
        ),
      ];

  ///get image id
  String? getImageWhenPost(
    String fileTypeUpload,
    String entityName,
  ) {
    return getUrlImage(
      fileTypeUpload: fileTypeUpload,
      entityName: entityName,
      id: idImg,
    );
  }

  ///get image deo kinh///
  Future<void> getAllImageDeoKinhId() async {
    showLoading();
    final result = await diemDanhRepo.getAllFilesId(
      GetAllFilesRequest(
        entityId: dataUser?.userId,
        entityName: ApiConstants.KHUON_MAT_DEO_KINH,
        fileTypeUpload: '',
      ),
    );

    result.when(
      success: (success) {
        allFileDeokinhSubject.add(success);
        showContent();
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        showContent();
      },
    );
  }

  ///get only id image deo kinh
  Future<void> getOnlyImageDeoKinhId(String fileTypeUpload) async {
    final result = await diemDanhRepo.getAllFilesId(
      GetAllFilesRequest(
        entityId: dataUser?.userId,
        entityName: ApiConstants.KHUON_MAT_DEO_KINH,
        fileTypeUpload: fileTypeUpload,
      ),
    );

    result.when(
      success: (success) {
        allFileDeokinhSubject.add(success);
      },
      error: (error) {
        MessageConfig.show(title: error.message);
      },
    );
  }

  /// ---------------

  /// get image khong deo kinh ///
  /// get all image khong deo kinh
  Future<void> getAllImageKhongDeoKinhId() async {
    showLoading();
    final result = await diemDanhRepo.getAllFilesId(
      GetAllFilesRequest(
        entityId: dataUser?.userId,
        entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
        fileTypeUpload: '',
      ),
    );

    result.when(
      success: (success) {
        allFileKhongDeokinhSubject.add(success);
        showContent();
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        showContent();
      },
    );
  }

  ///get only id image khong deo kinh
  Future<void> getOnlyImageKhongDeoKinhId(String fileTypeUpload) async {
    final result = await diemDanhRepo.getAllFilesId(
      GetAllFilesRequest(
        entityId: dataUser?.userId,
        entityName: ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
        fileTypeUpload: fileTypeUpload,
      ),
    );

    result.when(
      success: (success) {
        allFileKhongDeokinhSubject.add(success);
      },
      error: (error) {
        MessageConfig.show(title: error.message);
      },
    );
  }

  /// ---------------

  /// post image select
  Future<String> postImage(
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

        return success.data?.first;
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        showContent();
        return '';
      },
    );
    return '';
  }

  ///delete image
  Future<void> deleteImage(String id) async {
    showLoading();
    final result = await diemDanhRepo.deleteImage(id);

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

  ///get url image
  String? getUrlImage({
    required String fileTypeUpload,
    required String entityName,
    String? id,
  }) {
    if (id != null) {
      return '${getUrlDomain(baseOption: BaseURLOption.GATE_WAY)}${ApiConstants.GET_FILE}/$id/$tokken';
    }

    String? idImg;

    if ((entityName == ApiConstants.KHUON_MAT_DEO_KINH &&
            isImage(fileTypeUpload, ApiConstants.KHUON_MAT_DEO_KINH)) ||
        (entityName == ApiConstants.KHUON_MAT_KHONG_DEO_KINH &&
            isImage(fileTypeUpload, ApiConstants.KHUON_MAT_KHONG_DEO_KINH))) {
      idImg = findId(fileTypeUpload: fileTypeUpload, entityName: entityName);
    }

    if (idImg != null) {
      return '${getUrlDomain(baseOption: BaseURLOption.GATE_WAY)}${ApiConstants.GET_FILE}/$idImg/$tokken';
    } else {
      return null;
    }
  }

  ///check list constant image
  bool isImage(String fileTypeUpload, String entityName) {
    if (entityName == ApiConstants.KHUON_MAT_DEO_KINH) {
      for (final element
          in allFileKhongDeokinhSubject.valueOrNull?.items ?? []) {
        if (element.fileTypeUpload == fileTypeUpload) {
          return false;
        }
      }
      return true;
    } else {
      for (final element in allFileDeokinhSubject.valueOrNull?.items ?? []) {
        if (element.fileTypeUpload == fileTypeUpload) {
          return false;
        }
      }
      return true;
    }
  }

  ///find id of image
  String? findId({required String entityName, required String fileTypeUpload}) {
    if (entityName == ApiConstants.KHUON_MAT_DEO_KINH) {
      return allFileDeokinhSubject.valueOrNull?.items
          ?.firstWhere(
            (element) => element.fileTypeUpload == fileTypeUpload,
            orElse: () => FileImageModel.empty(),
          )
          .id;
    }

    if (entityName == ApiConstants.KHUON_MAT_KHONG_DEO_KINH) {
      return allFileKhongDeokinhSubject.valueOrNull?.items
          ?.firstWhere(
            (element) => element.fileTypeUpload == fileTypeUpload,
            orElse: () => FileImageModel.empty(),
          )
          .id;
    }
  }
}
