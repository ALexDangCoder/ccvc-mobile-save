import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/repository/diem_danh_repository.dart';
import 'package:ccvc_mobile/diem_danh_module/presentation/bloc/diem_danh_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class DiemDanhCubit extends BaseCubit<DiemDanhState> {
  DiemDanhCubit() : super(const DiemDanhStateIntial());

  DiemDanhRepository get repo => Get.find();
  BehaviorSubject<List<bool>> selectTypeDiemDanhSubject =
      BehaviorSubject.seeded([true, false, false]);
}
