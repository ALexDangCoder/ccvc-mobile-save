import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/model/lich_am_duong.dart';
import 'package:ccvc_mobile/tien_ich_module/domain/repository/tien_ich_repository.dart';
import 'package:ccvc_mobile/tien_ich_module/presentation/lich_am_duong/bloc/lich_am_duong_state.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class LichAmDuongCubit extends BaseCubit<LichAmDuongState> {
  LichAmDuongCubit() : super(MainStateInitial());

  TienIchRepository get lichAmDuongRep => Get.find();
  BehaviorSubject<LichAmDuong> lichAmDuongSubject = BehaviorSubject();

  Stream<LichAmDuong> get lichAmDuongStream => lichAmDuongSubject.stream;
  String startDate = DateTime.now().formatApiDDMMYYYY;
  DateTime selectTime = DateTime.now();
  BehaviorSubject<DateTime> changeDateTimeSubject = BehaviorSubject();
  DateTime time = DateTime.now();

  bool selectDay(DateTime day) {
    return selectTime.year == day.year &&
        selectTime.month == day.month &&
        selectTime.day == day.day;
  }

  void callApi() {
    getLichAmDuong(startDate);
  }

  Future<void> getLichAmDuong(String date) async {
    showLoading();
    final result = await lichAmDuongRep.getLichAmDuong(date);
    result.when(
      success: (res) {
        lichAmDuongSubject.add(res);
        showContent();
      },
      error: (error) {},
    );
  }

  void listeningStartDataTime(DateTime dateAndTime) {
    startDate = dateAndTime.formatApiDDMMYYYY;
  }
}
