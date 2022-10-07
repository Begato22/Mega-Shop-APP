import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/Shop/cubit/cubit.dart';
import 'package:shop_app/layouts/Shop/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/my_bloc_observer.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

import 'modules/login/cubit/cubit.dart';
import 'modules/onbordering/on_bordering_screen.dart';
import 'shared/styles/colors.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );
  //to can get instance from api
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // to here

  DioHelper.initi();
  await CashHelper.initi();
  Bloc.observer = MyBlocObserver();

  bool? isOnBorderingFinshed = CashHelper.getData(key: 'onBordering');
  token = CashHelper.getData(key: 'token');

  Widget widget;

  if (isOnBorderingFinshed != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBorderingScreen();
  }

  runApp(
    MyApp(
      statrWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.statrWidget}) : super(key: key);
  final Widget statrWidget;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopHomeCubite()
            ..getHomeData()
            ..getCategoryData()
            ..getFavorite()
            ..getProfile(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubite(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: defultColor,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        themeMode: ThemeMode.light,
        home: statrWidget,
      ),
    );
  }
}
