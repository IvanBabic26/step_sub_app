import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:step_sub/modules/subscriptions/domain/subs_model.dart';
import 'package:step_sub/utilities/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(dbDir.path);
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PaymentPlanAdapter());
  Hive.registerAdapter(PaymentPlanTypeAdapter());

  String boxName = 'defaultBox';
  if (PlatformService.isWeb) {
    boxName = 'webBox';
  } else if (PlatformService.isIOS) {
    boxName = 'iosBox';
  } else if (PlatformService.isAndroid) {
    boxName = 'androidBox';
  } else if (PlatformService.isWindows) {
    boxName = 'windowsBox';
  }

  await Hive.openBox<User>('${boxName}user');
  await Hive.openBox<PaymentPlan>('${boxName}paymentPlan');
  await Hive.openBox<List<PaymentPlan>>('${boxName}paymentPlanList');

  PlatformConfig.boxName = boxName;
}

class PlatformConfig {
  static String boxName = 'defaultBox';
}
