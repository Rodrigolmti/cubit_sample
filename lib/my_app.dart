import 'package:arch_sample/environments/app_config.dart';
import 'package:arch_sample/pages/home/presentation/home_cubit.dart';
import 'package:arch_sample/pages/home/presentation/home_screen.dart';
import 'package:cubit/flutter_cubit/cubit_provider.dart';
import 'package:flutter/material.dart';
import 'package:cubit/cubit.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);

    return MaterialApp(
      title: config.appName,
      theme: ThemeData(
        primarySwatch: config.appAccentColor,
      ),
      home: CubitProvider(
        create: (_) => HomeCubit(),
        child: HomePage(),
      ),
    );
  }
}
