import 'package:flutter/material.dart';
import 'package:step_sub/commons/constants.dart';
import 'package:step_sub/commons/strings.dart';
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
    final strings = LocalizedStrings(context);
    return isSummary && !isMobileScreenSize(context)
        ? IntrinsicHeight(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: context.colorTheme.whiteBackground,
                borderRadius: BorderRadius.circular(8.0),
                border: isSelected
                    ? Border.all(
                        color: context.colorTheme.grey,
                        width: 2,
                      )
                    : const Border(),
                boxShadow: [
                  BoxShadow(
                    color: context.colorTheme.grey.withOpacity(0.5),
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
                      Icon(
                        title.getIcon(context),
                        size: 48,
                      ),
                      Text(
                        '$price\u{20AC}/${paymentPlanType.getName(context)}',
                        style: context.textStyle?.titleMedium?.copyWith(color: context.colorTheme.black),
                      ),
                      if (paymentPlanType == PaymentPlanType.yearly)
                        Text(
                          strings.twoMonthsForFree,
                          style: context.textStyle?.titleMedium?.copyWith(color: context.colorTheme.black),
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
                                title.getName(context),
                                style: context.textStyle?.titleLarge,
                              ),
                            ),
                            ToggleButtons(
                              onPressed: (int index) => onTypeToggle(index),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: context.colorTheme.primaryColor,
                              selectedColor: context.colorTheme.white,
                              fillColor: context.colorTheme.primaryColor,
                              color: context.colorTheme.primaryColor,
                              borderColor: context.colorTheme.grey.withOpacity(0.3),
                              constraints: const BoxConstraints(
                                minHeight: 40.0,
                                minWidth: 80.0,
                              ),
                              isSelected: [
                                paymentPlanType.name == PaymentPlanType.monthly.name,
                                paymentPlanType.name == PaymentPlanType.yearly.name
                              ],
                              children: paymentTypeList(context),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Text(strings.includes, style: context.textStyle?.labelMedium),
                        if (title == strings.basicPlan)
                          ...basicPackageFeatures(context).map(
                            (e) => FeatureInclude(textData: e),
                          ),
                        if (title == strings.normalPlan)
                          ...normalPackageFeatures(context).map(
                            (e) => FeatureInclude(textData: e),
                          ),
                        if (title == strings.advancedPlan)
                          ...advancedPackageFeatures(context).map(
                            (e) => FeatureInclude(textData: e),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${strings.subscriptionEndsOn} ${paymentPlanType.getDate()}',
                              style: context.textStyle?.labelMedium?.copyWith(color: context.colorTheme.black),
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
              color: context.colorTheme.whiteBackground,
              borderRadius: BorderRadius.circular(8.0),
              border: isSelected
                  ? Border.all(
                      color: context.colorTheme.grey,
                      width: 2,
                    )
                  : const Border(),
              boxShadow: [
                BoxShadow(
                  color: context.colorTheme.grey.withOpacity(0.5),
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
                  textAlign: TextAlign.center,
                ),
                Icon(
                  title.getIcon(context),
                  size: 48,
                ),
                Text(
                  '$price\u{20AC}/${paymentPlanType.getName(context)}',
                  style: context.textStyle?.titleMedium?.copyWith(color: context.colorTheme.black),
                ),
                if (paymentPlanType == PaymentPlanType.yearly)
                  Text(
                    strings.twoMonthsForFree,
                    style: context.textStyle?.titleMedium?.copyWith(color: context.colorTheme.black),
                  ),
                ToggleButtons(
                  onPressed: (int index) => onTypeToggle(index),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: context.colorTheme.primaryColor,
                  selectedColor: context.colorTheme.white,
                  fillColor: context.colorTheme.primaryColor,
                  color: context.colorTheme.primaryColor,
                  borderColor: context.colorTheme.grey.withOpacity(0.3),
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: [
                    paymentPlanType.name == PaymentPlanType.monthly.name,
                    paymentPlanType.name == PaymentPlanType.yearly.name
                  ],
                  children: paymentTypeList(context),
                ),
                const Divider(),
                Text(title.getName(context)),
                const SizedBox(width: 8),
                Text(LocalizedStrings(context).includes, style: context.textStyle?.labelMedium),
                if (title == LocalizedStrings(context).basicPlan)
                  ...basicPackageFeatures(context).map(
                    (e) => FeatureInclude(textData: e),
                  ),
                if (title == LocalizedStrings(context).normalPlan)
                  ...normalPackageFeatures(context).map(
                    (e) => FeatureInclude(textData: e),
                  ),
                if (title == LocalizedStrings(context).advancedPlan)
                  ...advancedPackageFeatures(context).map(
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
        Expanded(
            child: Text(textData, style: context.textStyle?.labelMedium?.copyWith(color: context.colorTheme.black))),
      ],
    );
  }
}
