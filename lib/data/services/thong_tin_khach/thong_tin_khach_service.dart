import 'package:ccvc_mobile/data/request/thong_tin_khach/tao_thong_tin_khach_request.dart';
import 'package:ccvc_mobile/data/response/thong_tin_khach/tao_thong_tin_khach_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart' hide Headers;

part 'thong_tin_khach_service.g.dart';

@RestApi()
abstract class ThongTinKhachService {
  @factoryMethod
  factory ThongTinKhachService(Dio dio, {String baseUrl}) =
      _ThongTinKhachService;

  @POST(ApiConstants.MPIDDTH_CREATE_EVENT)
  Future<DataTaoThongTinKhachResponse> postThongTinKhach(
     @Body() TaoThongTinKhachRequest taoThongTinKhachRequest);
}
