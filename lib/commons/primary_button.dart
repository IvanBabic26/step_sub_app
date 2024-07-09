import 'package:flutter/material.dart';
import 'package:step_sub/utilities/extensions.dart';

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
        backgroundColor: backgroundColor != null
            ? WidgetStateProperty.all<Color>(backgroundColor!)
            : context.elevatedButtonStyle?.backgroundColor,
        foregroundColor: buttonTitleColor != null
            ? WidgetStateProperty.all<Color>(buttonTitleColor!)
            : context.elevatedButtonStyle?.foregroundColor,
        shadowColor: showShadows
            ? WidgetStateProperty.all<Color>(context.colorTheme.black)
            : context.elevatedButtonStyle?.shadowColor,
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
                Text(buttonTitle), // Centered Text
              ],
            ),
          ),
          if (trailingIcon != null) trailingIcon!
        ],
      ),
    );
  }
}
