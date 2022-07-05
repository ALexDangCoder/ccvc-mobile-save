import 'dart:async';
import 'package:ccvc_mobile/domain/locals/hive_local.dart' as HiveLc;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
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

  final dataUser = HiveLc.HiveLocal.getDataUser();
  String message = '';

  HoTroKyThuatRepository get _hoTroKyThuatRepository => Get.find();

  SupportDetail supportDetail = SupportDetail();


  BehaviorSubject<String> selectDate = BehaviorSubject.seeded('');

  Future<void> getSupportDetail(String id) async {
    emit(ChiTietHoTroLoading());
    final result = await _hoTroKyThuatRepository.getSupportDetail(id);
    result.when(
      success: (res) {
        final ngayHoanThanh = DateTime.parse(
          (res.ngayHoanThanh ?? '').replaceAll('T', ' '),
        );
        final ngayYeuCau = DateTime.parse(
          (res.thoiGianYeuCau ?? '').replaceAll('T', ' '),
        );
        final DateFormat dateFormat =
            DateFormat(DateTimeFormat.DATE_BE_RESPONSE_FORMAT);
        res.ngayHoanThanh = dateFormat.format(ngayHoanThanh);
        res.thoiGianYeuCau = dateFormat.format(ngayYeuCau);
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

  List<String> listItSupport = [];

  Future<void> getNguoiXuLy(SupportDetail? supportDetail) async {
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
        }
      },
      error: (error) {},
    );
  }
}
