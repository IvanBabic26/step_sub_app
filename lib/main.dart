import 'package:flutter/material.dart';
import 'package:step_sub/core/injection_container.dart';
import 'package:step_sub/sub_step_app.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const StepSubApp(),
    );
  }
}
