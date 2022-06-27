
import 'package:ccvc_mobile/bao_cao_module/domain/model/htcs_model.dart';
import 'package:ccvc_mobile/data/result/result.dart';

mixin ReportCommonRepository {
  Future<Result<List<HTCSModel>>> getHTCS(
    String code,
  );
}
