// import 'package:flutter/material.dart';
//
// import 'package:swan/app/core/values/colors.dart';
// import 'package:swan/app/core/values/strings.dart';
//
// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: false,
//     brightness: Brightness.light,
//     fontFamily: AppStrings.fontFamily,
//     primaryColor: AppColors.primary,
//     appBarTheme: const AppBarTheme(
//       color: AppColors.primary,
//       elevation: 0.0,
//       scrolledUnderElevation: 0.0,
//       surfaceTintColor: Colors.transparent,
//       shadowColor: Colors.transparent,
//     ),
//
//     textTheme: const TextTheme(
//       labelMedium: TextStyle(
//         color: AppColors.textColor2,
//         fontWeight: FontWeight.w400,
//         fontSize: 16,
//       ),
//       bodyMedium: TextStyle(
//         fontSize: 14,
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w400,
//         fontFamily: AppStrings.fontFamily,
//       ),
//       displaySmall: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       displayMedium: TextStyle(
//         color: AppColors.textColor2,
//         fontWeight: FontWeight.w500,
//         fontSize: 18,
//       ),
//       bodyLarge: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w600,
//         fontSize: 28,
//       ),
//       labelLarge: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 38,
//       ),
//       titleMedium: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//
//       ///for small text
//       bodySmall: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w400,
//         fontSize: 13,
//       ),
//     ),
//     inputDecorationTheme: const InputDecorationTheme(
//       labelStyle: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       hintStyle: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: AppColors.primary),
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: AppColors.primary),
//       ),
//     ),
//     checkboxTheme: CheckboxThemeData(
//       //TODO no border on uncheck
//       side: MaterialStateBorderSide.resolveWith(
//         (states) => const BorderSide(
//           width: 1.0,
//           color: AppColors.checkboxborder,
//         ),
//       ),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//       ),
//       fillColor: const MaterialStatePropertyAll(
//         AppColors.viewAll,
//       ),
//       checkColor: const MaterialStatePropertyAll(AppColors.textColor1),
//       overlayColor: const MaterialStatePropertyAll(AppColors.textColor2),
//     ),
//     expansionTileTheme: const ExpansionTileThemeData(
//       iconColor: AppColors.bottomSelectedColor,
//     ),
//
//     ///
//   );
//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     fontFamily: AppStrings.fontFamily,
//     primaryColor: AppColors.primary,
//
//     ///text theme
//     textTheme: const TextTheme(
//       labelMedium: TextStyle(
//         color: AppColors.textColor2,
//         fontWeight: FontWeight.w400,
//         fontSize: 16,
//       ),
//       bodyMedium: TextStyle(
//         fontSize: 14,
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w400,
//         fontFamily: AppStrings.fontFamily,
//       ),
//       displaySmall: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       bodyLarge: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w600,
//         fontSize: 32,
//       ),
//       labelLarge: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 38,
//       ),
//       titleMedium: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//
//       ///for small text
//       bodySmall: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w400,
//         fontSize: 13,
//       ),
//     ),
//
//     ///textfield theme
//     inputDecorationTheme: const InputDecorationTheme(
//       labelStyle: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       hintStyle: TextStyle(
//         color: AppColors.textColor1,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: AppColors.primary),
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: BorderSide(color: AppColors.primary),
//       ),
//     ),
//     appBarTheme: const AppBarTheme(
//       color: AppColors.primaryDark,
//       elevation: 0.0,
//     ),
//   );
// }
