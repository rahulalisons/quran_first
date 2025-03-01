// import 'package:flutter/material.dart';
//
//
// class GlobalNavigatorObserver extends RouteObserver<PageRoute> {
//   @override
//   void didPush(route, previousRoute) async {
//     super.didPush(route, previousRoute);
//     _log('push', previousRoute, route);
//   }
//
//   @override
//   void didPop(route, previousRoute) async {
//     super.didPop(route, previousRoute);
//     _log('pop', route, previousRoute);
//   }
//
//   void _log(String method, Route? fromRoute, Route? toRoute) {
//     if (!Get.isRegistered<BaseController>()) {
//       Get.put(BaseController());
//     }
//     final controller = Get.find<BaseController>();
//     switch (Get.currentRoute) {
//       case Routes.HOME:
//         controller.isBottomNeeded.value = true;
//         controller.selectedBottom.value = 0;
//         break;
//       case Routes.CATEGORIES:
//         controller.isBottomNeeded.value = true;
//         controller.selectedBottom.value = 1;
//         break;
//       // case Routes.WISHLIST:
//       //   controller.isBottomNeeded.value = true;
//       //   controller.selectedBottom.value = 2;
//       //   break;
//       case Routes.QUICK_ORDERS:
//         controller.isBottomNeeded.value = true;
//         controller.selectedBottom.value = 2;
//         break;
//       case Routes.CART:
//         controller.isBottomNeeded.value = true;
//         controller.selectedBottom.value = 3;
//         break;
//
//       case Routes.SHOP:
//         controller.isBottomNeeded.value = true;
//         controller.selectedBottom.value = 4;
//         break;
//
//       // case Routes.ACCOUNT:
//       //   controller.isBottomNeeded.value = true;
//       //   controller.selectedBottom.value = 4;
//       //   break;
//       default:
//         controller.isBottomNeeded.value = false;
//     }
//
//    debugPrint(
//         '[Navigator] ${_getPageName(fromRoute)} => ${_getPageName(toRoute)} ($method)');
//   }
//
//   String _getPageName(dynamic route) {
//     try {
//       final routeBuilderString = route.toString();
//       return routeBuilderString
//           .substring(routeBuilderString.lastIndexOf(' ') + 1);
//     } catch (_) {
//       return _.toString();
//     }
//   }
// }
