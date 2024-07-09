import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_sub/commons/strings.dart';
import 'package:step_sub/design/styles.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/utilities/enums.dart';

extension StepsExtension on Steps {
  Steps getValue(bool nextStep) {
    switch (this) {
      case Steps.firstStep:
        return nextStep ? Steps.secondStep : Steps.firstStep;
      case Steps.secondStep:
        return nextStep ? Steps.thirdStep : Steps.firstStep;
      case Steps.thirdStep:
        return nextStep ? Steps.finished : Steps.secondStep;
      case Steps.finished:
        return Steps.firstStep;
    }
  }

  String getTitle(context) {
    final strings = LocalizedStrings(context);
    switch (this) {
      case Steps.firstStep:
        return strings.personalInformation;
      case Steps.secondStep:
        return strings.chooseYourSubscriptionPlan;
      case Steps.thirdStep:
        return strings.orderSummary;
      case Steps.finished:
        return strings.subCompleted;
    }
  }
}

extension IntegerHelperExtension on int {
  getValue() {
    switch (this) {
      case 0:
        return PaymentPlanType.monthly;
      case 1:
        return PaymentPlanType.yearly;
    }
  }
}

extension StringHelperExtension on String {
  getName(context) {
    final strings = LocalizedStrings(context);
    if (this == strings.basicPlan) {
      return strings.starterPack;
    } else if (this == strings.normalPlan) {
      return strings.progressive;
    } else if (this == strings.advancedPlan) {
      return strings.professional;
    }
  }

  getIcon(context) {
    final strings = LocalizedStrings(context);
    if (this == strings.basicPlan) {
      return Icons.star;
    } else if (this == strings.normalPlan) {
      return Icons.business_center_outlined;
    } else if (this == strings.advancedPlan) {
      return Icons.business;
    }
  }
}

extension PaymentPlanTypeExtension on PaymentPlanType {
  getName(context) {
    final strings = LocalizedStrings(context);
    switch (this) {
      case PaymentPlanType.monthly:
        return strings.month.toLowerCase();
      case PaymentPlanType.yearly:
        return strings.year.toLowerCase();
    }
  }

  String getDate() {
    DateTime now = DateTime.now();
    DateTime nextMonth = DateTime(now.year, now.month + 1, now.day);
    DateTime nextYear = DateTime(now.year + 1, now.month, now.day);
    String formattedNextMonth = DateFormat('dd MMMM yyyy').format(nextMonth);
    String formattedNextYear = DateFormat('dd MMMM yyyy').format(nextYear);

    switch (this) {
      case PaymentPlanType.monthly:
        return formattedNextMonth;
      case PaymentPlanType.yearly:
        return formattedNextYear;
    }
  }
}

extension StepSubAppContext on BuildContext {
  StepSubColorTheme get colorTheme => Theme.of(this).extension<StepSubColorTheme>()!;

  ThemeData? get getThemeData => ThemeData();

  TextTheme? get textStyle => Theme.of(this).textTheme;

  ButtonStyle? get elevatedButtonStyle => Theme.of(this).elevatedButtonTheme.style;

  ButtonStyle? get textButtonStyle => Theme.of(this).textButtonTheme.style;
}
