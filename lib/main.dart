import 'package:clock_timer/pages/local_error/local_error_binding.dart';
import 'package:clock_timer/pages/local_error/local_error_view.dart';
import 'package:clock_timer/pages/timer_main/timer_main_binding.dart';
import 'package:clock_timer/pages/timer_main/timer_main_view.dart';
import 'package:clock_timer/pages/timer_picker/timer_picker_binding.dart';
import 'package:clock_timer/pages/timer_picker/timer_picker_view.dart';
import 'package:clock_timer/pages/timer_setting/time_setting_wheel.dart';
import 'package:clock_timer/pages/timer_setting/timer_setting_binding.dart';
import 'package:clock_timer/pages/timer_setting/timer_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.black;

const String kTextFamily = 'Time';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final txtColor = prefs.getString('txtColor');
  if (txtColor == null) {
    prefs.setString('txtColor', Colors.white.toHexString());
    prefs.setString('bgColor', Colors.black.toHexString());
    prefs.setBool('clockStyle', true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Hug,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Hug = [
  GetPage(name: '/', page: () => const TimerPickerView(), binding: TimerPickerBinding()),
  GetPage(name: '/local_error', page: () => LocalErrorView(), binding: LocalErrorBinding()),
  GetPage(name: '/timerMain', page: () => const TimerMainPage(), binding: TimerMainBinding()),
  GetPage(name: '/timerWheel', page: () => TimeSettingWheel()),
  GetPage(name: '/timerSetting', page: () => TimerSettingPage(), binding: TimerSettingBinding()),
];