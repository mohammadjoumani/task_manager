// import 'package:flutter/material.dart';
// import 'package:provider_app/core/utils/widgets/generic_loading.dart';
//
// import 'state_render.dart';
//
// extension FlowStateExtension on FlowState {
//   Widget getScreenWidget(BuildContext context, Widget contentScreen) {
//     switch (runtimeType) {
//       case InitState:
//         {
//           return const SizedBox();
//         }
//       case LoadingState:
//         {
//           return const Center(child: GenericLoading());
//         }
//       case SuccessState:
//         {
//           return contentScreen;
//         }
//       case FailureState:
//         {
//           return Text(getMessage());
//         }
//       default:
//         {
//           return contentScreen;
//         }
//     }
//   }
// }