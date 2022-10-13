import 'package:ccvc_mobile/data/request/thong_tin_khach/tao_thong_tin_khach_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/thong_tin_khach/tao_thong_tin_khach_model.dart';

mixin ThongTinKhachRepository {
  Future<Result<TaoThongTinKhachModel>> taoThongTinKhach(
      TaoThongTinKhachRequest taoThongTinKhachRequest);
}
