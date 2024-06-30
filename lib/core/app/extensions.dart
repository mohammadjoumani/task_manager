import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

//RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
// String Function(Match) mathFunc = (Match match) => '${match[1]},';

extension FormatNumber on String {
  String getFormatNumber() {
    final numberFormatter = NumberFormat.decimalPattern('en_US');
    return numberFormatter.format(num.parse(this));
  }
}

extension Date on String {
  String getFormatDate() {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.parse(this));
    return date;
  }

  String getFormatDate1() {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(this));
    return date;
  }

  String getFormatDateWithDayName() {
    String date = DateFormat().add_yMMMMEEEEd().format(DateTime.parse(this));
    return date;
  }

  String getFormatTime() {
    String date = DateFormat.jm().format(DateTime.parse(this));
    return date;
  }

  String getFormatDateWithTime() {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(this));
    String time = DateFormat('hh:mm').format(DateTime.parse(this));
    String time1 = DateFormat('a', 'ar').format(DateTime.parse(this));
    return '$date $time $time1';
  }

  num getAge() {
    final today = DateTime.now();
    final birthDate = DateTime.parse(this);
    int age = today.year - birthDate.year;
    int month = today.month - birthDate.month;
    if (month < 0 || (month == 0 && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  int getYear() {
    final date = DateTime.parse(this);
    return date.year;
  }

  int getMonth() {
    final date = DateTime.parse(this);
    return date.month;
  }

  int getDay() {
    final date = DateTime.parse(this);
    return date.day;
  }
}

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double orZero() {
    if (this == null) {
      return Constants.zero.toDouble();
    } else {
      return this!;
    }
  }
}

extension NonNullNum on num? {
  num orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullBool on bool? {
  bool orFalse() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}

extension ValidationExtension on String {
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isValidPassword() {
    return contains(RegExp(r'\d')) && contains(RegExp(r'[a-zA-Z]'));
  }

  bool isValidSehatechId() {
    return contains(RegExp(r'[0-9]'));
  }
}

extension ValidationExtension1 on String? {
  bool isValidPhoneNumber() {
    if (this == null) {
      return false;
    } else {
      final validatedPhoneNumber = this!.isNotEmpty && this!.length >= 11 && this != '0';
      return validatedPhoneNumber;
    }
  }
}

extension ContextExtension on BuildContext {
  void dismissKeyboard() {
    // FocusScope.of(this).requestFocus(FocusNode());
    // FocusScope.of(this).unfocus();
    // FocusManager.instance.primaryFocus?.unfocus();

    final focus = FocusManager.instance.primaryFocus;
    if (focus != null) {
      focus.unfocus();
    }
  }
}

// void test() {
//   String? name;
//   int? count;
//   print(name.orEmpty());
//   print(count.orZero());
// }
