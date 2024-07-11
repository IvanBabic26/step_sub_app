part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.step = Steps.firstStep,
    this.paymentPlans,
    this.user,
  });

  final Steps step;
  final User? user;
  final List<PaymentPlan>? paymentPlans;

  bool get isStepOneCompleted =>
      user?.firstName != null &&
      user?.lastName != null &&
      user?.emailAddress != null &&
      user?.phoneNumber != null &&
      step != Steps.firstStep;

  bool get isPlanSelected => paymentPlans?.any((e) => e.isSelected) ?? false;

  bool get isStepTwoCompleted => isPlanSelected && step != Steps.secondStep && step != Steps.firstStep;

  bool get formCompleted => step == Steps.finished;

  @override
  List<Object?> get props => [step, paymentPlans, user];
}

class InitialDataState extends SubscriptionState {
  const InitialDataState({
    super.step,
    super.user,
    super.paymentPlans,
  });
}

class SubscriptionDataState extends SubscriptionState {
  const SubscriptionDataState({
    super.step,
    super.user,
    super.paymentPlans,
  });
}
