import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:step_sub/commons/constants.dart';
import 'package:step_sub/core/injection_container.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/utilities/enums.dart';
import 'package:step_sub/utilities/extensions.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  Box<User>? userBox;
  Box<PaymentPlan>? paymentPlanBox;
  Box<List<PaymentPlan>>? listPaymentPlanBox;

  SubscriptionCubit() : super(const SubscriptionState()) {
    _init();
  }

  void _init() async {
    userBox = Hive.box<User>('${PlatformConfig.boxName}user');
    paymentPlanBox = Hive.box<PaymentPlan>('${PlatformConfig.boxName}paymentPlan');
    listPaymentPlanBox = Hive.box<List<PaymentPlan>>('${PlatformConfig.boxName}paymentPlanList');

    User? user = userBox?.get('user');
    PaymentPlan? selectedPaymentPlan = paymentPlanBox?.get('paymentPlan');
    List<PaymentPlan>? paymentPlans = listPaymentPlanBox?.get('paymentPlanList');

    emit(
      SubscriptionState(
        paymentPlans: paymentPlans ?? defaultPaymentPlans,
        user: user ?? User(),
        selectedPaymentPlan: selectedPaymentPlan,
      ),
    );
  }

  void selectPlan(PaymentPlanType paymentPlanType, PaymentPlan paymentPlan) {
    List<PaymentPlan> paymentPlanList = List.of(state.paymentPlans ?? []);
    int index = paymentPlanList.indexWhere((e) => e == paymentPlan);
    int? newPrice;
    if (paymentPlanType == PaymentPlanType.yearly) {
      if (!(paymentPlanList[index].paymentPlanType == PaymentPlanType.yearly)) {
        newPrice = (paymentPlan.price ?? 1) * 10;
      }
    } else {
      if (!(paymentPlanList[index].paymentPlanType == PaymentPlanType.monthly)) {
        newPrice = (paymentPlan.price ?? 1) ~/ 10;
      }
    }

    paymentPlanList[index] = paymentPlanList[index].copyWith(
      paymentPlanType: paymentPlanType,
      price: newPrice,
    );
    emit(
      SubscriptionState(
        paymentPlans: paymentPlanList,
        step: state.step,
        user: state.user,
        selectedPaymentPlan: state.selectedPaymentPlan?.copyWith(
          paymentPlanType:
              newPrice != null ? paymentPlanList[index].paymentPlanType : state.selectedPaymentPlan?.paymentPlanType,
          price: newPrice != null ? paymentPlanList[index].price : state.selectedPaymentPlan?.price,
        ),
      ),
    );
    listPaymentPlanBox?.put('paymentPlanList', paymentPlanList);
    paymentPlanBox?.put('paymentPlan', state.selectedPaymentPlan!);
  }

  void nextStep(bool nextStep) {
    emit(
      SubscriptionState(
        paymentPlans: state.paymentPlans,
        step: state.step.getValue(nextStep),
        user: state.user,
        selectedPaymentPlan: state.selectedPaymentPlan,
      ),
    );
  }

  void toggleFirstName(String firstName) async {
    emit(
      SubscriptionState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(firstName: firstName),
        selectedPaymentPlan: state.selectedPaymentPlan,
      ),
    );

    userBox?.put('user', state.user!.copyWith(firstName: firstName));
  }

  void toggleLastName(String lastName) async {
    emit(
      SubscriptionState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(lastName: lastName),
        selectedPaymentPlan: state.selectedPaymentPlan,
      ),
    );

    userBox?.put('user', state.user!.copyWith(lastName: lastName));
  }

  void toggleEmailAddress(String emailAddress) {
    emit(
      SubscriptionState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(emailAddress: emailAddress),
        selectedPaymentPlan: state.selectedPaymentPlan,
      ),
    );
    userBox?.put('user', state.user!.copyWith(emailAddress: emailAddress));
  }

  void togglePhoneNumber(String phoneNumber) {
    emit(
      SubscriptionState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(phoneNumber: phoneNumber),
        selectedPaymentPlan: state.selectedPaymentPlan,
      ),
    );
    userBox?.put('user', state.user!.copyWith(phoneNumber: phoneNumber));
  }

  void selectPaymentPlan(PaymentPlan paymentPlan) {
    emit(
      SubscriptionState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user,
        selectedPaymentPlan: state.selectedPaymentPlan == paymentPlan ? null : paymentPlan,
      ),
    );
    paymentPlanBox?.put('paymentPlan', state.selectedPaymentPlan!);
  }
}
