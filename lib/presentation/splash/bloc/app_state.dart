
import 'package:ccvc_mobile/config/app_config.dart';
import 'package:ccvc_mobile/domain/locals/prefs_service.dart';
import 'package:ccvc_mobile/domain/model/app_theme_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class AppState {
  String token = '';
  final BehaviorSubject<String> getToken = BehaviorSubject<String>();
  final BehaviorSubject<String> refreshToken = BehaviorSubject<String>();
  void getTokenPrefs() {
    token = PrefsService.getToken();
    getToken.sink.add(token);
  }

  void setToken(String token) {
    PrefsService.saveToken(token);
    this.token = token;
    getToken.sink.add(token);
  }

  void setAppMode(AppMode appMode) {
    APP_THEME = appMode;
    PrefsService.setAppTheme(
      AppThemModel(appMode: APP_THEME, appBackGround: APP_BACKGROUND),
    );
    Get.forceAppUpdate();
  }
  Future<void> refreshTokenFunc(String token) async {
   await PrefsService.saveToken(token);
   refreshToken.sink.add(token);
  }

  void setAppBackGround(AppBackGround appBackGround) {
    if (appBackGround == APP_BACKGROUND) {
      APP_BACKGROUND = null;
    } else {
      APP_BACKGROUND = appBackGround;
    }
    PrefsService.setAppTheme(
      AppThemModel(appMode: APP_THEME, appBackGround: APP_BACKGROUND),
    );
    Get.forceAppUpdate();
  }

  void getThemeApp() {
   final appTheme =  PrefsService.getAppTheme();
    APP_THEME = appTheme.appMode ?? AppMode.MAC_DINH;
    APP_BACKGROUND = appTheme.appBackGround;
  }
}
