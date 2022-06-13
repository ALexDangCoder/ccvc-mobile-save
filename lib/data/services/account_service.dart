import 'dart:io';

import 'package:ccvc_mobile/data/request/account/change_pass_request.dart';
import 'package:ccvc_mobile/data/request/account/chuyen_pham_vi_request.dart';
import 'package:ccvc_mobile/data/request/account/forgot_password_request.dart';
import 'package:ccvc_mobile/data/request/account_request.dart';
import 'package:ccvc_mobile/data/request/edit_person_information/edit_person_information_request.dart';
import 'package:ccvc_mobile/data/response/account/change_pass_response.dart';
import 'package:ccvc_mobile/data/response/account/forgot_password_response.dart';
import 'package:ccvc_mobile/data/response/account/list_permission_response.dart';
import 'package:ccvc_mobile/data/response/account/login_response.dart';
import 'package:ccvc_mobile/data/response/account/permission_menu_response.dart';
import 'package:ccvc_mobile/data/response/account/tinh_huyen_xa/tinh_huyen_xa_response.dart';
import 'package:ccvc_mobile/data/response/edit_person_information/edit_person_information_response.dart';
import 'package:ccvc_mobile/data/response/home/list_birthday_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/lich_lam_viec/chinh_sua_bao_cao_ket_qua_response.dart';
import 'package:ccvc_mobile/data/response/manager_personal_information/manager_personal_information_response.dart';
import 'package:ccvc_mobile/data/response/up_load_anh/up_load_anh_response.dart';
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

  @PATCH(ApiConstants.UPLOAD_FILE)
  @MultiPart()
  Future<UpLoadAnhResponse> uploadFile(
    @Part() File File,
  );


  @GET(ApiConstants.GET_TINH_HUYEN_XA)
  Future<TinhHuyenXaResponse> getData();

  @GET(ApiConstants.GET_TINH_HUYEN_XA)
  Future<TinhHuyenXaResponse> getDataChild(@Query('parentId') String parentId);

  @POST(ApiConstants.LIST_PERMISSION)
  Future<PermissionResponse> getPermission(
      @Body() Map<String, dynamic> request);

  @PUT(ApiConstants.CHANGE_PASS)
  Future<ChangePassResponse> changePass(
      @Body() ChangePassRequest changePassRequest);

  @POST(ApiConstants.FORGOT_PASSWORD)
  Future<ForgotPasswordResponse> forgotPassword(
      @Body() ForgotPasswordRequest forgotPasswordRequest);
}

@RestApi()
abstract class AccountServiceGateWay {
  @factoryMethod
  factory AccountServiceGateWay(Dio dio, {String baseUrl}) =
      _AccountServiceGateWay;

  @POST(ApiConstants.GET_PHAM_VI)
  @FormUrlEncoded()
  Future<PhamViResponse> getPhamVi();

  @POST(ApiConstants.GET_PHAM_VI)
  @FormUrlEncoded()
  Future<ListPhamViResponse> getListPhamVi();

  @POST(ApiConstants.CHUYEN_PHAM_VI)
  Future<LoginResponse> chuyenPhamVi(
      @Body() ChuyenPhamViRequest chuyenPhamViRequest);


  @GET(ApiConstants.GET_BIRTHDAY)
  Future<ListBirthDayResponse> getListBirthday(
      @Query('pageSize') int pageSize,
      @Query('pageIndex') int pageIndex,
      );
}

@RestApi()
abstract class AccountServiceCCVC {
  @factoryMethod
  factory AccountServiceCCVC(Dio dio, {String baseUrl}) = _AccountServiceCCVC;

  @GET(ApiConstants.GET_FUNCTION_OF_CURRENT)
  Future<PermissionMenuResponse> getPermissionMenu();
}
