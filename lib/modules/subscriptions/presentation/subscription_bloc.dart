import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:step_sub/core/injection_container.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/utilities/enums.dart';
import 'package:step_sub/utilities/extensions.dart';

part 'subscription_event.dart';

part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  Box<User>? userBox;
  Box<PaymentPlan>? paymentPlanBox;
  Box<List<String>>? keysBox;

  SubscriptionBloc() : super(const InitialDataStata()) {
    on<InitialEvent>(_init);
    on<SelectPlanTypeEvent>(selectPlan);
    on<NextStep>(nextStep);
    on<ToggleFirstName>(toggleFirstName);
    on<ToggleLastName>(toggleLastName);
    on<ToggleEmailAddress>(toggleEmailAddress);
    on<TogglePhoneNumber>(togglePhoneNumber);
    on<SelectPaymentPlan>(selectPaymentPlan);
  }

  void _init(InitialEvent event, Emitter<SubscriptionState> emit) async {
    userBox = Hive.box<User>('${PlatformConfig.boxName}user');
    paymentPlanBox = Hive.box<PaymentPlan>('${PlatformConfig.boxName}paymentPlan');
    keysBox = Hive.box<List<String>>('${PlatformConfig.boxName}keysBox');

    User? user = userBox?.get('user');
    List<PaymentPlan>? paymentPlans = _getPaymentPlans()?.cast<PaymentPlan>();
    emit(
      SubscriptionDataState(
        paymentPlans: paymentPlans ?? event.paymentPlans,
        user: user ?? User(),
      ),
    );
  }

  void selectPlan(SelectPlanTypeEvent event, Emitter<SubscriptionState> emit) async {
    List<PaymentPlan> paymentPlanList = List.of(state.paymentPlans ?? []);
    int index = paymentPlanList.indexWhere((e) => e == event.paymentPlan);
    int? newPrice;
    if (event.paymentPlanType == PaymentPlanType.yearly) {
      if (!(paymentPlanList[index].paymentPlanType == PaymentPlanType.yearly)) {
        newPrice = (event.paymentPlan.price ?? 1) * 10;
      }
    } else {
      if (!(paymentPlanList[index].paymentPlanType == PaymentPlanType.monthly)) {
        newPrice = (event.paymentPlan.price ?? 1) ~/ 10;
      }
    }

    paymentPlanList[index] = paymentPlanList[index].copyWith(
      paymentPlanType: event.paymentPlanType,
      price: newPrice,
    );
    emit(
      SubscriptionDataState(
        paymentPlans: paymentPlanList,
        step: state.step,
        user: state.user,
      ),
    );

    await _savePaymentPlans(paymentPlanList);
  }

  void nextStep(NextStep event, Emitter<SubscriptionState> emit) {
    emit(
      SubscriptionDataState(
        paymentPlans: state.paymentPlans,
        step: state.step.getValue(event.nextStep),
        user: state.user,
      ),
    );
  }

  void toggleFirstName(ToggleFirstName event, Emitter<SubscriptionState> emit) async {
    emit(
      SubscriptionDataState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(firstName: event.firstName),
      ),
    );

    await userBox?.put('user', state.user!.copyWith(firstName: event.firstName));
  }

  void toggleLastName(ToggleLastName event, Emitter<SubscriptionState> emit) async {
    emit(
      SubscriptionDataState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(lastName: event.lastName),
      ),
    );

    await userBox?.put('user', state.user!.copyWith(lastName: event.lastName));
  }

  void toggleEmailAddress(ToggleEmailAddress event, Emitter<SubscriptionState> emit) async {
    emit(
      SubscriptionDataState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(emailAddress: event.emailAddress),
      ),
    );
    await userBox?.put('user', state.user!.copyWith(emailAddress: event.emailAddress));
  }

  void togglePhoneNumber(TogglePhoneNumber event, Emitter<SubscriptionState> emit) async {
    emit(
      SubscriptionDataState(
        paymentPlans: state.paymentPlans,
        step: state.step,
        user: state.user?.copyWith(phoneNumber: event.phoneNumber),
      ),
    );
    await userBox?.put('user', state.user!.copyWith(phoneNumber: event.phoneNumber));
  }

  void selectPaymentPlan(SelectPaymentPlan event, Emitter<SubscriptionState> emit) async {
    List<PaymentPlan> paymentPlanList = List.of(state.paymentPlans ?? []);

    paymentPlanList = paymentPlanList.map((e) {
      if (e.isSelected) {
        return e.copyWith(isSelected: false);
      }
      return e;
    }).toList();
    int index = paymentPlanList.indexWhere((e) => e == event.paymentPlan);

    if (index != -1) {
      paymentPlanList[index] = paymentPlanList[index].copyWith(isSelected: true);
    }

    emit(
      SubscriptionDataState(
        paymentPlans: paymentPlanList,
        step: state.step,
        user: state.user,
      ),
    );
    PaymentPlan selectedPlan = paymentPlanList.firstWhere((e) => e.id == event.paymentPlan.id);

    await paymentPlanBox?.put(event.paymentPlan.id, selectedPlan);
  }

  Future<void> _savePaymentPlans(List<PaymentPlan> paymentPlans) async {
    List<String> keys = [];
    for (var plan in paymentPlans) {
      final key = plan.id;
      keys.add(key ?? '');
      await paymentPlanBox?.put(key, plan);
    }
    await keysBox?.put('paymentPlanKeys', keys);
  }

  List<PaymentPlan?>? _getPaymentPlans() {
    List<String>? keys = keysBox?.get('paymentPlanKeys');
    if (keys != null) {
      return keys.map((key) => paymentPlanBox?.get(key)!).toList();
    }
    return null;
  }
}
