import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_manager_app/core/app/app_prefs.dart';
import 'package:task_manager_app/core/app/di.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AppPreferences _appPref = instance<AppPreferences>();

  MainBloc() : super(MainState()) {
    on<ChangeLanguageToEnglish>(_mapChangeLanguageToEnglishMode);
    on<ChangeLanguageToArabic>(_mapChangeLanguageToArabicMode);
    on<ChangeLanguageApp>(_mapChangeLanguageAppMode);

    on<ChangeThemeToDark>(_mapChangeThemeToDarkMode);
    on<ChangeThemeToLight>(_mapChangeThemeToLightMode);
    on<ChangeThemeApp>(_mapChangeThemeMode);

    on<ChangeFontSizeAppEvent>(_mapChangeFontSizeApp);
    on<ChangeFontSizeAppToSmallEvent>(_mapChangeFontSizeAppToSmall);
    on<ChangeFontSizeAppToMediumEvent>(_mapChangeFontSizeAppToMedium);
    on<ChangeFontSizeAppToLargeEvent>(_mapChangeFontSizeAppToLarge);
  }

  // region Change Language

  _mapChangeLanguageAppMode(ChangeLanguageApp event, Emitter<MainState> emit) {
    _appPref.isEnglish() ? emit(state.copyWith(locale: arabicLocale)) : emit(state.copyWith(locale: englishLocale));

    _appPref.changeAppLanguage();
  }

  _mapChangeLanguageToEnglishMode(ChangeLanguageToEnglish event, Emitter<MainState> emit) {
    emit(state.copyWith(locale: englishLocale));
    _appPref.setLocale(LanguageType.english.getValue());
  }

  _mapChangeLanguageToArabicMode(ChangeLanguageToArabic event, Emitter<MainState> emit) {
    emit(state.copyWith(locale: arabicLocale));
    _appPref.setLocale(LanguageType.arabic.getValue());
  }

//endregion

  //region Change Theme

  _mapChangeThemeMode(ChangeThemeApp event, Emitter<MainState> emit) {}

  _mapChangeThemeToLightMode(ChangeThemeToLight event, Emitter<MainState> emit) {
    // emit(state.copyWith(locale: englishLocale));
  }

  _mapChangeThemeToDarkMode(ChangeThemeToDark event, Emitter<MainState> emit) {
    // emit(state.copyWith(locale: arabicLocale));
  }

//endregion

  //region Change Font Scale

  _mapChangeFontSizeApp(ChangeFontSizeAppEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(fontSizeApp: event.fontSizeApp));
  }

  _mapChangeFontSizeAppToSmall(ChangeFontSizeAppToSmallEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(fontSizeApp: FontSizeAppEnum.small));
    _appPref.setFontSize(FontSizeAppEnum.small);
  }

  _mapChangeFontSizeAppToMedium(ChangeFontSizeAppToMediumEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(fontSizeApp: FontSizeAppEnum.medium));
    _appPref.setFontSize(FontSizeAppEnum.medium);
  }

  _mapChangeFontSizeAppToLarge(ChangeFontSizeAppToLargeEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(fontSizeApp: FontSizeAppEnum.large));
    _appPref.setFontSize(FontSizeAppEnum.large);
  }

//endregion
}
