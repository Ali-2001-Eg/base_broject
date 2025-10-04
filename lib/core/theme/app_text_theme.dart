part of 'theme.dart';


mixin AppThemeData on ThemeData {
  static ThemeData light(BuildContext context) => ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromRGBO(81, 82, 221, 1),
    colorScheme: ColorScheme.light(
      primary: const Color.fromRGBO(81, 82, 221, 1),
      secondary: HexColor.fromHex('#083740'),
      surface: Colors.white,
      error: Colors.red,

      onPrimary: const Color.fromRGBO(27, 22, 94, 1),
      onSecondary: const Color.fromRGBO(22, 82, 166, 1),
      onSurface: Colors.black,
      onError: Colors.white,
      outlineVariant: Colors.blueAccent,
      onInverseSurface: Colors.grey[200],
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  AppBarTheme(
        color: Colors.white,
        titleTextStyle: AppTextTheme.headlineLarge,
        surfaceTintColor: Colors.white,
        elevation: 0
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.teal,
      selectionColor: Colors.teal,
      selectionHandleColor: Colors.teal,
    ),
    fontFamily: 'Montserrat',
    textTheme: TextTheme(
      bodyLarge: AppTextTheme.bodyLarge,
      bodyMedium: AppTextTheme.bodyMedium,
      bodySmall: AppTextTheme.bodySmall,
      labelLarge: AppTextTheme.labelLarge,
      labelMedium: AppTextTheme.labelMedium,
      labelSmall: AppTextTheme.labelSmall,
      titleLarge: AppTextTheme.titleLarge,
      titleMedium: AppTextTheme.titleMedium,
      titleSmall: AppTextTheme.titleSmall,
      displayLarge: AppTextTheme.displayLarge,
      displayMedium: AppTextTheme.displayMedium,
      displaySmall: AppTextTheme.displaySmall,
      headlineLarge: AppTextTheme.headlineLarge,
      headlineMedium: AppTextTheme.headlineMedium,
      headlineSmall: AppTextTheme.headlineSmall,
    )..apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
      fontFamilyFallback: ['Arial', 'sans-serif'],
      fontFamily: 'Montserrat',
    ),

    inputDecorationTheme: InputDecorationTheme(
      errorStyle: AppTextTheme.bodyMedium.copyWith(color: Colors.red,fontSize: 20.sp),
    ),
    // textSelectionTheme: ,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),

  );
}