import 'package:flutter/material.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';
import 'package:step_sub/utilities/extensions.dart';
import 'package:step_sub/utilities/utils.dart';

ThemeData themeData(BuildContext context) => ThemeData(
      useMaterial3: true,
      primaryColor: StepSubColors.primaryColor,
      fontFamily: 'Lato',
      textTheme: TextTheme(
        bodyMedium:
            isMobileScreenSize(context) ? StepSubTextStyles.titleTextStyle : StepSubTextStyles.primaryDesktopTextStyle,
        labelMedium: StepSubTextStyles.buttonTextStyle,
        headlineMedium: StepSubTextStyles.titleTextStyle,
        titleLarge: StepSubTextStyles.primaryDesktopTextStyle,
        titleMedium: StepSubTextStyles.primaryTextStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(8.0)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(StepSubColors.whiteBackground),
          foregroundColor: WidgetStateProperty.all<Color>(StepSubColors.white),
          shadowColor: WidgetStateProperty.all<Color>(StepSubColors.black),
          elevation: WidgetStateProperty.all<double>(4.0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return StepSubColors.lightBlue;
              }
              return null;
            },
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              return StepSubColors.primaryColor;
            },
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: context.textStyle?.titleMedium,
        labelStyle: context.textStyle?.titleMedium,
        filled: true,
        fillColor: StepSubColors.grey.withOpacity(0.2),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        StepSubColorTheme(
          primaryColor: StepSubColors.primaryColor,
          white: StepSubColors.white,
          black: StepSubColors.black,
          darkBlue: StepSubColors.darkBlue,
          lightBlue: StepSubColors.lightBlue,
          pinkRed: StepSubColors.pinkRed,
          transparent: StepSubColors.transparent,
          whiteBackground: StepSubColors.whiteBackground,
          grey: StepSubColors.grey,
        )
      ],
    );

class StepSubColorTheme extends ThemeExtension<StepSubColorTheme> {
  const StepSubColorTheme({
    required this.white,
    required this.black,
    required this.primaryColor,
    required this.darkBlue,
    required this.lightBlue,
    required this.pinkRed,
    required this.transparent,
    required this.whiteBackground,
    required this.grey,
  });

  final Color white;
  final Color black;
  final Color primaryColor;
  final Color darkBlue;
  final Color lightBlue;
  final Color pinkRed;
  final Color transparent;
  final Color whiteBackground;
  final Color grey;

  @override
  ThemeExtension<StepSubColorTheme> copyWith() {
    throw UnimplementedError();
  }

  @override
  StepSubColorTheme lerp(StepSubColorTheme? other, double t) {
    if (other is! StepSubColorTheme) {
      return this;
    }
    return StepSubColorTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t)!,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t)!,
      pinkRed: Color.lerp(pinkRed, other.pinkRed, t)!,
      transparent: Color.lerp(transparent, other.transparent, t)!,
      whiteBackground: Color.lerp(whiteBackground, other.whiteBackground, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
    );
  }
}
