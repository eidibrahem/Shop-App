import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/modules/shop_app/onboarding/on_boarding.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/stats.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remot/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/shared/styles/themes.dart';

import 'layout/news_app/news_layout.dart';
import 'modules/shop_app/login/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  DioHelper.inith();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onbording = CacheHelper.getData1(key: 'onBoarding');
  if (CacheHelper.getData1(key: 'token') != null)
    token = CacheHelper.getData1(key: 'token');
  print(token);
  if (onbording != null) {
    if (token != null&&token!='') {
      widget = ShopLayout(token);
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = onBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

Future<ValueNotifier<Color>> initSettings() async {
 
  final _accentColor = ValueNotifier(Colors.blueAccent);
  return _accentColor;
}

bool _isDarkTheme = true;
bool _isUsingHive = true;


class MyApp extends StatelessWidget {
  MyApp({Key? key, this.isDark, this.startWidget}) : super(key: key);

  final bool? isDark;
  //final bool? onBoarding;
  final Widget? startWidget;
  //bool onboarding = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..changeAppMode(fromShared: isDark),
          ),
          BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData())
        ],
        child: BlocConsumer<NewsCubit, NewStates>(
            listener: (context, state) {},
            builder: (context, state) {
              //if (onBoarding == null)
              // onboarding = false;
              //else
              // onboarding = true;

              return MaterialApp(
                title: 'News app',
                theme: lightTheme2,
                themeMode: NewsCubit.get(context).isDark
                    ? ThemeMode.light
                    : ThemeMode.dark,
                darkTheme: darkTheme,
                home:
                    startWidget, // onboarding ? ShopLoginScreen() : onBoardingScreen(),
                debugShowCheckedModeBanner: false,
              );
            }));
  }
}
