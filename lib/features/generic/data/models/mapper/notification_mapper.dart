//
// import 'package:sehaone/core/app/constants.dart';
// import 'package:sehaone/core/app/extensions.dart';
// import 'package:sehaone/features/generic/data/models/dto/response/notification_response_dto.dart';
// import 'package:sehaone/features/generic/domain/entities/notification.dart';
//
// extension NotificationMapper on NotificationResponseDto {
//   NotificationMessage toDomain() {
//     return NotificationMessage(
//       id?.orZero() ?? Constants.zero,
//       message?.orEmpty() ?? Constants.empty,
//       text?.orEmpty() ?? Constants.empty,
//       isReadByPatient?.orFalse() ?? Constants.falseValue,
//       patientId?.orZero() ?? Constants.zero,
//       providerBranchId?.orZero() ?? Constants.zero,
//       claimId?.orZero() ?? Constants.zero,
//       createdAt?.orEmpty() ?? Constants.empty,
//       updatedAt?.orEmpty() ?? Constants.empty,
//     );
//   }
// }
//
// extension NotificationListMapper on List<NotificationResponseDto> {
//   List<NotificationMessage> toDomain() {
//     return map((e) => e.toDomain()).toList();
//   }
// }
