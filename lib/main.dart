import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/homeLayout.dart';
import 'package:untitled1/modules/login/login_screen.dart';
import 'package:untitled1/modules/onBoarding.dart';
import 'package:untitled1/shared/constants.dart';
import 'package:untitled1/shared/local/cacheHelper.dart';
import 'package:untitled1/shared/network/dioHelper.dart';
import 'shared/blocObserve.dart';
import 'shared/theme.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  dioHelper.init();
  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token') ?? '';

  Widget widget;

  token != null? widget = const HomeLayoutScreen() : widget = onBoard();

  runApp( MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget  {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeLight,
        darkTheme: themeDark,
        themeMode: ThemeMode.light,
        home: startWidget,
    );
  }
}
