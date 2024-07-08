import 'package:flutter/material.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (stepIndex == 1 || stepIndex == 2)
            TextButton(
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
              onPressed: onBackButtonPress,
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 16,
                    color: StepSubColors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Previous',
                    style: StepSubTextStyles.buttonTextStyle,
                  ),
                ],
              ),
            ),
          const SizedBox(width: 8),
          TextButton(
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
            onPressed: onNextButtonPress,
            child: Row(
              children: [
                Text(
                  isFormCompleted
                      ? 'Close'
                      : stepIndex == 2
                          ? 'Confirm'
                          : 'Next',
                  style: StepSubTextStyles.buttonTextStyle,
                ),
                if (!(stepIndex == 2) && !isFormCompleted) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: StepSubColors.white,
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
