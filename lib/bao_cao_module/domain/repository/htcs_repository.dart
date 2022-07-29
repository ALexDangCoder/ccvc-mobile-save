import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';

mixin HTCSRepository {
  Future<Result<String>> shareReport(
      List<ShareReport> mapMember,
      String idReport,
      String appId,
      );
}
