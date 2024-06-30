import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.hint,
    required this.returnValue,
    this.isLoading = false,
    this.items = const [],
  });

  final String hint;
  final Function(dynamic) returnValue;
  final bool isLoading;
  final List<DropdownMenuItem> items;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  var item;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ColorManager.colorTextFieldLight,
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        child: DropdownButton(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: 3),
          value: item,
          hint: Text(
            widget.isLoading ? 'Loading...' : widget.hint,
            style: StyleManager.getRegularStyle(color: ColorManager.colorPlaceHolderLight),
          ),
          isExpanded: true,
          items: widget.items,
          onChanged: (value) {
            setState(() {
              item = value;
            });
            widget.returnValue(value);
          },
          underline: const SizedBox(),
        ));
  }
}
