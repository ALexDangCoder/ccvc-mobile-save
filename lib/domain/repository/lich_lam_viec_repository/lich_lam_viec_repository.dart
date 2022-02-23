import 'package:ccvc_mobile/data/request/list_lich_lv/list_lich_lv_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/list_lich_lv_model.dart';

mixin LichLamViecRepository {
  Future<Result<LichLamViecDashBroad>> getLichLv(
    String startTime,
    String endTime,
  );

  Future<Result<List<LichLamViecDashBroadItem>>> getLichLvRight(
    String dateStart,
    String dateTo,
    int type,
  );

  Future<Result<DataLichLvModel>> getListLichLamViec(
    ListLichLvRequest lichLvRequest,
  );
}
