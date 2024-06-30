import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/features/auth/data/models/dto/response/login_response_dto.dart';
import 'package:task_manager_app/features/auth/data/models/mapper/login_response_mapper.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';
import 'package:task_manager_app/features/generic/presentation/main/bloc/main_bloc.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/response/task_response_dto.dart';

String keyLang = "KEY_LANG";
String keyFontSize = "KEY_FONT_SIZE";

String keyIsUserLoggedIn = "KEY_IS_USER_LOGGED_IN";
String keyOnBoardingScreenViewed = "KEY_ON_BOARDING_SCREEN_VIEWED";

// user data key
String keyUserInfo = "KEY_USER_INFO ";
String keyToken = "KEY_TOKEN";
String keyRefreshToken = "KEY_REFRESH_TOKEN";

// Tasks
String keyTasks = "KEY_TASKS";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  // region Language
  String getAppLanguage() {
    String? language = _sharedPreferences.getString(keyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.arabic.getValue();
    }
  }

  bool isEnglish() {
    return getAppLanguage() == LanguageType.english.getValue();
  }

  Future<void> changeAppLanguage() async {
    String currentLang = getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      // set english
      _sharedPreferences.setString(keyLang, LanguageType.english.getValue());
    } else {
      // set arabic
      _sharedPreferences.setString(keyLang, LanguageType.arabic.getValue());
    }
  }

  Future<void> setLocale(String lang) async {
    _sharedPreferences.setString(keyLang, lang);
  }

  Locale getLocale() {
    String currentLang = getAppLanguage();

    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  //endregion

  //region FontSize

  FontSizeAppEnum getFontSize() {
    String? fontSize = _sharedPreferences.getString(keyFontSize);
    if (fontSize != null && fontSize.isNotEmpty) {
      return FontSizeAppEnum.values.firstWhere((element) => element.name == fontSize);
    } else {
      return FontSizeAppEnum.small;
    }
  }

  Future<void> setFontSize(FontSizeAppEnum fontSizeApp) async {
    _sharedPreferences.setString(keyFontSize, fontSizeApp.name);
  }

  //endregion

  //region OnBoarding

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(keyOnBoardingScreenViewed, true);
  }

  bool isOnBoardingScreenViewed() {
    return _sharedPreferences.getBool(keyOnBoardingScreenViewed) ?? false;
  }

  //endregion

  //region Login

  Future<void> logout() async {
    final keys = _sharedPreferences.getKeys();
    for (var item in keys) {
      if (!(item == keyLang || item == keyOnBoardingScreenViewed || item == keyFontSize)) {
        _sharedPreferences.remove(item);
      }
    }
  }

  Future<void> setUserLogged() async {
    _sharedPreferences.setBool(keyIsUserLoggedIn, true);
  }

  bool isUserLogged() {
    return _sharedPreferences.getBool(keyIsUserLoggedIn) ?? false;
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(keyToken, token);
  }

  String getToken() {
    return _sharedPreferences.getString(keyToken) ?? "";
  }

  void setRefreshToken(String refreshToken) {
    _sharedPreferences.setString(keyRefreshToken, refreshToken);
  }

  String getRefreshToken() {
    return _sharedPreferences.getString(keyRefreshToken) ?? "";
  }

  Future<void> setUserInfo(LoginResponseDto userResponseDto) async {
    final userInfo = userResponseDto.toJson();
    setToken(userResponseDto.token!);
    setRefreshToken(userResponseDto.refreshToken!);
    setUserLogged();
    _sharedPreferences.setString(keyUserInfo, jsonEncode(userInfo));
  }

  User getUserInfo() {
    final jsonEncode = _sharedPreferences.getString(keyUserInfo) ?? "";
    final userInfo = json.decode(jsonEncode);
    return LoginResponseDto.fromJson(userInfo).toDomain();
  }

//endregion

  //region Tasks

  Future<void> setTasks(List<TaskResponseDto> tasksResponseDto) async {
    final tasks = tasksResponseDto.map((e) => e.toJson()).toList();
    _sharedPreferences.setString(keyTasks, jsonEncode(tasks));
  }

  List<TaskResponseDto> getTasks() {
    final jsonEncode = _sharedPreferences.getString(keyTasks) ?? "";
    final tasks = json.decode(jsonEncode);
    return TaskResponseDto.fromJsonList(tasks);
  }

//endregion
}
