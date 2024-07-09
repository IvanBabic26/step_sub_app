// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:step_sub/core/injection_container.dart';
// import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
// import 'package:step_sub/utilities/enums.dart';
// import 'package:step_sub/utilities/extensions.dart';
//
// part 'subscription_state.dart';
//
// class SubscriptionCubit extends Cubit<SubscriptionState> {
//   Box<User>? userBox;
//   Box<PaymentPlan>? paymentPlanBox;
//   Box<List<String>>? keysBox;
//   late List<PaymentPlan> defaultPaymentPlans;
//
//   SubscriptionCubit(this.defaultPaymentPlans) : super(const SubscriptionState()) {
//     _init();
//   }
//
//   void _init() async {
//     userBox = Hive.box<User>('${PlatformConfig.boxName}user');
//     paymentPlanBox = Hive.box<PaymentPlan>('${PlatformConfig.boxName}paymentPlan');
//     keysBox = Hive.box<List<String>>('${PlatformConfig.boxName}keysBox');
//
//     User? user = userBox?.get('user');
//     List<PaymentPlan>? paymentPlans = _getPaymentPlans()?.cast<PaymentPlan>();
//     emit(
//       SubscriptionState(
//         paymentPlans: paymentPlans ?? defaultPaymentPlans,
//         user: user ?? User(),
//       ),
//     );
//   }
//
//   void selectPlan(PaymentPlanType paymentPlanType, PaymentPlan paymentPlan) async {
//     List<PaymentPlan> paymentPlanList = List.of(state.paymentPlans ?? []);
//     int index = paymentPlanList.indexWhere((e) => e == paymentPlan);
//     int? newPrice;
//     if (paymentPlanType == PaymentPlanType.yearly) {
//       if (!(paymentPlanList[index].paymentPlanType == PaymentPlanType.yearly)) {
//         newPrice = (paymentPlan.price ?? 1) * 10;
//       }
//     } else {
//       if (!(paymentPlanList[index].paymentPlanType == PaymentPlanType.monthly)) {
//         newPrice = (paymentPlan.price ?? 1) ~/ 10;
//       }
//     }
//
//     paymentPlanList[index] = paymentPlanList[index].copyWith(
//       paymentPlanType: paymentPlanType,
//       price: newPrice,
//     );
//     emit(
//       SubscriptionState(
//         paymentPlans: paymentPlanList,
//         step: state.step,
//         user: state.user,
//       ),
//     );
//
//     await _savePaymentPlans(paymentPlanList);
//   }
//
//   void nextStep(bool nextStep) {
//     emit(
//       SubscriptionState(
//         paymentPlans: state.paymentPlans,
//         step: state.step.getValue(nextStep),
//         user: state.user,
//       ),
//     );
//   }
//
//   void toggleFirstName(String firstName) async {
//     emit(
//       SubscriptionState(
//         paymentPlans: state.paymentPlans,
//         step: state.step,
//         user: state.user?.copyWith(firstName: firstName),
//       ),
//     );
//
//     await userBox?.put('user', state.user!.copyWith(firstName: firstName));
//   }
//
//   void toggleLastName(String lastName) async {
//     emit(
//       SubscriptionState(
//         paymentPlans: state.paymentPlans,
//         step: state.step,
//         user: state.user?.copyWith(lastName: lastName),
//       ),
//     );
//
//     await userBox?.put('user', state.user!.copyWith(lastName: lastName));
//   }
//
//   void toggleEmailAddress(String emailAddress) async {
//     emit(
//       SubscriptionState(
//         paymentPlans: state.paymentPlans,
//         step: state.step,
//         user: state.user?.copyWith(emailAddress: emailAddress),
//       ),
//     );
//     await userBox?.put('user', state.user!.copyWith(emailAddress: emailAddress));
//   }
//
//   void togglePhoneNumber(String phoneNumber) async {
//     emit(
//       SubscriptionState(
//         paymentPlans: state.paymentPlans,
//         step: state.step,
//         user: state.user?.copyWith(phoneNumber: phoneNumber),
//       ),
//     );
//     await userBox?.put('user', state.user!.copyWith(phoneNumber: phoneNumber));
//   }
//
//   void selectPaymentPlan(PaymentPlan paymentPlan) async {
//     List<PaymentPlan> paymentPlanList = List.of(state.paymentPlans ?? []);
//
//     paymentPlanList = paymentPlanList.map((e) {
//       if (e.isSelected) {
//         return e.copyWith(isSelected: false);
//       }
//       return e;
//     }).toList();
//     int index = paymentPlanList.indexWhere((e) => e == paymentPlan);
//
//     if (index != -1) {
//       paymentPlanList[index] = paymentPlanList[index].copyWith(isSelected: true);
//     }
//
//     emit(
//       SubscriptionState(
//         paymentPlans: paymentPlanList,
//         step: state.step,
//         user: state.user,
//       ),
//     );
//     PaymentPlan selectedPlan = paymentPlanList.firstWhere((e) => e.id == paymentPlan.id);
//
//     await paymentPlanBox?.put(paymentPlan.id, selectedPlan);
//   }
//
//   Future<void> _savePaymentPlans(List<PaymentPlan> paymentPlans) async {
//     List<String> keys = [];
//     for (var plan in paymentPlans) {
//       final key = plan.id;
//       keys.add(key ?? '');
//       await paymentPlanBox?.put(key, plan);
//     }
//     await keysBox?.put('paymentPlanKeys', keys);
//   }
//
//   List<PaymentPlan?>? _getPaymentPlans() {
//     List<String>? keys = keysBox?.get('paymentPlanKeys');
//     if (keys != null) {
//       return keys.map((key) => paymentPlanBox?.get(key)!).toList();
//     }
//     return null;
//   }
// }
