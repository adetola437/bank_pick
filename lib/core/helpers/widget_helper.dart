// import 'package:go_router/go_router.dart';
// import 'package:mapxmobile/features/auth/presentation/widgets/connect_modal.dart';
// import 'package:mapxmobile/features/auth/presentation/widgets/farm_details_modal.dart';
// import 'package:mapxmobile/features/auth/presentation/widgets/register_farmer_modal.dart';
// import 'package:mapxmobile/features/auth/presentation/widgets/sync_modal.dart';

// import '../../features/auth/presentation/screens/controllers/farmer_profile_controller.dart';
// import '../../features/auth/presentation/screens/controllers/take_point_controller.dart';
// import '../../features/auth/presentation/widgets/mapped_modal.dart';
// import '../core.dart';

// abstract class IWidgetHelper {
//   Future<dynamic> showModalBottomSheetView(BuildContext context, Widget child);
//   void showLoading();
//   void hideLoading();
//   void showError(String message);
//   void dialog(BuildContext context);
//   void showSuccess(String message);
//   void showWarning(String message);
//   void showModal(BuildContext context);
//   void showSyncModal(BuildContext context);
//   void saveFarmlandModal(BuildContext context);
//   void showErroModal(BuildContext context);
//   void showFarmDetailsModal(BuildContext context);
//   void showRegisteredFarmerModal(BuildContext context);
// }

// class WidgetHelper implements IWidgetHelper {
//   @override
//   Future<dynamic> showModalBottomSheetView(BuildContext context, Widget child,
//       {bool isScrollControlled = true}) async {
//     return await showModalBottomSheet(
//       context: context,
//       isScrollControlled: isScrollControlled,
//       builder: (context) => child,
//     );
//   }

//   @override
//   void hideLoading() {
//     // TODO: implement hideLoading
//   }

//   @override
//   void showError(String message) {
//     // TODO: implement showError
//   }

//   @override
//   void showLoading() {
//     // TODO: implement showLoading
//   }

//   @override
//   void showSuccess(String message) {
//     // TODO: implement showSuccess
//   }

//   @override
//   void showWarning(String message) {
//     // TODO: implement showWarning
//   }

//   @override
//   void showModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return const BuildHomeModal();
//       },
//     );
//   }

//   @override
//   void showRegisteredFarmerModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isDismissible: false,
//       builder: (BuildContext context) {
//         return const RegisterFarmerModal();
//       },
//     );
//   }

//   @override
//   void showFarmDetailsModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       isScrollControlled: true,
//       useRootNavigator: true,
//       builder: (BuildContext context) {
//         return const FarmDetailsModal();
//       },
//     );
//   }

//   @override
//   void showErroModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return ConnectModal(
//           image: 'assets/vectors/error_icon.svg',
//           title: 'Please connect your mobile phone to the mapping device',
//           action: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.add,
//                 size: 24.sp,
//               ),
//               'Connect'.toText(
//                   style: context.typography.mdBody16px().copyWith(
//                         height: 1.6,
//                       ))
//             ],
//           ),
//           pressed: () {
//             context
//                 .push('${FarmerProfileScreen.route}/${TakePointScreen.route}');
//           },
//         );
//       },
//     );
//   }

//   @override
//   void saveFarmlandModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return ConnectModal(
//           image: 'assets/vectors/success.svg',
//           title: 'Farm details has been saved successfully',
//           action: 'See Farmland'.toText(
//               style: context.typography.smMdBody14px().copyWith(
//                     height: 1.6,
//                   )),
//           pressed: () {
//             context.push(FarmerProfileScreen.route);
//           },
//         );
//       },
//     );
//   }

//   @override
//   void showSyncModal(BuildContext context) {
//     showModalBottomSheet(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return const SyncModal();
//       },
//     );
//   }

//   @override
//   Future<void> dialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: true, // Dialog can only be dismissed by buttons
//         builder: (BuildContext context) {
//           return SizedBox(
//             height: 152.h,
//             child: AlertDialog(
//               content: Text(
//                 'Are you sure you want to delete this farmland?',
//                 textAlign: TextAlign.center,
//                 style: context.typography
//                     .sbSub14px()
//                     .copyWith(color: context.colors.xDSENeutral10),
//               ),
//               actions: [
//                 const Divider(),
//                 SizedBox(
//                   height: 56.h,
//                   width: double.maxFinite,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             context.pop();
//                           },
//                           child: SizedBox(
//                               width: 179.w,
//                               child: Center(
//                                   child: Text(
//                                 'Cancel',
//                                 style: context.typography.sbSub14px().copyWith(
//                                     color: context.colors.xDSENeutral6),
//                               ))),
//                         ),
//                       ),
//                       const VerticalDivider(),
//                       Expanded(
//                         child: SizedBox(
//                             width: 179.w,
//                             child: Center(
//                                 child: Text(
//                               'Yes, Delete',
//                               style: context.typography
//                                   .sbSub14px()
//                                   .copyWith(color: context.colors.xDSAred7),
//                             ))),
//                       )
//                     ],
//                   ),
//                   // decoration: const BoxDecoration(
//                   //     border: Border(
//                   //         top: BorderSide(color: Colors.black),
//                   //         bottom: BorderSide(color: Colors.black))),
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }
