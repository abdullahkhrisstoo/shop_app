// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/constant/themes.dart';
import 'package:project1/network/local/shared_pref_helper.dart';
import 'package:project1/network/remote/dio_helper.dart';
import 'package:project1/presentaions/screen/layout/home_layout/home_screen.dart';
import 'package:project1/presentaions/screen/login/cubit/login_cubit.dart';
import 'package:project1/presentaions/screen/login/login_screen.dart';
import 'package:project1/presentaions/screen/native_screen.dart';
import 'package:project1/presentaions/screen/on_boarding.dart';

import 'constant/components.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  final bool onBoardDone = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? 'null';
  print("this is my token " + token.toString());

  Widget widget = OnBoardingScreen();
  if (onBoardDone == true) {
    if (token != 'null') {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: NaticeScreen(),
      ),
    );
  }
}
