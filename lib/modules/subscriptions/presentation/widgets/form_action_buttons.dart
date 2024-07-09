import 'package:flutter/material.dart';
import 'package:step_sub/commons/strings.dart';
import 'package:step_sub/utilities/extensions.dart';

class FormActionButtons extends StatelessWidget {
  const FormActionButtons({
    super.key,
    required this.onNextButtonPress,
    required this.onBackButtonPress,
    required this.stepIndex,
    this.isFormCompleted = false,
  });

  final VoidCallback onNextButtonPress;
  final VoidCallback onBackButtonPress;
  final int stepIndex;
  final bool isFormCompleted;

  @override
  Widget build(BuildContext context) {
    final strings = LocalizedStrings(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (stepIndex == 1 || stepIndex == 2)
            TextButton(
              onPressed: onBackButtonPress,
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 16,
                    color: context.colorTheme.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    strings.previous,
                    style: context.textStyle?.labelMedium,
                  ),
                ],
              ),
            ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onNextButtonPress,
            child: Row(
              children: [
                Text(
                  isFormCompleted
                      ? strings.close
                      : stepIndex == 2
                          ? strings.confirm
                          : strings.next,
                  style: context.textStyle?.labelMedium,
                ),
                if (!(stepIndex == 2) && !isFormCompleted) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: context.colorTheme.white,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
