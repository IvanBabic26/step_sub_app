import 'package:flutter/material.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';

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
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStep(0, true, isStepCompleted: isStepOneCompleted),
              Expanded(
                child: Container(
                  height: 2,
                  color: stepValue == 1 || stepValue == 2 || stepValue == 3
                      ? StepSubColors.primaryColor
                      : StepSubColors.grey,
                ),
              ),
              _buildStep(
                1,
                stepValue == 1 || stepValue == 2,
                isStepCompleted: isStepTwoCompleted,
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: stepValue == 2 || stepValue == 3 ? StepSubColors.primaryColor : StepSubColors.grey,
                ),
              ),
              _buildStep(
                2,
                stepValue == 2,
                isStepCompleted: isFormCompleted,
              ),
            ],
          )
        : SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStep(0, true, isStepCompleted: isStepOneCompleted),
                Container(
                  width: 2,
                  height: 100,
                  color: stepValue == 1 || stepValue == 2 || stepValue == 3
                      ? StepSubColors.primaryColor
                      : StepSubColors.grey,
                ),
                _buildStep(
                  1,
                  stepValue == 1 || stepValue == 2,
                  isStepCompleted: isStepTwoCompleted,
                ),
                Container(
                  width: 2,
                  height: 100,
                  color: stepValue == 2 || stepValue == 3 ? StepSubColors.primaryColor : StepSubColors.grey,
                ),
                _buildStep(
                  2,
                  stepValue == 2,
                  isStepCompleted: isFormCompleted,
                ),
              ],
            ),
          );
  }

  Widget _buildStep(int stepIndex, bool isActive, {bool isStepCompleted = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive || isStepCompleted ? StepSubColors.primaryColor : StepSubColors.grey,
      ),
      child: Center(
        child: isStepCompleted
            ? const Icon(Icons.check, size: 18, color: StepSubColors.white)
            : Text(
                '${stepIndex + 1}',
                style: StepSubTextStyles.primaryTextStyle,
              ),
      ),
    );
  }
}
