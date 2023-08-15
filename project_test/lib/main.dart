import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_test/modules/garbage/MIB_calc.dart';
import 'package:project_test/networks/local/cache_helper.dart';
import 'package:project_test/shared/bloc_observer.dart';
import 'package:project_test/shared/cubit/cubit.dart';
import 'package:project_test/shared/cubit/states.dart';
import 'package:project_test/shared/themes/styles.dart';

import 'components/constants.dart';
import 'layout/shop_layout/cubit/cubit.dart';
import 'layout/shop_layout/shop_layout.dart';
import 'modules/garbage/hamza_project.dart';
import 'modules/garbage/home_layout.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_lauout.dart';

import 'modules/shop_app/on_boarding/on_boarding_screene.dart';
import 'modules/shop_app/on_boarding/shop_login_screen/shop_login.dart';
import 'networks/remote/dio_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool ? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;
  token = CacheHelper.getData(key: 'token');
  print(token);
  bool ? onBoarding = CacheHelper.getData(key: 'onBoarding');

  if(onBoarding != null){
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {


  final bool ? isDark;
  final Widget ? startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  Widget build(BuildContext context) {
    return MultiBlocProvider(
        //NewsCubit()..getBusiness()
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (context) => Appcubit()..ChangeThemeMode(
          fromShared: isDark,
        ),),
        BlocProvider(
            create: (context) => ShopAppLayoutCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        ),
      ],
      child: BlocConsumer<Appcubit,Appstates>(
        builder: (context,state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: Appcubit.get(context).isDark? ThemeMode.light : ThemeMode.light,
          home: startWidget,

        ),
        listener: (context,state){},

      ),
    );
  }
}

