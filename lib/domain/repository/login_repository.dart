import 'package:ccvc_mobile/data/request/edit_person_information/edit_person_information_request.dart';
import 'package:ccvc_mobile/data/result/result.dart';
import 'package:ccvc_mobile/domain/model/account/change_pass_model.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/account/permission_app_model.dart';
import 'package:ccvc_mobile/domain/model/account/permission_menu_model.dart';
import 'package:ccvc_mobile/domain/model/account/tinh_huyen_xa/tinh_huyen_xa_model.dart';
import 'package:ccvc_mobile/domain/model/edit_personal_information/data_edit_person_information.dart';
import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';
import 'package:ccvc_mobile/domain/model/manager_personal_information/manager_personal_information_model.dart';

mixin AccountRepository {
  Future<Result<DataLogin>> login(
    String userName,
    String passWord,
    String appCode,
  );

  Future<Result<List<TinhHuyenXaModel>>> getData();

  Future<Result<List<TinhHuyenXaModel>>> getDataChild(
      String parentId,
      );

  Future<Result<ManagerPersonalInformationModel>> getInfo(
    String id,
  );

  Future<Result<DataEditPersonInformation>> getEditPerson(
    EditPersonInformationRequest editPersonInformationRequest,
  );
  Future<Result<PhamViModel>> getPhamVi();
  Future<Result<List<PhamViModel>>> getListPhamVi();
  Future<Result<PermissionApp>> getListPermissionApp();
  Future<Result<ChangePassModel>> changePass(
      String passwordOld,
      String password,
      String repeatPassword,
      );
  Future<Result<List<PermissionMenuModel>>> getPermissionMenu();
}
