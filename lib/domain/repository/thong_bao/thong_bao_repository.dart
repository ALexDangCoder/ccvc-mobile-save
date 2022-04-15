import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';

mixin ThongBaoRepository {
  Future<Result<List<ThongBaoModel>>> getNotifyAppcodes();
}