import 'package:ccvc_mobile/data/request/thong_bao/setting_notify_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/setting_notify_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';

mixin ThongBaoRepository {
  Future<Result<List<ThongBaoModel>>> getNotifyAppcodes();

  Future<Result<SettingNotifyModel>> getSetting();

  Future<Result<MessageModel>> postSetting(SettingNotifyRequest body);

  Future<Result<ThongBaoQuanTrongModel>> getListThongBao({
    required String appCode,
    required bool active,
    required int seen,
    required int currentPage,
    required int pageSize,
  });

  Future<Result<ThongBaoQuanTrongModel>> getThongBaoQuanTrong({
    required bool active,
    required int seen,
    required int currentPage,
    required int pageSize,
  });

  Future<Result<MessageModel>> readAllNoti(String appCode);

  Future<Result<MessageModel>> deleteNotify(String id);
}
