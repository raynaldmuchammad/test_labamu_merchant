import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/domain/bloc/splash_cubit.dart';
import 'package:mobile_app_labamu/presentation/ui/splash_screen/splash_page.dart';
import '../../core/constant/routes.dart';
import '../ui/main_screen/main_page.dart';
import '../../domain/bloc/main_cubit.dart';
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
              child: HomePage(),
            ),
          );
        case Routes.product_add:
          return getPageRoute(
            BlocProvider(
              create: (context) => HomeCubit()..initCubit(),
              child: HomePage(),
            ),
          );
        case Routes.product_detail:
          return getPageRoute(
            BlocProvider(
              create: (context) => HomeCubit()..initCubit(),
              child: HomePage(),
            ),
          );
        case Routes.product_update:
          return getPageRoute(
            BlocProvider(
              create: (context) => HomeCubit()..initCubit(),
              child: HomePage(),
            ),
          );
        // case Routes.boarding:
        //   return getPageRoute(
        //     BlocProvider(
        //       create: (context) => BoardingCubit()..initCubit(),
        //       child: BoardingPage(),
        //     ),
        //   );
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
