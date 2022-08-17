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
import 'package:ccvc_mobile/data/response/account/unauthorized_response.dart';
import 'package:ccvc_mobile/data/response/edit_person_information/edit_person_information_response.dart';
import 'package:ccvc_mobile/data/response/home/list_birthday_response.dart';
import 'package:ccvc_mobile/data/response/home/pham_vi_response.dart';
import 'package:ccvc_mobile/data/response/manager_personal_information/manager_personal_information_response.dart';
import 'package:ccvc_mobile/data/response/up_load_anh/up_load_anh_response.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/data/services/account_service.dart';
import 'package:ccvc_mobile/domain/model/account/change_pass_model.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/forgot_password_model.dart';
import 'package:ccvc_mobile/domain/model/account/permission_app_model.dart';
import 'package:ccvc_mobile/domain/model/account/permission_menu_model.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/account/unauthorized_model.dart';
import 'package:ccvc_mobile/domain/model/edit_personal_information/data_edit_person_information.dart';
import 'package:ccvc_mobile/domain/model/edit_personal_information/up_load_anh_model.dart';
import 'package:ccvc_mobile/domain/model/home/birthday_model.dart';
import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';

class AccountImpl implements AccountRepository {
  final AccountService _accountServiceCommon;
  final AccountServiceGateWay _accountServiceGateWay;
  final AccountServiceCCVC _accountServiceCCVC;

  AccountImpl(this._accountServiceCommon, this._accountServiceGateWay,
      this._accountServiceCCVC);

  @override
  Future<Result<DataLogin>> login(
      String userName, String passWord, String appCode) {
    return runCatchingAsync<LoginResponse, DataLogin>(
      () => _accountServiceCommon.login(
        LoginRequest(
          username: userName,
          password: passWord,
          appCode: appCode,
        ),
      ),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ManagerPersonalInformationModel>> getInfo(String id) {
    return runCatchingAsync<ManagerPersonalInformationResponse,
        ManagerPersonalInformationModel>(
      () => _accountServiceCommon.getInfo(id),
      (response) => response.data.toModel(),
    );
  }

  @override
  Future<Result<DataEditPersonInformation>> getEditPerson(
    EditPersonInformationRequest editPersonInformationRequest,
  ) {
    return runCatchingAsync<EditPersonInformationResponse,
        DataEditPersonInformation>(
      () => _accountServiceCommon.editPerson(editPersonInformationRequest),
      (response) => response.data.toDomain(),
    );
  }

  @override
  Future<Result<UpLoadAnhModel>> uploadFile(File files) {
    return runCatchingAsync<UpLoadAnhResponse, UpLoadAnhModel>(
      () => _accountServiceCommon.uploadFile(
        files,
      ),
      (res) => res.toModel(),
    );
  }

  @override
  Future<Result<List<BirthdayModel>>> getListBirthday(
    int pageSize,
    int pageIndex,
  ) {
    return runCatchingAsync<ListBirthDayResponse, List<BirthdayModel>>(
      () => _accountServiceGateWay.getListBirthday(pageSize, pageIndex),
      (res) => res.data?.pageData?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TinhHuyenXaModel>>> getData() {
    return runCatchingAsync<TinhHuyenXaResponse, List<TinhHuyenXaModel>>(
      () => _accountServiceCommon.getData(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<List<TinhHuyenXaModel>>> getDataChild(String parentId) {
    return runCatchingAsync<TinhHuyenXaResponse, List<TinhHuyenXaModel>>(
      () => _accountServiceCommon.getDataChild(parentId),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<PhamViModel>> getPhamVi() {
    return runCatchingAsync<PhamViResponse, PhamViModel>(
      () => _accountServiceGateWay.getPhamVi(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<PermissionApp>> getListPermissionApp() {
    return runCatchingAsync<PermissionResponse, PermissionApp>(
      () => _accountServiceCommon.getPermission({"isGetAll": true}),
      (res) =>
          res.data?.toDomain() ??
          PermissionApp(
            qLVB: [],
            pAKN: [],
            vPDT: [],
            qLNV: [],
            hTCS: [],
            hTKT: [],
           ),
    );
  }

  @override
  Future<Result<ChangePassModel>> changePass(
      String passwordOld, String password, String repeatPassword) {
    return runCatchingAsync<ChangePassResponse, ChangePassModel>(
        () => _accountServiceCommon.changePass(
              ChangePassRequest(
                passwordOld: passwordOld,
                password: password,
                repeatPassword: repeatPassword,
              ),
            ),
        (response) => response.toModel());
  }

  @override
  Future<Result<ForgotPasswordModel>> forgotPassword(
      String email, String userName, String origin) {
    return runCatchingAsync<ForgotPasswordResponse, ForgotPasswordModel>(
        () => _accountServiceCommon.forgotPassword(
            ForgotPasswordRequest(
              email: email,
              userName: userName,
            ),
            origin),
        (response) => response.toModel());
  }

  @override
  Future<Result<List<PermissionMenuModel>>> getPermissionMenu() {
    return runCatchingAsync<PermissionMenuResponse, List<PermissionMenuModel>>(
      () => _accountServiceCCVC.getPermissionMenu(),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<PhamViModel>>> getListPhamVi() {
    return runCatchingAsync<ListPhamViResponse, List<PhamViModel>>(
      () => _accountServiceGateWay.getListPhamVi(),
      (res) => res.toDomain(),
    );
  }

  @override
  Future<Result<DataLogin>> chuyenPhamVi(
      {required ChuyenPhamViRequest chuyenPhamViRequest}) {
    return runCatchingAsync<LoginResponse, DataLogin>(
        () => _accountServiceGateWay.chuyenPhamVi(chuyenPhamViRequest),
        (res) => res.toModel());
  }

  @override
  Future<Result<UnauthorizedModel>> refreshToken(
      String accessToken, String refreshToken) {
    return runCatchingAsync<UnauthorizedResponse, UnauthorizedModel>(
        () => _accountServiceGateWay.refreshToken(
              accessToken,
              refreshToken,
            ),
        (res) => res.toModel());
  }
}
