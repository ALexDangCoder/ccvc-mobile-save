import 'package:ccvc_mobile/data/response/lich_lam_viec_dashbroad/lich_lam_viec_dashbroad_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec_dashbroad/lich_lam_viec_dashbroad_right_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/lich_lam_viec_service/lich_lam_viec_service.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/repository/lich_lam_viec_repository/lich_lam_viec_repository.dart';

class LichLamViecImlp implements LichLamViecRepository {
  LichLamViecService lichLamViecService;

  LichLamViecImlp(this.lichLamViecService);

  @override
  Future<Result<LichLamViecDashBroad>> getLichLv(
    String startTime,
    String endTime,
  ) {
    return runCatchingAsync<LichLamViecDashBroadResponse, LichLamViecDashBroad>(
      () => lichLamViecService.getLichLamViec(startTime, endTime),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<List<LichLamViecDashBroadItem>>> getLichLvRight(
    String dateStart,
    String dateTo,
    int type,
  ) {
    return runCatchingAsync<LichLamViecDashBroadRightResponse,
        List<LichLamViecDashBroadItem>>(
      () => lichLamViecService.getLichLamViecRight(
        dateStart,
        dateTo,
        type,
      ),
      (response) => response.toDomain(),
    );
  }
}
