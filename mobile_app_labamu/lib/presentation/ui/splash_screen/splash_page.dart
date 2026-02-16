import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/constant/routes.dart';
import 'package:mobile_app_labamu/core/constant/utils.dart';
import 'package:mobile_app_labamu/domain/bloc/splash_cubit.dart';
import 'package:mobile_app_labamu/state/splash_state.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          //
        },
        builder: (context, state) {
          if (state is SplashLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(
                Routes.landing,
              );
            });
          }
          return SafeArea(
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                scale: 3,
                alignment: Alignment.center,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: Util.baseWidthHeight60,
        alignment: Alignment.center,
        child: Text("Powered by: Otaqu.id"),
      ),
    );
  }
}
