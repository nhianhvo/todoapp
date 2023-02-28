import 'package:get/route_manager.dart';
import 'package:todoapp/feature/home/home_binding.dart';
import 'package:todoapp/feature/home/home_screen.dart';

const route_home_screen = '/route_home_screen';

var appRoute = [
  GetPage(
    name: route_home_screen,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  )
];
