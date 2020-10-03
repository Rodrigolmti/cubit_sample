import 'dart:async';

import 'package:arch_sample/di/injection.dart';
import 'package:arch_sample/environments/app_config.dart';
import 'package:arch_sample/my_app.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const prodEnv = Environment('prod');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection(prodEnv);
  await runZonedGuarded(() async {
    runApp(
      AppConfig(
        appName: 'Arch Sample',
        appAccentColor: Colors.purple,
        child: MyApp(),
      ),
    );
  }, (error, stack) {
    print(stack);
    print(error);
  });
}