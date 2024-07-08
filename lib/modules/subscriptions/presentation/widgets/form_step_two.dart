import 'package:flutter/material.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/modules/subscriptions/presentation/subscription_card.dart';
import 'package:step_sub/utilities/utils.dart';

class FormStepTwo extends StatelessWidget {
  const FormStepTwo({
    super.key,
    required this.onCardTap,
    required this.onTypeToggle,
    required this.paymentPlans,
    required this.name,
    required this.scrollController,
  });

  final Function(PaymentPlan) onCardTap;
  final Function(int, PaymentPlan) onTypeToggle;
  final List<PaymentPlan> paymentPlans;
  final String name;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        child: isMobileScreenSize(context)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...paymentPlans.map(
                    (e) => InkWell(
                      onTap: () => onCardTap(e),
                      child: SubscriptionCard(
                        title: e.name ?? '',
                        price: e.price ?? 0,
                        paymentPlanType: e.paymentPlanType,
                        onTypeToggle: (index) => onTypeToggle(index, e),
                        isSelected: e.name == name,
                      ),
                    ),
                  ),
                ],
              )
            : IntrinsicWidth(
                child: Row(
                  children: [
                    ...paymentPlans.map(
                      (e) => Expanded(
                        child: Material(
                          color: StepSubColors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.hovered)) {
                                  return StepSubColors.lightBlue.withOpacity(0.2);
                                }
                                if (states.contains(WidgetState.pressed)) {
                                  return StepSubColors.lightBlue.withOpacity(0.2);
                                }
                                return null;
                              },
                            ),
                            onTap: () => onCardTap(e),
                            child: SubscriptionCard(
                              title: e.name ?? '',
                              price: e.price ?? 0,
                              paymentPlanType: e.paymentPlanType,
                              onTypeToggle: (index) => onTypeToggle(index, e),
                              isSelected: e.name == name,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
