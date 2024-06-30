part of 'main_bloc.dart';

enum ThemeModeEnum { light, dark }

enum FontSizeAppEnum {
  small(1),
  medium(1.1),
  large(1.2);

  const FontSizeAppEnum(this.value);

  final double value;
}

class MainState {
  Locale? locale;
  ThemeModeEnum themeMode;
  FontSizeAppEnum? fontSizeApp;

  // Patient? patient;

  // List<Patient>? beneficiaries;
  final AppPreferences _appPref = instance<AppPreferences>();

  MainState({
    this.locale,
    this.themeMode = ThemeModeEnum.light,
    this.fontSizeApp,
  }) {
    locale ??= _appPref.getLocale();
    fontSizeApp ??= _appPref.getFontSize();
  }

  copyWith({
    Locale? locale,
    ThemeModeEnum? themeMode,
    FontSizeAppEnum? fontSizeApp,
  }) {
    return MainState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      fontSizeApp: fontSizeApp ?? this.fontSizeApp,
    );
  }
}
