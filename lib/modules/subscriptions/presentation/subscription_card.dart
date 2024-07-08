import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_sub/commons/constants.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/utilities/extensions.dart';
import 'package:step_sub/utilities/utils.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.paymentPlanType,
    required this.onTypeToggle,
    this.isSelected = false,
    this.isSummary = false,
  });

  final String title;
  final int price;
  final PaymentPlanType paymentPlanType;
  final Function(int) onTypeToggle;
  final bool isSelected;
  final bool isSummary;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime nextMonth = DateTime(now.year, now.month + 1, now.day);
    DateTime nextYear = DateTime(now.year + 1, now.month, now.day);
    String formattedNextMonth = DateFormat('dd MMMM yyyy').format(nextMonth);
    String formattedNextYear = DateFormat('dd MMMM yyyy').format(nextYear);
    return isSummary && !isMobileScreenSize(context)
        ? IntrinsicHeight(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: StepSubColors.whiteBackground,
                borderRadius: BorderRadius.circular(8.0),
                border: isSelected
                    ? Border.all(
                        color: StepSubColors.grey,
                        width: 2,
                      )
                    : const Border(),
                boxShadow: [
                  BoxShadow(
                    color: StepSubColors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(fontSize: 32),
                      ),
                      const Icon(
                        Icons.start,
                        size: 48,
                      ),
                      Text(
                        '$price\u{20AC}/${paymentPlanType.getName()}',
                        style: StepSubTextStyles.primaryTextStyle.copyWith(color: StepSubColors.black),
                      ),
                      if (paymentPlanType == PaymentPlanType.yearly)
                        Text(
                          '(2 months for free)',
                          style: StepSubTextStyles.primaryTextStyle.copyWith(color: StepSubColors.black),
                        ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: VerticalDivider(),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Starter pack'.toUpperCase(),
                                style: StepSubTextStyles.primaryDesktopTextStyle,
                              ),
                            ),
                            ToggleButtons(
                              onPressed: (int index) => onTypeToggle(index),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: StepSubColors.primaryColor,
                              selectedColor: StepSubColors.white,
                              fillColor: StepSubColors.primaryColor,
                              color: StepSubColors.primaryColor,
                              borderColor: StepSubColors.grey.withOpacity(0.3),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: [
                                paymentPlanType.name == PaymentPlanType.monthly.name,
                                paymentPlanType.name == PaymentPlanType.yearly.name
                              ],
                              children: paymentTypeList,
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Text('Includes:', style: StepSubTextStyles.buttonTextStyle),
                        if (title == 'Basic')
                          ...basicPackageFeatures.map(
                            (e) => FeatureInclude(textData: e),
                          ),
                        if (title == 'Normal')
                          ...normalPackageFeatures.map(
                            (e) => FeatureInclude(textData: e),
                          ),
                        if (title == 'Advanced')
                          ...advancedPackageFeatures.map(
                            (e) => FeatureInclude(textData: e),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Subscription ends on: ${paymentPlanType == PaymentPlanType.monthly ? formattedNextMonth : formattedNextYear}',
                              style: StepSubTextStyles.buttonTextStyle.copyWith(color: StepSubColors.black),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: StepSubColors.whiteBackground,
              borderRadius: BorderRadius.circular(8.0),
              border: isSelected
                  ? Border.all(
                      color: StepSubColors.grey,
                      width: 2,
                    )
                  : const Border(),
              boxShadow: [
                BoxShadow(
                  color: StepSubColors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(fontSize: 32),
                ),
                const Icon(
                  Icons.start,
                  size: 48,
                ),
                Text(
                  '$price\u{20AC}/${paymentPlanType.getName()}',
                  style: StepSubTextStyles.primaryTextStyle.copyWith(color: StepSubColors.black),
                ),
                if (paymentPlanType == PaymentPlanType.yearly)
                  Text(
                    '(2 months for free)',
                    style: StepSubTextStyles.primaryTextStyle.copyWith(color: StepSubColors.black),
                  ),
                ToggleButtons(
                  onPressed: (int index) => onTypeToggle(index),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: StepSubColors.primaryColor,
                  selectedColor: StepSubColors.white,
                  fillColor: StepSubColors.primaryColor,
                  color: StepSubColors.primaryColor,
                  borderColor: StepSubColors.grey.withOpacity(0.3),
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: [
                    paymentPlanType.name == PaymentPlanType.monthly.name,
                    paymentPlanType.name == PaymentPlanType.yearly.name
                  ],
                  children: paymentTypeList,
                ),
                const Divider(),
                Text('Starter pack'.toUpperCase()),
                const SizedBox(width: 8),
                const Text('Includes:', style: StepSubTextStyles.buttonTextStyle),
                if (title == 'Basic')
                  ...basicPackageFeatures.map(
                    (e) => FeatureInclude(textData: e),
                  ),
                if (title == 'Normal')
                  ...normalPackageFeatures.map(
                    (e) => FeatureInclude(textData: e),
                  ),
                if (title == 'Advanced')
                  ...advancedPackageFeatures.map(
                    (e) => FeatureInclude(textData: e),
                  ),
              ],
            ),
          );
  }
}

class FeatureInclude extends StatelessWidget {
  const FeatureInclude({super.key, required this.textData});

  final String textData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.fiber_manual_record, size: 10),
        const SizedBox(width: 8),
        Expanded(child: Text(textData, style: StepSubTextStyles.buttonTextStyle.copyWith(color: StepSubColors.black))),
      ],
    );
  }
}
