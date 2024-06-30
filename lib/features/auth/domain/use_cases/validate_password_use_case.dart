import 'package:task_manager_app/core/generic/use_cases/use_case.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/features/generic/presentation/main/view/task_manager_app.dart';

class ValidatePasswordUseCase extends UseCase<String, String> {
  @override
  Future<String> call(String input) async {
    final context = navigatorKey!.currentState!.context;

    if (input.isEmpty) {
      return AppStrings.strEmptyPassword.tr(context);
    }

    if (input.length < 6) {
      return AppStrings.strNotValidatePassword.tr(context);
    }

    // if (!input.isValidPassword()) {
    //   return "The Password Needs To Contain At Least One Letter And Digit";
    // }
    return "";
  }
}
