import 'package:flutter/material.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    required this.leadingIcon,
    this.trailingIcon,
    this.backgroundColor,
    this.buttonTitleColor,
    this.showShadows = false,
  });

  final VoidCallback onPressed;
  final String buttonTitle;
  final Widget leadingIcon;
  final Widget? trailingIcon;
  final Color? backgroundColor;
  final Color? buttonTitleColor;
  final bool showShadows;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(8.0)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        ),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return backgroundColor ?? StepSubColors.whiteBackground;
        }),
        shadowColor: WidgetStateProperty.all<Color>(showShadows ? StepSubColors.black : StepSubColors.transparent),
        elevation: WidgetStateProperty.all<double>(showShadows ? 4.0 : 0),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                leadingIcon, // Left Icon
                const SizedBox(width: 8.0),
                Text(
                  buttonTitle,
                  style: StepSubTextStyles.primaryTextStyle.copyWith(
                    color: buttonTitleColor ?? StepSubColors.white,
                  ),
                ), // Centered Text
              ],
            ),
          ),
          if (trailingIcon != null) trailingIcon!
        ],
      ),
    );
  }
}