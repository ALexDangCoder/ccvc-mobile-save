import 'dart:async';

import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/config/base/base_cubit.dart';
import 'package:ccvc_mobile/data/request/account/chuyen_pham_vi_request.dart';
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/account/data_user.dart';
import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';
import 'package:ccvc_mobile/domain/repository/login_repository.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_state.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/menu_items.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:get/get.dart';
import 'package:queue/queue.dart';
import 'package:rxdart/rxdart.dart';

class MenuCubit extends BaseCubit<MenuState> {
  MenuCubit() : super(MainStateInitial());

  final BehaviorSubject<List<MenuType>> _getMenu =
      BehaviorSubject<List<MenuType>>();

  Stream<List<MenuType>> get getMenu => _getMenu.stream;

  AccountRepository get accountRp => Get.find();
  String id = '';
  DataUser? dataUser = HiveLocal.getDataUser();
  List<PhamViModel> listPhamVi = [];
  PhamViModel? selectPhamVi;
  bool isRefresh = false;

  Future<void> getUser() async {
    final queue = Queue();
    if (dataUser != null) {
      id = dataUser!.userInformation?.id ?? '';
    }

    showLoading();
    unawaited(queue.add(() => permissionMenu()));
    // unawaited(queue.add(() => getListPhamVi()));
    await queue.onComplete;
    showContent();
  }

  Future<void> refeshMenu() async {
    final queue = Queue();
    final homeCubit = isMobile()
        ? keyHomeMobile.currentState?.homeCubit
        : keyHomeTablet.currentState?.homeCubit;

    unawaited(queue.add(() => permissionMenu()));
    // unawaited(queue.add(() => getListPhamVi()));
    unawaited(queue.add(() => homeCubit!.getUserInFor()));
    await queue.onComplete;
  }

  Future<void> getUserRefresh() async {
    isRefresh = false;
    showLoading();
    final homeCubit = isMobile()
        ? keyHomeMobile.currentState?.homeCubit
        : keyHomeTablet.currentState?.homeCubit;
    await homeCubit!.getUserInFor();
    showContent();
  }

  Future<void> permissionMenu() async {
    final result = await accountRp.getPermissionMenu();
    result.when(
        success: (res) {
          final item = <MenuType>[];
          for (final vl in listFeature) {
            if (res.indexWhere((element) => element.menuType == vl) != -1) {
              item.add(vl);
            }
          }
          _getMenu.sink.add(item);
        },
        error: (err) {});
  }

  Future<void> getListPhamVi() async {
    final result = await accountRp.getListPhamVi();
    result.when(
        success: (res) {
          listPhamVi = res;
          selectPhamVi = listPhamVi
              .where((element) => element.isCurrentActive == true)
              .first;
        },
        error: (err) {});
  }

  void onSelectPhamVi(PhamViModel phamViModel) {
    selectPhamVi = phamViModel;
  }

  Future<void> chuyenPhamVi() async {
    showLoading();
    if ((selectPhamVi?.userCanBoDepartmentId ?? '').isNotEmpty) {
      final result = await accountRp.chuyenPhamVi(
        chuyenPhamViRequest: ChuyenPhamViRequest(
          userCanBoDepartmentId: selectPhamVi?.userCanBoDepartmentId ?? '',
          appCode: APP_CODE,
        ),
      );
      await result.when(success: (res) async {
        if (res.dataUser != null) {
          final queue = Queue();
          unawaited(
            queue.add(
              () => PrefsService.saveRefreshToken(
                  res.dataUser?.refreshToken ?? ''),
            ),
          );
          unawaited(
            queue.add(
              () => PrefsService.saveToken(res.dataUser?.accessToken ?? ''),
            ),
          );
          unawaited(queue.add(() => HiveLocal.saveDataUser(res.dataUser!)));
          await queue.onComplete;
          showContent();
          MessageConfig.show(
              title: S.current.chuyen_pham_vi_thanh_cong,
              onDismiss: () {
                emit(ChuyenPhamViSucsess(res.dataUser?.accessToken ?? ''));
              });
        }
      }, error: (err) {
        showContent();
      });
    }
  }
}
