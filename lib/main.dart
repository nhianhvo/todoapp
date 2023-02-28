import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/di/injection.dart';
import 'package:todoapp/feature/home/home_binding.dart';
import 'package:todoapp/route/router.dart';

Future<void> main() async {
  await configureDependencies();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      initialBinding: HomeBinding(),
      initialRoute: route_home_screen,
      getPages: appRoute,
    );
  }
}
