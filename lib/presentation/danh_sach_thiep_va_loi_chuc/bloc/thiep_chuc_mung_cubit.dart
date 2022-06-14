import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/config/base/base_state.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/presentation/danh_sach_thiep_va_loi_chuc/bloc/thiep_chuc_mung_state.dart';
import 'package:ccvc_mobile/utils/constants/api_constants.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ThiepChucMungCuBit extends BaseCubit<BaseState> {
  ThiepChucMungCuBit() : super(ThiepChucMungInitial());

  AccountRepository get repo => Get.find();

  Future<void> getListBirthday(int pageIndex) async {
    showLoading();
    final result = await repo.getListBirthday(
      ApiConstants.DEFAULT_PAGE_SIZE,
      pageIndex,
    );
    result.when(
      success: (res) {
        if (pageIndex == ApiConstants.PAGE_BEGIN) {
          if (res.isEmpty) {
            showContent();
            emit(const CompletedLoadMore(CompleteType.SUCCESS, posts: []));
          } else {
            showContent();
            emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
          }
        } else {
          showContent();
          emit(CompletedLoadMore(CompleteType.SUCCESS, posts: res));
        }
      },
      error: (error) {},
    );
  }
}
