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

  String getTitle() {
    switch (this) {
      case Steps.firstStep:
        return 'Personal information';
      case Steps.secondStep:
        return 'Choose your subscription plan';
      case Steps.thirdStep:
        return 'Order Summary';
      case Steps.finished:
        return 'Subscription complete! \nThank you for your order and for choosing Proceedix.\nYou can change your subscription plan at any time in Profile section under the Subscription plan tab.';
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


extension PaymentPlanTypeExtension on PaymentPlanType {
  getName() {
    switch (this) {
      case PaymentPlanType.monthly:
        return 'month';
      case PaymentPlanType.yearly:
        return 'year';
    }
  }
}