import 'package:ccvc_mobile/data/request/account_request.dart';
import 'package:ccvc_mobile/data/response/account/login_response.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'account_service.g.dart';

@RestApi()
abstract class AccountService {
  @factoryMethod
  factory AccountService(Dio dio, {String baseUrl}) = _AccountService;

  @POST(ApiConstants.LOGIN)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
}
