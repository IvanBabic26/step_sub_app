part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialEvent extends SubscriptionEvent {
  InitialEvent(this.paymentPlans);

   final List<PaymentPlan> paymentPlans;

  @override
  List<Object?> get props => [paymentPlans];
}

class SelectPlanTypeEvent extends SubscriptionEvent {
  SelectPlanTypeEvent({
    required this.paymentPlanType,
    required this.paymentPlan,
  });

  final PaymentPlanType paymentPlanType;
  final PaymentPlan paymentPlan;

  @override
  List<Object?> get props => [paymentPlanType, paymentPlan];
}

class NextStep extends SubscriptionEvent {
  NextStep({this.nextStep = false});

  final bool nextStep;

  @override
  List<Object?> get props => [nextStep];
}

class ToggleFirstName extends SubscriptionEvent {
  ToggleFirstName(this.firstName);

  final String firstName;

  @override
  List<Object?> get props => [firstName];
}

class ToggleLastName extends SubscriptionEvent {
  ToggleLastName(this.lastName);

  final String lastName;

  @override
  List<Object?> get props => [lastName];
}

class ToggleEmailAddress extends SubscriptionEvent {
  ToggleEmailAddress(this.emailAddress);

  final String emailAddress;

  @override
  List<Object?> get props => [emailAddress];
}

class TogglePhoneNumber extends SubscriptionEvent {
  TogglePhoneNumber(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

class SelectPaymentPlan extends SubscriptionEvent {
  SelectPaymentPlan(this.paymentPlan);

  final PaymentPlan paymentPlan;

  @override
  List<Object?> get props => [paymentPlan];
}
