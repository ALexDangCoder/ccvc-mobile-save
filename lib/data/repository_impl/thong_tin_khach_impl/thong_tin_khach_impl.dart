import 'package:ccvc_mobile/data/response/thong_tin_khach/tao_thong_tin_khach_response.dart';
import 'package:ccvc_mobile/data/services/thong_tin_khach/thong_tin_khach_service.dart';
import 'package:ccvc_mobile/data/request/thong_tin_khach/tao_thong_tin_khach_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/tao_thong_tin_khach_model.dart';
import 'package:ccvc_mobile/domain/repository/thong_tin_khach/thong_tin_khach_repository.dart';

class ThongTinKhachImpl implements ThongTinKhachRepository {
  final ThongTinKhachService _thongTinKhachService;

  ThongTinKhachImpl(this._thongTinKhachService);

  @override
  Future<Result<TaoThongTinKhachModel>> taoThongTinKhach(
      TaoThongTinKhachRequest taoThongTinKhachRequest) {
    return runCatchingAsync<DataTaoThongTinKhachResponse,
        TaoThongTinKhachModel>(
      () => _thongTinKhachService.postThongTinKhach(taoThongTinKhachRequest),
      (res) => res.toModel(),
    );
  }
}
