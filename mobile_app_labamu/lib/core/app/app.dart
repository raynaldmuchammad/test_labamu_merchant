import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connection_service.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connectivity_cubit.dart';
import 'theme.dart';
import 'env.dart';
import '../constant/routes.dart';
import '../constant/app_constant.dart';
import '../../domain/bloc/main_cubit.dart';
import '../../presentation/ui/main_screen/main_page.dart';
import '../../presentation/router/route_generator.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (context) => MainCubit()..initCubit(),
          child: const MainPage(),
        ),
        BlocProvider<ConnectivityCubit>(
          create: (context) => ConnectivityCubit(connectionService: new ConnectionService())..initialize(),
        ),
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
