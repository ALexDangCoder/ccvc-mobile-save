import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/bao_cao/htcs_model.dart';

mixin ReportCommonRepository {
  Future<Result<List<HTCSModel>>> getHTCS(
    String code,
  );
}
