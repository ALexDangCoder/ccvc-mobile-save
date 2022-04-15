import 'package:ccvc_mobile/data/response/thong_bao/thong_bao_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/thong_bao_service/thong_bao_service.dart';
import 'package:ccvc_mobile/domain/model/thong_bao/thong_bao_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_bao/thong_bao_repository.dart';

class ThongBaoImpl implements ThongBaoRepository {
  ThongBaoService service;

  ThongBaoImpl(this.service);

  @override
  Future<Result<List<ThongBaoModel>>> getNotifyAppcodes() {
    return runCatchingAsync<ThongBaoResponse, List<ThongBaoModel>>(
          () => service.getNotifyAppcodes(),
          (res) => res.data.map((e) => e.toModel()).toList(),
    );
  }
}
