part of 'subscription_cubit.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.step = Steps.firstStep,
    this.paymentPlans,
    this.user,
    this.selectedPaymentPlan,
  });

  final Steps step;
  final User? user;
  final List<PaymentPlan>? paymentPlans;
  final PaymentPlan? selectedPaymentPlan;

  bool get isStepOneCompleted =>
      user?.firstName != null &&
      user?.lastName != null &&
      user?.emailAddress != null &&
      user?.phoneNumber != null &&
      step != Steps.firstStep;

  bool get isStepTwoCompleted => selectedPaymentPlan != null && step != Steps.secondStep && step != Steps.firstStep;

  bool get formCompleted => step == Steps.finished;

  @override
  List<Object?> get props => [step, paymentPlans, user, selectedPaymentPlan];
}
