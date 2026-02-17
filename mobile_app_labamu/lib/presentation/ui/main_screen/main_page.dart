import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connectivity_page.dart';
import '../../../core/constant/routes.dart';
import '../../../core/app/palette.dart';
import '../../../state/main_state.dart';
import '../../../domain/bloc/main_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: Palette.white,
        body: ConnectivityPage(
          child: BlocConsumer<MainCubit, MainState>(
            listener: (context, state) {
              //
            },
            builder: (context, state) {
              if (state is BoardingLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.boarding,
                    (route) => false,
                  );
                });
              }

              if (state is HomeLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.home,
                    (route) => false,
                  );
                });
              }
              return const Center(
                child: Text("Loading..."),
              );
            },
          ),
        ),
      ),
    );
  }
}
