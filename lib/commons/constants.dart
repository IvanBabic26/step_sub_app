import 'package:flutter/material.dart';
import 'package:step_sub/commons/strings.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/utilities/extensions.dart';

List<PaymentPlan> defaultPaymentPlans(BuildContext context) => [
      PaymentPlan(id: '1',name: LocalizedStrings(context).basicPlan.toString(), price: 9),
      PaymentPlan(id: '2',name: LocalizedStrings(context).normalPlan.toString(), price: 12),
      PaymentPlan(id: '3',name: LocalizedStrings(context).advancedPlan.toString(), price: 15),
    ];

List<Widget> paymentTypeList(BuildContext context) => <Widget>[
      Text(LocalizedStrings(context).monthly, style: context.textStyle?.titleMedium),
      Text(LocalizedStrings(context).yearly, style: context.textStyle?.titleMedium),
    ];

List<String> basicPackageFeatures(BuildContext context) => [
      LocalizedStrings(context).limitedAccess,
      LocalizedStrings(context).oneDevice,
      LocalizedStrings(context).monthlyReport
    ];

List<String> normalPackageFeatures(BuildContext context) => [
      LocalizedStrings(context).customizableFeatures,
      LocalizedStrings(context).threeDevices,
      LocalizedStrings(context).monthlyWeeklyReport,
    ];

List<String> advancedPackageFeatures(BuildContext context) => [
      LocalizedStrings(context).fullAccess,
      LocalizedStrings(context).unlimitedDevices,
      LocalizedStrings(context).detailedReports,
    ];
