import 'package:ccvc_mobile/bao_cao_module/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/bao_cao_thong_ke/bao_cao_thong_ke_don_vi.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/repository/nhiem_vu_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'bao_cao_thong_ke_state.dart';

class BaoCaoThongKeCubit extends BaseCubit<BaoCaoThongKeState> {
  BaoCaoThongKeCubit() : super(BaoCaoThongKeInitial());

  NhiemVuRepository get nhiemVuRepo => Get.find();
  BehaviorSubject<List<NhiemVuDonVi>> listBangThongKe = BehaviorSubject();

  Future<void> getDataTheoDonVi({
    String? donviId,
    String? startDate,
    String? endDate,
    String? userId,
  }) async {
    final Result<List<NhiemVuDonVi>> result =
        await nhiemVuRepo.getDataNhiemVuTheoDonVi(
      donviId: donviId,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
    result.when(
      success: (success) {
        listBangThongKe.add(success);
      },
      error: (error) {},
    );
  }
}
