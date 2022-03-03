import 'package:ccvc_mobile/data/request/account_request.dart';
import 'package:ccvc_mobile/data/request/edit_person_information/edit_person_information_request.dart';
import 'package:ccvc_mobile/data/response/account/login_response.dart';
import 'package:ccvc_mobile/data/response/account/tinh_huyen_xa/tinh_huyen_xa_response.dart';
import 'package:ccvc_mobile/data/response/edit_person_information/edit_person_information_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/manager_personal_information/manager_personal_information_response.dart';
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

  @GET(ApiConstants.GET_INFO)
  Future<ManagerPersonalInformationResponse> getInfo(@Query('id') String id);

  @POST(ApiConstants.EDIT_PERSON_INFORMATION)
  Future<EditPersonInformationResponse> editPerson(
    @Body() EditPersonInformationRequest editPersonInformationRequest,
  );

  @GET(ApiConstants.GET_TINH_HUYEN_XA)
  Future<TinhHuyenXaResponse> getData();

  @GET(ApiConstants.GET_TINH_HUYEN_XA)
  Future<TinhHuyenXaResponse> getDataChild(@Query('parentId') String parentId);
}
@RestApi()
abstract class AccountServiceGateWay {
  @factoryMethod
  factory AccountServiceGateWay(Dio dio, {String baseUrl}) = _AccountServiceGateWay;

  @POST(ApiConstants.GET_PHAM_VI)
  @FormUrlEncoded()
  Future<PhamViResponse> getPhamVi();
}
