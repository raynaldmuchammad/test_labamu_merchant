import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connectivity_cubit.dart';
import 'package:mobile_app_labamu/core/helper/connectivity/connectivity_state.dart';
import 'package:mobile_app_labamu/presentation/widget/snack_bar_widget.dart';

class ConnectivityPage extends StatefulWidget {
  final Widget child;

  const ConnectivityPage({super.key, required this.child});

  @override
  State<ConnectivityPage> createState() => ConnectivityPageState();
}

class ConnectivityPageState extends State<ConnectivityPage> {
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);


    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityConnected) {
          scaffold.showSnackBar(
            snackBarWidget(
              context: context,
              message: "Connection Connected",
              callback: scaffold.hideCurrentSnackBar,
            ),
          );
        }

        if (state is ConnectivityDisconnected) {
          scaffold.showSnackBar(
            snackBarWidget(
              context: context,
              message: "Connection Disconnected",
              callback: scaffold.hideCurrentSnackBar,
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          child: widget.child,
        );
      },
    );
  }
}