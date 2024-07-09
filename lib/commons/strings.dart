import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizedStrings {
  late BuildContext context;

  LocalizedStrings(this.context);

  late String login = AppLocalizations.of(context)!.login;
  late String proceedixEnterprise = AppLocalizations.of(context)!.proceedixEnterprise;
  late String basicPlan = AppLocalizations.of(context)!.basicPlan;
  late String normalPlan = AppLocalizations.of(context)!.normalPlan;
  late String advancedPlan = AppLocalizations.of(context)!.advancedPlan;
  late String monthly = AppLocalizations.of(context)!.monthly;
  late String yearly = AppLocalizations.of(context)!.yearly;
  late String limitedAccess = AppLocalizations.of(context)!.limitedAccess;
  late String oneDevice = AppLocalizations.of(context)!.oneDevice;
  late String monthlyReport = AppLocalizations.of(context)!.monthlyReport;
  late String customizableFeatures = AppLocalizations.of(context)!.customizableFeatures;
  late String threeDevices = AppLocalizations.of(context)!.threeDevices;
  late String monthlyWeeklyReport = AppLocalizations.of(context)!.monthlyWeeklyReport;
  late String fullAccess = AppLocalizations.of(context)!.fullAccess;
  late String unlimitedDevices = AppLocalizations.of(context)!.unlimitedDevices;
  late String detailedReports = AppLocalizations.of(context)!.detailedReports;
  late String firstName = AppLocalizations.of(context)!.firstName;
  late String lastName = AppLocalizations.of(context)!.lastName;
  late String emailAddress = AppLocalizations.of(context)!.emailAddress;
  late String phoneNumber = AppLocalizations.of(context)!.phoneNumber;
  late String previous = AppLocalizations.of(context)!.previous;
  late String next = AppLocalizations.of(context)!.next;
  late String confirm = AppLocalizations.of(context)!.confirm;
  late String close = AppLocalizations.of(context)!.close;
  late String twoMonthsForFree = AppLocalizations.of(context)!.twoMonthsForFree;
  late String includes = AppLocalizations.of(context)!.includes;
  late String subscriptionEndsOn = AppLocalizations.of(context)!.subscriptionEndsOn;
  late String completed = AppLocalizations.of(context)!.completed;
  String stepOutOf(index,length) => AppLocalizations.of(context)!.stepOutOf(index, length);
  late String personalInformation = AppLocalizations.of(context)!.personalInformation;
  late String chooseYourSubscriptionPlan = AppLocalizations.of(context)!.chooseYourSubscriptionPlan;
  late String orderSummary = AppLocalizations.of(context)!.orderSummary;
  late String subCompleted = AppLocalizations.of(context)!.subCompleted;
  late String pleaseEnterYourFirstName = AppLocalizations.of(context)!.pleaseEnterYourFirstName;
  late String pleaseEnterYourLastName = AppLocalizations.of(context)!.pleaseEnterYourLastName;
  late String pleaseEnterAPhoneNumber = AppLocalizations.of(context)!.pleaseEnterAPhoneNumber;
  late String pleaseEnterA12DigitNumberWithAreaCode = AppLocalizations.of(context)!.pleaseEnterA12DigitNumberWithAreaCode;
  late String pleaseEnterA10DigitNumber = AppLocalizations.of(context)!.pleaseEnterA10DigitNumber;
  late String pleaseEnterAnEmail = AppLocalizations.of(context)!.pleaseEnterAnEmail;
  late String pleaseEnterAValidEmail = AppLocalizations.of(context)!.pleaseEnterAValidEmail;
  late String starterPack = AppLocalizations.of(context)!.starterPack;
  late String progressive = AppLocalizations.of(context)!.progressive;
  late String professional = AppLocalizations.of(context)!.professional;
  late String month = AppLocalizations.of(context)!.month;
  late String year = AppLocalizations.of(context)!.year;
  late String pleaseSelectSubscriptionPlan = AppLocalizations.of(context)!.pleaseSelectSubscriptionPlan;
}
