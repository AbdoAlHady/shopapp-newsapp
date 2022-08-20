import 'package:bloc/bloc.dart';
import 'package:bmicalc/layout/shop_app/cubit/cubit.dart';
import 'package:bmicalc/layout/shop_app/shop_layout.dart';
import 'package:bmicalc/modules/shop_app/on_bordring/on_boarding_screen.dart';
import 'package:bmicalc/shared/bloc_observer.dart';
import 'package:bmicalc/shared/components/const.dart';
import 'package:bmicalc/shared/cubit/cubit.dart';
import 'package:bmicalc/shared/cubit/states.dart';
import 'package:bmicalc/shared/networks/local/cache_helper.dart';
import 'package:bmicalc/shared/styles/thems.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'modules/shop_app/login_screen/login_screen.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'shared/networks/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();

  bool onBoarding = CacheHelper.getData(key: "onBoarding") ?? false;
  token = CacheHelper.getData(key: "token");
  print(token);
  late Widget widget;
  if (onBoarding != false) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  print(onBoarding);
  BlocOverrides.runZoned(
    () {
      DioHelper.init();
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriseData()
            ..getFavoritesData()
            ..getProfileData(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: ShopLoginScreen(),
          );
        },
      ),
    );
  }
}
