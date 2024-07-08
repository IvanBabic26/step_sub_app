import 'package:flutter/material.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';

List<PaymentPlan> defaultPaymentPlans = [
  PaymentPlan(name: 'Basic', price: 9),
  PaymentPlan(name: 'Normal', price: 12),
  PaymentPlan(name: 'Advanced', price: 15),
];

List<Widget> paymentTypeList = <Widget>[
  const Text('Monthly', style: StepSubTextStyles.titleTextStyle),
  const Text('Yearly', style: StepSubTextStyles.titleTextStyle),
];

List<String> basicPackageFeatures = ['Limited access to features', 'Only 1 connected device', 'Monthly data report'];
List<String> normalPackageFeatures = [
  'Customizable features',
  'Up to 3 connected devices',
  'Monthly and weekly data report'
];
List<String> advancedPackageFeatures = ['Full app access', 'Unlimited connected devices', 'Detailed reports'];
