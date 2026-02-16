import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/constant/routes.dart';
import 'package:mobile_app_labamu/domain/bloc/main_cubit.dart';
import 'package:mobile_app_labamu/presentation/screen/main/main_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.landing:
          return getPageRoute(
            BlocProvider(
              create: (context) => MainCubit()..initCubit(),
              child: MainPage(),
            ),
          );
        // case Routes.boarding:
        //   return getPageRoute(
        //     BlocProvider(
        //       create: (context) => BoardingCubit()..initCubit(),
        //       child: BoardingPage(),
        //     ),
        //   );
        // case Routes.home:
        //   return getPageRoute(
        //     BlocProvider(
        //       create: (context) => HomeCubit()..initCubit(),
        //       child: HomePage(),
        //     ),
        //   );
        // case Routes.splash:
        //   return getPageRoute(
        //     BlocProvider(
        //       create: (context) => SplashCubit()..initCubit(),
        //       child: SplashPage(),
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
