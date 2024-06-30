import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';
import 'package:task_manager_app/core/utils/state_render/generic_data_state.dart';
import 'package:task_manager_app/core/utils/widgets/custom_drop_down.dart';
import 'package:task_manager_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:task_manager_app/core/utils/widgets/generic_button.dart';
import 'package:task_manager_app/core/utils/widgets/margin.dart';
import 'package:task_manager_app/core/utils/widgets/show_message.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/add_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/presentation/add_task/bloc/add_task_bloc.dart';

class AddTaskViewBody extends StatefulWidget {
  const AddTaskViewBody({super.key});

  @override
  State<AddTaskViewBody> createState() => _AddTaskViewBodyState();
}

class _AddTaskViewBodyState extends State<AddTaskViewBody> {
  int userId = -1;
  final TextEditingController _nameTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Task Name
            Text(
              AppStrings.strTaskName.tr(context),
              style: StyleManager.getMediumStyle(color: ColorManager.colorBlack),
            ),
            const Sh2(),
            CustomTextFormField(
              controller: _nameTaskController,
              hintText: AppStrings.strEnterTaskName.tr(context),
              onChanged: (value) {},
              textInputAction: TextInputAction.next,
            ),

            // Select User
            Text(
              AppStrings.strUser.tr(context),
              style: StyleManager.getMediumStyle(color: ColorManager.colorBlack),
            ),
            const Sh2(),
            BlocBuilder<AddTaskBloc, AddTaskState>(
              buildWhen: (previous, current) => previous.getUsersDataState != current.getUsersDataState,
              builder: (context, state) {
                return CustomDropDown(
                  hint: AppStrings.strChooseUser.tr(context),
                  returnValue: (value) {
                    if (value != null) {
                      userId = value.id;
                    }
                  },
                  isLoading: state.getUsersDataState == GenericDataState.loading,
                  items: state.users
                      .map(
                        (e) => DropdownMenuItem<User>(
                          value: e,
                          child: Text(e.username),
                        ),
                      )
                      .toList(),
                );
              },
            ),

            const Sh5(),

            BlocConsumer<AddTaskBloc, AddTaskState>(
              listenWhen: (previous, current) => previous.addTaskDataState != current.addTaskDataState,
              buildWhen: (previous, current) => previous.addTaskDataState != current.addTaskDataState,
              listener: (context, state) {
                if (state.addTaskDataState == GenericDataState.success) {
                  Navigator.pop(context);
                  showMessage(
                    context: context,
                    message: AppStrings.strSuccessAdd.tr(context),
                    messageType: MessageType.success,
                  );
                } else if (state.addTaskDataState == GenericDataState.failure) {
                  showMessage(context: context, message: state.failure?.message ?? '');
                }
              },
              builder: (context, state) {
                return GenericButton(
                  label: AppStrings.strSave.tr(context),
                  onPressed: () => _onPressedAddTask(context),
                  isLoading: state.addTaskDataState == GenericDataState.loading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _onPressedAddTask(BuildContext context) {
    if (_nameTaskController.text.isEmpty) {
      showMessage(context: context, message: AppStrings.strPleaseEnterTaskName.tr(context));
      return;
    }
    if (userId == -1) {
      showMessage(context: context, message: AppStrings.strPleaseChooseUser.tr(context));
      return;
    }
    context.read<AddTaskBloc>().add(
          GetAddTaskEvent(
            AddTaskRequestDto(
              todo: _nameTaskController.text,
              isCompleted: false,
              userId: userId,
            ),
          ),
        );
  }
}
