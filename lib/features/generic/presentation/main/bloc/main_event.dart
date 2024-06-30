part of 'main_bloc.dart';

abstract class MainEvent {}

class ChangeLanguageToArabic extends MainEvent {}

class ChangeLanguageToEnglish extends MainEvent {}

class ChangeLanguageApp extends MainEvent {}

class ChangeThemeToDark extends MainEvent {}

class ChangeThemeToLight extends MainEvent {}

class ChangeThemeApp extends MainEvent {}

//region Change Font Scale

class ChangeFontSizeAppEvent extends MainEvent {
  final FontSizeAppEnum fontSizeApp;

  ChangeFontSizeAppEvent(this.fontSizeApp);
}

class ChangeFontSizeAppToSmallEvent extends MainEvent {}

class ChangeFontSizeAppToMediumEvent extends MainEvent {}

class ChangeFontSizeAppToLargeEvent extends MainEvent {}

//endregion

//region Change CurrentUser

// class SetCurrentUserEvent extends MainEvent {
//   final Patient patient;
//
//   SetCurrentUserEvent(this.patient);
// }
//
// class SetBeneficiariesEvent extends MainEvent {
//   final List<Patient> beneficiaries;
//
//   SetBeneficiariesEvent(this.beneficiaries);
// }

// class SetDataUserEvent extends MainEvent {}
//
// class ClearUserBeneficiariesEvent extends MainEvent {}

//endregion
