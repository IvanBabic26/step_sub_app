import 'package:flutter/material.dart';
import 'package:step_sub/commons/background_image.dart';
import 'package:step_sub/commons/primary_button.dart';
import 'package:step_sub/design/images.dart';
import 'package:step_sub/design/step_sub_colors.dart';
import 'package:step_sub/modules/subscriptions/presentation/subscription_screen.dart';

class StepSubApp extends StatelessWidget {
  const StepSubApp({super.key});

  onButtonPress(BuildContext context) => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const SubscriptionScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: StepSubColors.pinkRed),
          Container(color: StepSubColors.black.withOpacity(0.5)),
          const BackgroundImage(),
          Container(color: StepSubColors.lightBlue.withOpacity(0.55)),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  StepSubColors.primaryColor.withOpacity(0.5),
                  StepSubColors.primaryColor.withOpacity(0.0),
                ],
                center: Alignment.topLeft,
                radius: 1,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  StepSubColors.pinkRed.withOpacity(0.5),
                  StepSubColors.pinkRed.withOpacity(0.01),
                ],
                center: Alignment.bottomRight,
                radius: 1,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(48.0, 48.0 + MediaQuery.of(context).padding.top, 48.0, 0.0),
                child: Image.asset(
                  Images.logo,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrimaryButton(
                      buttonTitle: 'Proceedix Enterprise',
                      leadingIcon: const Icon(Icons.cloud, color: StepSubColors.white),
                      trailingIcon: const Icon(Icons.arrow_right_outlined, color: StepSubColors.white),
                      onPressed: () => onButtonPress(context),
                      backgroundColor: StepSubColors.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      buttonTitle: 'Log in',
                      onPressed: () => onButtonPress(context),
                      leadingIcon: const Icon(Icons.person_sharp, color: StepSubColors.primaryColor),
                      buttonTitleColor: StepSubColors.primaryColor,
                      showShadows: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
