import 'package:ccvc_mobile/bao_cao_module/data/request/share_report_request.dart';
import 'package:ccvc_mobile/bao_cao_module/data/response/group_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/services/htcs_service.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/htcs_repository.dart';
import 'package:ccvc_mobile/data/result/result.dart';

class HtcsImpl implements HTCSRepository {
  final HTCSService _htcsService;

  HtcsImpl(
      this._htcsService,
      );

  @override
  Future<Result<String>> shareReport(
      List<ShareReport> mapMember,
      String idReport,
      String appId,
      ) {
    return runCatchingAsync<PostDataResponse, String>(
          () => _htcsService.shareReport(
        idReport,
        mapMember,
        appId,
      ),
          (res) => res.message ?? '',
    );
  }
}