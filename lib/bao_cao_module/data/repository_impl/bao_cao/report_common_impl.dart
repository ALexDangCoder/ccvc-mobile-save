import 'package:ccvc_mobile/bao_cao_module/data/response/bao_cao/appid_response.dart';
import 'package:ccvc_mobile/bao_cao_module/data/services/bao_cao/report_common_service.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/model/bao_cao/htcs_model.dart';
import 'package:ccvc_mobile/bao_cao_module/domain/repository/bao_cao/report_common_repository.dart';
import 'package:ccvc_mobile/data/result/result.dart';

class ReportCommonImpl implements ReportCommonRepository {
  final ReportCommonService _reportCommonService;

  ReportCommonImpl(
      this._reportCommonService,
      );


  @override
  Future<Result<List<HTCSModel>>> getHTCS(String code) {
    return runCatchingAsync<AppIdResponse, List<HTCSModel>>(
          () => _reportCommonService.getHTCS(
        code,
      ),
          (res) => res.data?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }


}
