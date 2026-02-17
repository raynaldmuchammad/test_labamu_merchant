import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/constant/routes.dart';
import 'package:mobile_app_labamu/domain/bloc/boarding_cubit.dart';
import 'package:mobile_app_labamu/domain/bloc/main_cubit.dart';
import 'package:mobile_app_labamu/domain/bloc/product_add_cubit.dart';
import 'package:mobile_app_labamu/domain/bloc/product_detail_cubit.dart';
import 'package:mobile_app_labamu/domain/bloc/splash_cubit.dart';
import 'package:mobile_app_labamu/presentation/ui/boarding_screen/boarding_page.dart';
import 'package:mobile_app_labamu/presentation/ui/main_screen/main_page.dart';
import 'package:mobile_app_labamu/presentation/ui/product_screen/product_add_page.dart';
import 'package:mobile_app_labamu/presentation/ui/product_screen/product_detail_page.dart';
import 'package:mobile_app_labamu/presentation/ui/splash_screen/splash_page.dart';
import 'package:mobile_app_labamu/domain/bloc/home_cubit.dart';
import 'package:mobile_app_labamu/presentation/ui/home_screen/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.landing:
          return getPageRoute(
            BlocProvider(
              create: (context) => MainCubit()..initCubit(),
              child: const MainPage(),
            ),
          );
        case Routes.splash:
          return getPageRoute(
            BlocProvider(
              create: (context) => SplashCubit()..initCubit(),
              child: SplashPage(),
            ),
          );
        case Routes.home:
          return getPageRoute(
            BlocProvider(
              create: (context) => HomeCubit()..initCubit(),
              child: const HomePage(),
            ),
          );
        case Routes.product_add:
          return getPageRoute(
            BlocProvider(
              create: (context) => ProductAddCubit()..initCubit(),
              child: const ProductAddPage(),
            ),
          );
        case Routes.product_detail:
          return getPageRoute(
            BlocProvider(
              create: (context) => ProductDetailCubit()..initCubit(),
              child: const ProductDetailPage(),
            ),
            settings,
            true,
          );
        case Routes.product_update:
          return getPageRoute(
            BlocProvider(
              create: (context) => HomeCubit()..initCubit(),
              child: const HomePage(),
            ),
            settings,
            true,
          );
        case Routes.boarding:
          return getPageRoute(
            BlocProvider(
              create: (context) => BoardingCubit()..initCubit(),
              child: BoardingPage(),
            ),
          );
        // case Routes.event:
        //   var args = settings.arguments;
        //   return getPageRoute(
        //     BlocProvider(
        //       create: (context) => EventCubit(data: args)..initCubit(),
        //       child: EventPage(),
        //     ),
        //   );
        default:
          return errorRoute();
      }
    } catch (e) {
      return errorRoute();
    }
  }

  static CupertinoPageRoute getPageRoute(
    Widget child, [
    RouteSettings settings = const RouteSettings(),
    bool? isFullScreenDialog = false,
  ]) =>
      CupertinoPageRoute(
        builder: (context) => child,
        fullscreenDialog: isFullScreenDialog!,
        settings: RouteSettings(
          name: settings.name,
          arguments: settings.arguments,
        ),
      );

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Oops")),
        body: const Center(child: Text("Page not found!")),
      );
    });
  }
}
