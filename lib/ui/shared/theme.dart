// import 'package:box_ui/box_ui.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// CustomTheme currentTheme = CustomTheme();

// class CustomTheme with ChangeNotifier {
//   static bool _isLightTheme = true;
//   ThemeMode get currentTheme =>
//       _isLightTheme ? ThemeMode.light : ThemeMode.dark;

//   void toggleTheme({required bool isLightTheme}) {
//     _isLightTheme = isLightTheme;
//     notifyListeners();
//   }

//   static ThemeData get lightTheme {
//     return ThemeData(
//         primaryColor: kcPrimaryColor,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           color: Colors.white,
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
//             statusBarColor: Colors.white,
//             statusBarBrightness: Brightness.light,
//             statusBarIconBrightness: Brightness.dark,
//           ),
//         ),
//         textTheme: const TextTheme(
//           headline1: heading1Style,
//           headline2: heading2Style,
//           headline3: heading3Style,
//           headline4: heading4Style,
//           headline5: heading5Style,
//           headline6: heading6Style,
//           bodyText1: bodyStyle,
//         )
//         );
//   }

//   static ThemeData get darkTheme {
//     return ThemeData(
//         primaryColor: kcPrimaryColor,
//         scaffoldBackgroundColor: Colors.grey,
//         appBarTheme: AppBarTheme(
//           color: Colors.grey,
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
//             statusBarColor: Colors.black,
//             statusBarBrightness: Brightness.dark,
//             statusBarIconBrightness: Brightness.light,
//           ),
//         ),
//         textTheme: TextTheme(
//           headline1: heading1Style.copyWith(color: Colors.white),
//           headline2: heading2Style.copyWith(color: Colors.white),
//           headline3: heading3Style.copyWith(color: Colors.white),
//           headline4: heading4Style.copyWith(color: Colors.white),
//           headline5: heading5Style.copyWith(color: Colors.white),
//           headline6: heading6Style.copyWith(color: Colors.white),
//           bodyText1: bodyStyle.copyWith(color: Colors.white),
//         )
        
//         );
//   }
// }
