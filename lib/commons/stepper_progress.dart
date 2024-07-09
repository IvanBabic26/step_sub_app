import 'package:flutter/material.dart';
import 'package:step_sub/utilities/extensions.dart';

class StepperProgress extends StatelessWidget {
  const StepperProgress({
    super.key,
    required this.stepValue,
    this.isStepOneCompleted = false,
    this.isStepTwoCompleted = false,
    this.isFormCompleted = false,
    this.isMobileScreenSize = true,
  });

  final bool isMobileScreenSize;
  final int stepValue;
  final bool isStepOneCompleted;
  final bool isStepTwoCompleted;
  final bool isFormCompleted;

  @override
  Widget build(BuildContext context) {
    return isMobileScreenSize
        ? Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStep(
                  context,
                  0,
                  true,
                  isStepCompleted: isStepOneCompleted,
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: stepValue == 1 || stepValue == 2 || stepValue == 3
                        ? context.colorTheme.primaryColor
                        : context.colorTheme.grey,
                  ),
                ),
                _buildStep(
                  context,
                  1,
                  stepValue == 1 || stepValue == 2,
                  isStepCompleted: isStepTwoCompleted,
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: stepValue == 2 || stepValue == 3 ? context.colorTheme.primaryColor : context.colorTheme.grey,
                  ),
                ),
                _buildStep(
                  context,
                  2,
                  stepValue == 2,
                  isStepCompleted: isFormCompleted,
                ),
              ],
            ),
        )
        : SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStep(
                  context,
                  0,
                  true,
                  isStepCompleted: isStepOneCompleted,
                ),
                Container(
                  width: 2,
                  height: 100,
                  color: stepValue == 1 || stepValue == 2 || stepValue == 3
                      ? context.colorTheme.primaryColor
                      : context.colorTheme.grey,
                ),
                _buildStep(
                  context,
                  1,
                  stepValue == 1 || stepValue == 2,
                  isStepCompleted: isStepTwoCompleted,
                ),
                Container(
                  width: 2,
                  height: 100,
                  color: stepValue == 2 || stepValue == 3 ? context.colorTheme.primaryColor : context.colorTheme.grey,
                ),
                _buildStep(
                  context,
                  2,
                  stepValue == 2,
                  isStepCompleted: isFormCompleted,
                ),
              ],
            ),
          );
  }

  Widget _buildStep(BuildContext context, int stepIndex, bool isActive, {bool isStepCompleted = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive || isStepCompleted ? context.colorTheme.primaryColor : context.colorTheme.grey,
      ),
      child: Center(
        child: isStepCompleted
            ? Icon(Icons.check, size: 18, color: context.colorTheme.white)
            : Text(
                '${stepIndex + 1}',
                style: context.textStyle?.titleMedium,
              ),
      ),
    );
  }
}
