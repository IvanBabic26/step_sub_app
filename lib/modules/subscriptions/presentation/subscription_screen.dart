import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:step_sub/commons/background_image.dart';
import 'package:step_sub/commons/stepper_progress.dart';
import 'package:step_sub/core/injection_container.dart';
import 'package:step_sub/design/images.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/design/step_sub_text_styles.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/modules/subscriptions/presentation/subscription_cubit.dart';
import 'package:step_sub/modules/subscriptions/presentation/widgets/form_action_buttons.dart';
import 'package:step_sub/modules/subscriptions/presentation/widgets/form_step_one.dart';
import 'package:step_sub/modules/subscriptions/presentation/widgets/form_step_three.dart';
import 'package:step_sub/modules/subscriptions/presentation/widgets/form_step_two.dart';
import 'package:step_sub/utilities/enums.dart';
import 'package:step_sub/utilities/extensions.dart';
import 'package:step_sub/utilities/utils.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();

  final ScrollController _scrollControllerStepOne = ScrollController();
  final ScrollController _scrollControllerStepTwo = ScrollController();
  final ScrollController _scrollControllerStepThree = ScrollController();

  void _scrollToTop(ScrollController scrollController) {
    scrollController.animateTo(
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  onFieldSubmitted(BuildContext context, SubscriptionState state) async {
    final cubit = context.read<SubscriptionCubit>();
    if (state.step == Steps.firstStep) {
      if (_formKey.currentState?.validate() ?? false) {
        cubit.nextStep(true);
        _scrollToTop(_scrollControllerStepOne);
      }
    } else if (state.step == Steps.secondStep) {
      if (state.selectedPaymentPlan != null) {
        cubit.nextStep(true);
        _scrollToTop(_scrollControllerStepTwo);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please selected a subscription plan')),
        );
      }
    } else if (state.formCompleted) {
      await Hive.deleteFromDisk();
      await Hive.close();
      await Hive.openBox<User>('${PlatformConfig.boxName}user');
      await Hive.openBox<PaymentPlan>('${PlatformConfig.boxName}paymentPlan');
      await Hive.openBox<List<PaymentPlan>>('${PlatformConfig.boxName}paymentPlanList').then(
        (e) => Navigator.pop(context),
      );
    } else {
      cubit.nextStep(true);
      _scrollToTop(_scrollControllerStepThree);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(isMainScreen: false),
          Container(color: StepSubColors.black.withOpacity(0.3)),
          Stack(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16 + MediaQuery.of(context).padding.top,
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    32.0,
                    16.0,
                    0.0,
                  ),
                  decoration: BoxDecoration(color: StepSubColors.white, borderRadius: BorderRadius.circular(8.0)),
                  child: BlocProvider(
                    create: (context) => SubscriptionCubit(),
                    child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
                      builder: (context, state) {
                        final cubit = context.read<SubscriptionCubit>();
                        return Row(
                          children: [
                            if (!isMobileScreenSize(context))
                              Container(
                                decoration: BoxDecoration(
                                  color: StepSubColors.lightBlue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                margin: const EdgeInsets.only(right: 16, bottom: 16),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 24.0),
                                        child: Image.asset(
                                          Images.logo,
                                          width: 180,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            state.formCompleted
                                                ? 'Completed!'
                                                : 'Step ${state.step.index + 1} out of ${Steps.values.length - 1}',
                                            style: StepSubTextStyles.titleTextStyle,
                                          ),
                                          const SizedBox(height: 16),
                                          StepperProgress(
                                            isMobileScreenSize: false,
                                            stepValue: state.step.value,
                                            isFormCompleted: state.formCompleted,
                                            isStepOneCompleted: state.isStepOneCompleted,
                                            isStepTwoCompleted: state.isStepTwoCompleted,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isMobileScreenSize(context))
                                    Text(
                                      state.formCompleted
                                          ? 'Completed!'
                                          : 'Step ${state.step.index + 1} out of ${Steps.values.length - 1}',
                                      style: StepSubTextStyles.titleTextStyle,
                                    ),
                                  if (isMobileScreenSize(context))
                                    StepperProgress(
                                      stepValue: state.step.value,
                                      isFormCompleted: state.formCompleted,
                                      isStepOneCompleted: state.isStepOneCompleted,
                                      isStepTwoCompleted: state.isStepTwoCompleted,
                                    ),
                                  Expanded(
                                    flex: state.step == Steps.finished ? 1 : 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                                      child: Text(
                                        state.step.getTitle(),
                                        style: isMobileScreenSize(context)
                                            ? StepSubTextStyles.titleTextStyle
                                            : StepSubTextStyles.primaryDesktopTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  if (state.step == Steps.firstStep)
                                    FormStepOne(
                                      onFirstNameChanged: (e) => cubit.toggleFirstName(e),
                                      onLastNameChanged: (e) => cubit.toggleLastName(e),
                                      onEmailChanged: (e) => cubit.toggleEmailAddress(e),
                                      onPhoneChanged: (e) => cubit.togglePhoneNumber(e),
                                      onFieldSubmitted: (e) => onFieldSubmitted(context, state),
                                      firstName: state.user?.firstName ?? '',
                                      lastName: state.user?.lastName ?? '',
                                      emailAddress: state.user?.emailAddress ?? '',
                                      phoneNumber: state.user?.phoneNumber ?? '',
                                      formKey: _formKey,
                                      scrollController: _scrollControllerStepOne,
                                    ),
                                  if (state.step == Steps.secondStep)
                                    FormStepTwo(
                                      name: state.selectedPaymentPlan?.name ?? '',
                                      onCardTap: (e) => cubit.selectPaymentPlan(e),
                                      paymentPlans: state.paymentPlans ?? [],
                                      onTypeToggle: (index, e) => cubit.selectPlan(
                                        index.getValue(),
                                        e,
                                      ),
                                      scrollController: _scrollControllerStepTwo,
                                    ),
                                  if (state.step == Steps.thirdStep)
                                    FormStepThree(
                                      selectedPaymentPlan: state.selectedPaymentPlan,
                                      scrollController: _scrollControllerStepThree,
                                      userInfo: [
                                        'First name: ${state.user?.firstName}',
                                        'Last name: ${state.user?.lastName}',
                                        'Email address: ${state.user?.emailAddress}',
                                        'Phone number: ${state.user?.phoneNumber}'
                                      ],
                                    ),
                                  FormActionButtons(
                                    onNextButtonPress: () => onFieldSubmitted(context, state),
                                    onBackButtonPress: () => cubit.nextStep(false),
                                    stepIndex: state.step.index,
                                    isFormCompleted: state.formCompleted,
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6 + MediaQuery.of(context).padding.top,
                right: 6,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  hoverColor: StepSubColors.lightBlue,
                  child: const Icon(
                    Icons.highlight_remove,
                    color: StepSubColors.primaryColor,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
