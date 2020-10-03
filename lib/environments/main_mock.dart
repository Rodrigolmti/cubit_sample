import 'dart:async';

import 'package:arch_sample/di/injection.dart';
import 'package:arch_sample/environments/app_config.dart';
import 'package:arch_sample/my_app.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const mockEnv = Environment('mock');
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection(mockEnv);
  await runZonedGuarded(() async {
    runApp(
      AppConfig(
        appName: 'Arch Sample [MOCK]',
        appAccentColor: Colors.green,
        child: MyApp(),
      ),
    );
  }, (error, stack) {
    print(stack);
    print(error);
  });
}