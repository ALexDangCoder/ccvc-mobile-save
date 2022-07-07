import 'dart:async';
import 'package:ccvc_mobile/domain/locals/hive_local.dart' as HiveLc;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/data/request/task_processing.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'chi_tiet_ho_tro_state.dart';

class ChiTietHoTroCubit extends BaseCubit<ChiTietHoTroState> {
  ChiTietHoTroCubit() : super(ChiTietHoTroInitial());

  String message = '';

  HoTroKyThuatRepository get _hoTroKyThuatRepository => Get.find();

  SupportDetail supportDetail = SupportDetail();

  String getCode(String value) {
    switch (value) {
      case 'Đã xử lý':
        return DA_XU_LY;
      case 'Đang xử lý':
        return DANG_XU_LY;
      case 'Từ chối xử lý':
        return TU_CHOI_XU_LY;
      case 'Chờ xử lý':
        return CHUA_XU_LY;
      default:
        return '';
    }
  }

  static const String DA_XU_LY = 'da-xu-ly';
  static const String DANG_XU_LY = 'dang-xu-ly';
  static const String CHUA_XU_LY = 'chua-xu-ly';
  static const String TU_CHOI_XU_LY = 'tu_choi-xu-ly';

  BehaviorSubject<String> selectDate = BehaviorSubject.seeded('');

  Future<void> getSupportDetail(String id) async {
    emit(ChiTietHoTroLoading());
    final result = await _hoTroKyThuatRepository.getSupportDetail(id);
    result.when(
      success: (res) {
        final DateFormat dateFormat =
            DateFormat(DateTimeFormat.DATE_BE_RESPONSE_FORMAT);
        if (res.ngayHoanThanh != null) {
          final ngayHoanThanh = DateTime.parse(
            (res.ngayHoanThanh ?? '').replaceAll('T', ' '),
          );
          res.ngayHoanThanh = dateFormat.format(ngayHoanThanh);
        }
        if (res.thoiGianYeuCau != null) {
          final ngayYeuCau = DateTime.parse(
            (res.thoiGianYeuCau ?? '').replaceAll('T', ' '),
          );
          res.thoiGianYeuCau = dateFormat.format(ngayYeuCau);
        }
        getNguoiXuLy(res);
      },
      error: (error) {
        emit(
          ChiTietHoTroSuccess(
            completeType: CompleteType.ERROR,
            errorMess: error.message,
          ),
        );
      },
    );
  }

  bool isItSupport = false;

  final dataUser = HiveLc.HiveLocal.getDataUser();

  void checkUser(
    List<ThanhVien> list,
    SupportDetail? supportDetail,
  ) {
    for (final element in list) {
      if (element.userId == dataUser?.userId) {
        isItSupport = true;
      }
    }
    emit(
      ChiTietHoTroSuccess(
        completeType: CompleteType.SUCCESS,
        supportDetail: supportDetail,
      ),
    );
  }

  Future<void> capNhatTHXL({
    required String id,
    required String taskId,
    required String comment,
    required String code,
    required String name,
    required String finishDay,
    required String handlerId,
    required String description,
  }) async {
    print(finishDay);
    final TaskProcessing model = TaskProcessing(
      id: id,
      taskId: taskId,
      comment: comment,
      code: getCode(code),
      name: name,
      finishDay:
          DateFormat(DateTimeFormat.DATE_FORMAT_TEXT_FIELD).parse(finishDay),
      handlerId: getHandlerId(handlerId),
      description: description,
    );
    showLoading();
    final result = await _hoTroKyThuatRepository.updateTaskProcessing(
      model,
    );
    result.when(
      success: (res) {
        getSupportDetail(supportDetail.id ?? '');
      },
      error: (error) {},
    );
  }

  List<String> listItSupport = [];
  List<ThanhVien> listThanhVien = [];

  String getHandlerId(String name) {
    for (final element in listThanhVien) {
      if (element.tenThanhVien == name) {
        return element.idThanhVien ?? '';
      }
    }
    return '';
  }

  Future<void> getNguoiXuLy(SupportDetail? supportDetail) async {
    listItSupport.clear();
    listThanhVien.clear();
    final result = await _hoTroKyThuatRepository.getNguoiXuLy();
    result.when(
      success: (res) {
        for (int i = 0; i < res.length - 1; i++) {
          for (int j = 1; j < res.length; j++) {
            if (res[i].tenThanhVien == res[j].tenThanhVien) {
              res.removeAt(j);
            }
          }
        }
        checkUser(
          res,
          supportDetail,
        );
        for (final element in res) {
          listItSupport.add(element.tenThanhVien ?? '');
          listThanhVien.add(element);
        }
      },
      error: (error) {},
    );
  }
}
