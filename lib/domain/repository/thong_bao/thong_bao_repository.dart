import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/message_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_quan_trong_model.dart';

mixin ThongBaoRepository {
  Future<Result<List<ThongBaoModel>>> getNotifyAppcodes();

  Future<Result<ThongBaoQuanTrongModel>> getThongBaoQuanTrong({
    required String appCode,
    required bool active,
    required int seen,
    required int currentPage,
    required int pageSize,
  });

  Future<Result<MessageModel>> deleteNotify(String id);
}
