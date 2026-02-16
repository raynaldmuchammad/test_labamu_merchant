import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_labamu/core/constant/app_constant.dart';
import 'package:mobile_app_labamu/core/constant/routes.dart';
import 'package:mobile_app_labamu/presentation/router/route_generator.dart';
import 'package:mobile_app_labamu/core/app/theme.dart';
import 'package:mobile_app_labamu/core/app/env.dart';
import 'package:mobile_app_labamu/domain/bloc/main_cubit.dart';
import 'package:mobile_app_labamu/presentation/screen/main/main_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (context) => MainCubit()..initCubit(),
          child: const MainPage(),
        ),
        // BlocProvider<BoardingCubit>(
        //   create: (context) => BoardingCubit()..initCubit(),
        //   child: BoardingPage(),
        // ),
        // BlocProvider<SplashCubit>(
        //   create: (context) => SplashCubit()..initCubit(),
        //   child: SplashPage(),
        // ),
        // BlocProvider<ProfileCubit>(
        //   create: (context) => ProfileCubit()..initCubit(),
        //   child: ProfilePage(),
        // ),
        // BlocProvider<AuthCubit>(
        //   create: (context) => AuthCubit()..initCubit(),
        //   child: AuthPage(),
        // ),
      ],
      child: MaterialApp(
        theme: basicTheme,
        builder: FToastBuilder(),
        navigatorKey: AppConstant.navigatorKey,
        debugShowCheckedModeBanner: Env.isDevelopment,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.landing,
      ),
    );
  }
}
