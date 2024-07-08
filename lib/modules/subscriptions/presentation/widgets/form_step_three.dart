import 'package:flutter/material.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/modules/subscriptions/presentation/subscription_card.dart';
import 'package:step_sub/utilities/utils.dart';

class FormStepThree extends StatelessWidget {
  const FormStepThree({
    super.key,
    required this.selectedPaymentPlan,
    required this.scrollController,
    required this.userInfo,
  });

  final PaymentPlan? selectedPaymentPlan;
  final ScrollController scrollController;
  final List<String> userInfo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            ...userInfo.map(
              (e) => Text(
                e,
                style: isMobileScreenSize(context)
                    ? StepSubTextStyles.titleTextStyle
                    : StepSubTextStyles.primaryDesktopTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            SubscriptionCard(
              title: selectedPaymentPlan?.name ?? '',
              price: selectedPaymentPlan?.price ?? 0,
              paymentPlanType: selectedPaymentPlan?.paymentPlanType ?? PaymentPlanType.monthly,
              isSummary: true,
              onTypeToggle: (e) {},
            )
          ],
        ),
      ),
    );
  }
}
