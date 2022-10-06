import 'dart:io';

import 'package:ccvc_mobile/data/di/module.dart';
import 'package:ccvc_mobile/diem_danh_module/data/request/create_image_request.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_khuon_mat/get_all_files_id_model.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/main_diem_danh/bloc/diem_danh_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/quan_ly_nhan_dien_khuon_mat/ui/mobile/nhan_dien_khuon_mat_ui_model.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
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
  Future<void> getAllImageId({required String entityName}) async {
    showLoading();
    final result = await diemDanhRepo.getAllFilesId(
      dataUser?.userId ?? '',
    );

    result.when(
      success: (success) {
        if (entityName == ApiConstants.KHUON_MAT_KHONG_DEO_KINH) {
          final List<GetAllFilesIdModel> data = success
              .where(
                (element) =>
                    element.loaiAnh == ApiConstants.KHUON_MAT_KHONG_DEO_KINH,
              )
              .toList();
          allFileKhongDeokinhSubject.add(data);
        }

        if (entityName == ApiConstants.KHUON_MAT_DEO_KINH) {
          final List<GetAllFilesIdModel> data = success
              .where(
                (element) =>
                    element.loaiAnh == ApiConstants.KHUON_MAT_DEO_KINH,
              )
              .toList();
          allFileDeokinhSubject.add(data);
        }
        showContent();
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        showContent();
      },
    );
  }

  /// ---------------

  /// post image select
  Future<String> uploadFile({
    required String loaiGocAnh,
    required String loaiAnh,
    required File file,
  }) async {
    String idImg = '';
    showLoading();
    idImg = await postImage(file);
    await createImage(
      fileId: idImg,
      loaiGocAnh: loaiGocAnh,
      loaiAnh: loaiAnh,
    );

    showContent();
    return idImg;
  }

  ///create image
  Future<String> createImage({
    required String fileId,
    required String loaiGocAnh,
    required String loaiAnh,
  }) async {
    showLoading();
    String id = '';
    final result = await diemDanhRepo.createImage(
      CreateImageRequest(
        userId: dataUser?.userId ?? '',
        fileId: fileId,
        loaiGocAnh: loaiGocAnh,
        loaiAnh: loaiAnh,
      ),
    );

    result.when(
      success: (success) {
        id = success.data?.id ?? '';
        if (success.statusCode == 200) {
          MessageConfig.show(title: success.message ?? '');
        }
        showContent();
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        showContent();
      },
    );

    return id;
  }

  ///upload file
  Future<String> postImage(
    File file,
  ) async {
    showLoading();
    final result = await diemDanhRepo.postFileKhuonMat(
      dataUser?.userId ?? '',
      ApiConstants.ANH_KHUON_MAT,
      false,
      file,
    );
    String idImg = '';
    result.when(
      success: (success) {
        idImg = success.data ?? '';
        checkAiKhuonMat(idImg);
        showContent();
      },
      error: (error) {
        MessageConfig.show(title: error.message);
        showContent();
      },
    );
    return idImg;
  }

  ///Check checkAiKhuonMat
  Future<void> checkAiKhuonMat(
    String fileId,
  ) async {
    showLoading();
    final result = await diemDanhRepo.checkAiKhuonMat(fileId);

    result.when(
      success: (success) {
        codeCheckAi.sink.add(success.statusCode ?? 0);
        if (success.statusCode == 400) {
          MessageConfig.show(
            title: S.current.anh_khong_hop_le,
            messState: MessState.error,
          );
        }
        showContent();
      },
      error: (error) {
        showContent();
      },
    );
  }

  Future<void> deleteImageCallApi(String id) async {
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

  Future<void> xoaAnhAI(String fileId) async {
    showLoading();
    final result = await diemDanhRepo.xoaAnhAI(
      fileId,
      HiveLocal.getDataUser()?.userId ?? '',
    );
    result.when(
      success: (success) {
        showContent();
      },
      error: (error) {
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
      return '${getUrlDomain(baseOption: BaseURLOption.GATE_WAY)}${ApiConstants.HIEN_THI_ANH}/$id/$tokken';
    }

    String? idImg;

    if ((entityName == ApiConstants.KHUON_MAT_DEO_KINH &&
            isImage(fileTypeUpload, ApiConstants.KHUON_MAT_DEO_KINH)) ||
        (entityName == ApiConstants.KHUON_MAT_KHONG_DEO_KINH &&
            isImage(fileTypeUpload, ApiConstants.KHUON_MAT_KHONG_DEO_KINH))) {
      idImg =
          findFileId(fileTypeUpload: fileTypeUpload, entityName: entityName);
    }

    if (idImg != null) {
      return '${getUrlDomain(baseOption: BaseURLOption.GATE_WAY)}${ApiConstants.HIEN_THI_ANH}/$idImg/$tokken';
    } else {
      return null;
    }
  }

  ///check list constant image
  bool isImage(String fileTypeUpload, String entityName) {
    if (entityName == ApiConstants.KHUON_MAT_DEO_KINH) {
      for (final GetAllFilesIdModel element
          in allFileDeokinhSubject.valueOrNull ?? []) {
        if (element.loaiGocAnh == fileTypeUpload) {
          return true;
        }
      }
      return false;
    } else {
      for (final GetAllFilesIdModel element
          in allFileKhongDeokinhSubject.valueOrNull ?? []) {
        if (element.loaiGocAnh == fileTypeUpload) {
          return true;
        }
      }
      return false;
    }
  }

  ///find id of image
  String? findId({required String entityName, required String fileTypeUpload}) {
    if (entityName == ApiConstants.KHUON_MAT_DEO_KINH) {
      return allFileDeokinhSubject.valueOrNull
          ?.firstWhere(
            (element) => element.loaiGocAnh == fileTypeUpload,
            orElse: () => GetAllFilesIdModel.empty(),
          )
          .id;
    }

    if (entityName == ApiConstants.KHUON_MAT_KHONG_DEO_KINH) {
      return allFileKhongDeokinhSubject.valueOrNull
          ?.firstWhere(
            (element) => element.loaiGocAnh == fileTypeUpload,
            orElse: () => GetAllFilesIdModel.empty(),
          )
          .id;
    }
  }

  ///find fileId of image
  String? findFileId({
    required String entityName,
    required String fileTypeUpload,
  }) {
    if (entityName == ApiConstants.KHUON_MAT_DEO_KINH) {
      return allFileDeokinhSubject.valueOrNull
          ?.firstWhere(
            (element) => element.loaiGocAnh == fileTypeUpload,
            orElse: () => GetAllFilesIdModel.empty(),
          )
          .fileId;
    }

    if (entityName == ApiConstants.KHUON_MAT_KHONG_DEO_KINH) {
      return allFileKhongDeokinhSubject.valueOrNull
          ?.firstWhere(
            (element) => element.loaiGocAnh == fileTypeUpload,
            orElse: () => GetAllFilesIdModel.empty(),
          )
          .fileId;
    }
  }
}
