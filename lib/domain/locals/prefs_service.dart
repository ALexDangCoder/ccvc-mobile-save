
import 'dart:convert';

import 'package:ccvc_mobile/domain/model/app_theme_model.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _PREF_LANGUAGE = 'pref_language';
  static const _PREF_TOKEN = 'pref_token';
  static const _PREF_REFRESH_TOKEN = 'pref_token';

  static const _PREF_DATA_USER = 'pref_data_user';
  static const _PREF_APP_THEME = 'pref_app_theme';
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method form iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String getToken() {
    return _prefsInstance?.getString(_PREF_TOKEN) ?? '';
  }

  static Future<bool> saveToken(String token) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_TOKEN, token);
  }

  static Future<bool> saveRefreshToken(String token) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_REFRESH_TOKEN, token);
  }

  static Future<bool> saveDataUser(String data) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_DATA_USER, data);
  }

  static Future<bool> saveLanguage(String code) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_LANGUAGE, code);
  }


  static String getLanguage() {
    return _prefsInstance?.getString(_PREF_LANGUAGE) ?? VI_CODE;
  }

  Future<void> clearData() async {
    await _prefsInstance?.clear();
    return;
  }
  static Future<bool> setAppTheme(AppThemModel appThemModel) async {
    final prefs = await _instance;
    return prefs.setString(_PREF_APP_THEME, json.encode(appThemModel.toJson()));
  }
  static AppThemModel getAppTheme(){
    final result = _prefsInstance?.getString(_PREF_APP_THEME);
    if(result == null){
      return AppThemModel();
    }
    final jsonDecode =  json.decode(result) as Map<String,dynamic>;
     return AppThemModel.fromJson(jsonDecode);
  }
}
