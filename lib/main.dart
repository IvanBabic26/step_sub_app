import 'package:flutter/material.dart';
import 'package:step_sub/design/styles.dart';
import 'package:step_sub/core/injection_container.dart';
import 'package:step_sub/sub_step_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: themeData(context),
      home: const StepSubApp(),
    );
  }
}
