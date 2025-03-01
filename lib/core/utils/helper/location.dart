// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
// import 'package:taskberry_crew/providers/customer/dasboard_provider.dart';
// import 'package:taskberry_crew/utils/helper/toastmsg.dart';
//
// import '../../common_widgets/custom_dialog.dart';
// import '../../providers/my_taskProvider.dart';
//
// Future<Position> currentLocation(BuildContext context) async {
//   bool serviceEnabled;
//   LocationPermission permission;
//   var provider = Provider.of<MyTaskProvider>(context, listen: false);
//   var loader = Provider.of<CustomerDashBoardProvider>(context, listen: false);
//   loader.currentLocationLoading = true;
//   loader.notifyListeners();
//
//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     provider.isLoadingTimerStatusChange = false;
//     loader.currentLocationLoading = false;
//     loader.notifyListeners();
//     provider.notifyListeners();
//     cancelOrder(
//       canEdit: false,
//       title:
//           'Location services are disabled...?\n Please turn on location services to continue. ',
//       context: context,
//     );
//     // ToastUtil.show("Location services are disabled.");
//     return Future.error('Location services are disabled.');
//   }
//
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     // ToastUtil.show(
//     //     "Location permissions are permanently denied, we cannot request permissions");
//     // await Geolocator.openAppSettings();
//     // showEnableLocationDialog(
//     //     ctx: context,
//     //     onTap: () async {
//     //       Navigator.of(context).pop();
//     //       await Geolocator.openAppSettings();
//     //     });
//
//     provider.isLoadingTimerStatusChange = false;
//     provider.notifyListeners();
//     loader.currentLocationLoading = false;
//     loader.notifyListeners();
//     cancelOrder(
//       submit: () async {
//         Navigator.of(context).pop();
//         await Geolocator.openAppSettings();
//       },
//       title:
//           'Please enable the location service in your device settings to use this feature...?',
//       context: context,
//     );
//
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//
//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   Position? position;
//   position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   return position;
// }
//
// void showEnableLocationDialog(
//     {required BuildContext ctx, required void Function()? onTap}) {
//   showDialog(
//     context: ctx,
//     barrierDismissible: false,
//     useSafeArea: true,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Enable Location Service'),
//         content: const Text(
//             'Please enable the location service in your device settings to use this feature.'),
//         actions: [
//           TextButton(
//             child: const Text('No, thanks'),
//             onPressed: () async {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(onPressed: onTap, child: const Text('OK')),
//         ],
//       );
//     },
//   );
// }
