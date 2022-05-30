import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/home_module/data/request/account/gui_loi_chuc_request.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/sinh_nhat_model.dart';
import 'package:ccvc_mobile/home_module/domain/repository/home_repository/home_repository.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:get/get.dart';

import 'chuc_sinh_nhat_state.dart';

class ChucSinhNhatCubit extends BaseCubit<ChucSinhNhatState> {
  ChucSinhNhatCubit() : super(MainStateInitial()) {
    showContent();
  }

  final DataUser? dataUser = HiveLocal.getDataUser();

  HomeRepository get homeRepository => Get.find();

  Future<void> guiLoiChuc(
      String content, SinhNhatUserModel sinhNhatUserModel) async {
    showLoading();
    final result = await homeRepository.guiLoiChuc(
      GuiLoiChucRequest(
        content: content,
        cardId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        chucVu: dataUser?.userInformation?.chucVu ?? '',
        donVi: dataUser?.userInformation?.donVi ?? '',
        emailNguoiNhan: sinhNhatUserModel.email,
        isDeleted: false,
        nguoiGuiId: dataUser?.userInformation?.id ?? '',
        nguoiNhanId: sinhNhatUserModel.canBoId,
        tenNguoiGui: dataUser?.userInformation?.hoTen ?? '',
        tenNguoiNhan: sinhNhatUserModel.tenCanBo,
      ),
    );
    showContent();
    result.when(success: (res) {
      if (res.succeeded) {
        emit(Succeeded());
      } else {
        MessageConfig.show(title: res.message, messState: MessState.error);
      }
    }, error: (err) {
      MessageConfig.show(title: err.message, messState: MessState.error);
    });
  }
}
