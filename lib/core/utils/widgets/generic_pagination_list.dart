import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';

import 'generic_button.dart';
import 'generic_loading.dart';
import 'margin.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, int index, T item);

class GenericPaginationList<T> extends StatelessWidget {
  const GenericPaginationList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.isLoading,
    required this.isDone,
    required this.isError,
    required this.error,
    this.padding = AppPadding.p16,
    this.itemSpace = const Sh4(),
  });

  final List<T> items;
  final ItemBuilder itemBuilder;
  final VoidCallback onLoadMore;
  final bool isLoading;
  final bool isDone;
  final bool isError;
  final String error;
  final double padding;
  final Widget itemSpace;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !isDone) {
          onLoadMore();
        }
        return true;
      },
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index < items.length) {
            return itemBuilder(context, index, items[index]);
          } else if (isLoading) {
            return _loadingPagination();
          } else if (isError) {
            return _errorPagination(context);
          } else {
            return const SizedBox();
          }
        },
        padding: EdgeInsets.all(padding),
        separatorBuilder: (BuildContext context, int index) => itemSpace,
        itemCount: items.length + ((isLoading || isError) ? 1 : 0), // +1 for the loading indicator
      ),
    );
  }

  _loadingPagination() {
    return const Padding(
      padding: EdgeInsets.all(AppPadding.p8),
      child: Center(child: GenericLoading()),
    );
  }

  _errorPagination(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            error,
            style: StyleManager.getMediumStyle(color: ColorManager.colorError),
          ),
          const Sh2(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: GenericButton(
              label: AppStrings.strTryAgain.tr(context),
              onPressed: () => onLoadMore(),
              buttonSize: ButtonSize.small,
              buttonType: ButtonType.outline,
            ),
          ),
        ],
      ),
    );
  }
}
