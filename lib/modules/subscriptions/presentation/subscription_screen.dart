import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:step_sub/commons/background_image.dart';
import 'package:step_sub/commons/constants.dart';
import 'package:step_sub/commons/stepper_progress.dart';
import 'package:step_sub/commons/strings.dart';
import 'package:step_sub/core/injection_container.dart';
import 'package:step_sub/design/images.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/modules/subscriptions/presentation/subscription_bloc.dart';
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
    final bloc = context.read<SubscriptionBloc>();
    final strings = LocalizedStrings(context);
    if (state.step == Steps.firstStep) {
      if (_formKey.currentState?.validate() ?? false) {
        bloc.add(NextStep(nextStep: true));
        _scrollToTop(_scrollControllerStepOne);
      }
    } else if (state.step == Steps.secondStep) {
      if (state.isPlanSelected) {
        bloc.add(NextStep(nextStep: true));
        _scrollToTop(_scrollControllerStepTwo);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              strings.pleaseSelectSubscriptionPlan,
              style: context.textStyle?.labelMedium,
            ),
          ),
        );
      }
    } else if (state.formCompleted) {
      await Hive.deleteFromDisk();
      await Hive.close();
      await Hive.openBox<User>('${PlatformConfig.boxName}user');
      await Hive.openBox<PaymentPlan>('${PlatformConfig.boxName}paymentPlan');
      await Hive.openBox<List<String>>('${PlatformConfig.boxName}keysBox').then(
        (e) => Navigator.pop(context),
      );
    } else {
      bloc.add(NextStep(nextStep: true));
      _scrollToTop(_scrollControllerStepThree);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = LocalizedStrings(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(isMainScreen: false),
          Container(color: context.colorTheme.black.withOpacity(0.3)),
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
                  decoration: BoxDecoration(color: context.colorTheme.white, borderRadius: BorderRadius.circular(8.0)),
                  child: BlocProvider(
                    create: (providerContext) => SubscriptionBloc()..add(InitialEvent(defaultPaymentPlans(context))),
                    child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                      builder: (context, state) {
                        final bloc = context.read<SubscriptionBloc>();
                        if (state is InitialDataState) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return Row(
                            children: [
                              if (!isMobileScreenSize(context))
                                Container(
                                  decoration: BoxDecoration(
                                    color: context.colorTheme.lightBlue.withOpacity(0.2),
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
                                                  ? strings.completed
                                                  : strings.stepOutOf(Steps.values.length - 1, state.step.index + 1),
                                              style: context.textStyle?.headlineMedium,
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
                                            ? strings.completed
                                            : strings.stepOutOf(Steps.values.length - 1, state.step.index + 1),
                                        style: context.textStyle?.headlineMedium,
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
                                          state.step.getTitle(context),
                                          textAlign: TextAlign.center,
                                          style: context.textStyle?.headlineMedium?.copyWith(color: context.colorTheme.black),
                                        ),
                                      ),
                                    ),
                                    if (state.step == Steps.firstStep)
                                      FormStepOne(
                                        onFirstNameChanged: (e) => bloc.add(ToggleFirstName(e)),
                                        onLastNameChanged: (e) => bloc.add(ToggleLastName(e)),
                                        onEmailChanged: (e) => bloc.add(ToggleEmailAddress(e)),
                                        onPhoneChanged: (e) => bloc.add(TogglePhoneNumber(e)),
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
                                        id: state.isPlanSelected
                                            ? state.paymentPlans!.firstWhere((e) => e.isSelected).id!
                                            : '',
                                        onCardTap: (e) => bloc.add(SelectPaymentPlan(e)),
                                        paymentPlans: state.paymentPlans ?? [],
                                        onTypeToggle: (index, e) => bloc.add(
                                          SelectPlanTypeEvent(paymentPlanType: index.getValue(), paymentPlan: e),
                                        ),
                                        scrollController: _scrollControllerStepTwo,
                                      ),
                                    if (state.step == Steps.thirdStep)
                                      FormStepThree(
                                        selectedPaymentPlan: state.paymentPlans?.firstWhere((e) => e.isSelected),
                                        scrollController: _scrollControllerStepThree,
                                        userInfo: [
                                          '${strings.firstName}: ${state.user?.firstName}',
                                          '${strings.lastName}: ${state.user?.lastName}',
                                          '${strings.emailAddress}: ${state.user?.emailAddress}',
                                          '${strings.phoneNumber}: ${state.user?.phoneNumber}'
                                        ],
                                      ),
                                    FormActionButtons(
                                      onNextButtonPress: () => onFieldSubmitted(context, state),
                                      onBackButtonPress: () => bloc.add(NextStep()),
                                      stepIndex: state.step.index,
                                      isFormCompleted: state.formCompleted,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
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
                  hoverColor: context.colorTheme.lightBlue,
                  child: Icon(
                    Icons.highlight_remove,
                    color: context.colorTheme.primaryColor,
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
