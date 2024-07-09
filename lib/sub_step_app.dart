import 'package:flutter/material.dart';
import 'package:step_sub/commons/background_image.dart';
import 'package:step_sub/commons/primary_button.dart';
import 'package:step_sub/commons/strings.dart';
import 'package:step_sub/design/images.dart';
import 'package:step_sub/modules/subscriptions/presentation/subscription_screen.dart';
import 'package:step_sub/utilities/extensions.dart';

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
    final strings = LocalizedStrings(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(color: context.colorTheme.pinkRed),
          Container(color: context.colorTheme.black.withOpacity(0.5)),
          const BackgroundImage(),
          Container(color: context.colorTheme.lightBlue.withOpacity(0.55)),
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  context.colorTheme.primaryColor.withOpacity(0.5),
                  context.colorTheme.primaryColor.withOpacity(0.0),
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
                  context.colorTheme.pinkRed.withOpacity(0.5),
                  context.colorTheme.pinkRed.withOpacity(0.01),
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
                      buttonTitle: strings.proceedixEnterprise,
                      leadingIcon: Icon(Icons.cloud, color: context.colorTheme.white),
                      trailingIcon: Icon(Icons.arrow_right_outlined, color: context.colorTheme.white),
                      onPressed: () => onButtonPress(context),
                      backgroundColor: context.colorTheme.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      buttonTitle: strings.login,
                      onPressed: () => onButtonPress(context),
                      leadingIcon: Icon(Icons.person_sharp, color: context.colorTheme.primaryColor),
                      buttonTitleColor: context.colorTheme.primaryColor,
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
