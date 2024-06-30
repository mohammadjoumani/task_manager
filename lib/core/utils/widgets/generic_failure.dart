import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/core/network/error_handler.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';

import 'generic_button.dart';
import 'margin.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'AssetsManager.imgDataNotFound',
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        const Sh3(),
        Text(message),
      ],
    );
  }
}

class GenericFailure extends StatelessWidget {
  const GenericFailure({super.key, required this.failure, required this.onTryAgain});

  final Failure? failure;
  final Function onTryAgain;

  @override
  Widget build(BuildContext context) {
    if (failure != null) {
      switch (failure!.code) {
        case ResponseCode.noInternetConnection:
          return _notConnectionInternetState(context);
        case ResponseCode.unauthorised:
          return _errorState(context);
        case ResponseCode.locationDenied:
          return _locationDenied(context);
        default:
          return _errorState(context);
      }
    } else {
      return _notFoundDataState(context);
    }
  }

  _notFoundDataState(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'AssetsManager.imgDataNotFound',
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        const Sh3(),
        Text(
          failure?.message ?? '',
          style: StyleManager.getMediumStyle(color: ColorManager.colorBlack),
        ),
      ],
    );
  }

  _notConnectionInternetState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'AssetsManager.imgNoConnectionInternet',
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
          ),
          const Sh3(),
          Text(
            failure?.message ?? '',
            style: StyleManager.getMediumStyle(color: ColorManager.colorBlack),
          ),
          const Sh4(),
          GenericButton(
            label: AppStrings.strTryAgain.tr(context),
            onPressed: () => onTryAgain(),
          ),
        ],
      ),
    );
  }

  _errorState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'AssetsManager.imgError',
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
          ),
          const Sh3(),
          Text(
            failure?.message ?? '',
            style: StyleManager.getMediumStyle(color: ColorManager.colorBlack),
          ),
          const Sh4(),
          GenericButton(
            label: AppStrings.strTryAgain.tr(context),
            onPressed: () => onTryAgain(),
          ),
          // const Sh3(),
          // GenericButton(
          //   label: AppStrings.strContactUs.tr(context),
          //   onPressed: () {
          //     launchUrlString(Constants.whatsAppNumberUrl);
          //   },
          //   buttonType: ButtonType.outline,
          // ),
        ],
      ),
    );
  }

  _locationDenied(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'AssetsManager.imgLocation',
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
          ),
          const Sh3(),
          // Text(
          //   AppStrings.strLocationDenied.tr(context),
          //   style: StyleManager.getMediumStyle(color: ColorManager.colorBlack4),
          //   textAlign: TextAlign.center,
          // ),
          const Sh4(),
          GenericButton(
            label: AppStrings.strTryAgain.tr(context),
            onPressed: () => onTryAgain(),
            assetsIcon: 'AssetsManager.imgCurrentLocation',
            buttonType: ButtonType.outline,
          ),
        ],
      ),
    );
  }
}
