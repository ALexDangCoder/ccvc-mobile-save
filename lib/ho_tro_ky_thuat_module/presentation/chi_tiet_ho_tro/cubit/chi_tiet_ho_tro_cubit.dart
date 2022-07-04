import 'dart:async';
import 'package:ccvc_mobile/domain/locals/hive_local.dart' as HiveLc;
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/repository/ho_tro_ky_thuat_repository.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'chi_tiet_ho_tro_state.dart';

class ChiTietHoTroCubit extends BaseCubit<ChiTietHoTroState> {
  ChiTietHoTroCubit() : super(ChiTietHoTroInitial());

  final dataUser = HiveLc.HiveLocal.getDataUser();
  String message = '';

  HoTroKyThuatRepository get _hoTroKyThuatRepository => Get.find();

  SupportDetail supportDetail = SupportDetail();

  Future<void> getSupportDetail(String id) async {
    emit(ChiTietHoTroLoading());
    final result = await _hoTroKyThuatRepository.getSupportDetail(id);
    result.when(
      success: (res) {
        emit(
          ChiTietHoTroSuccess(
            completeType: CompleteType.SUCCESS,
            supportDetail: res,
          ),
        );
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

  Future<void> getNguoiXuLy() async {
    final result = await _hoTroKyThuatRepository.getNguoiXuLy();
    result.when(success: (res) {}, error: (error) {});
  }
}
