import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/app/palette.dart';
import 'package:mobile_app_labamu/core/constant/routes.dart';
import 'package:mobile_app_labamu/core/constant/utils.dart';
import 'package:mobile_app_labamu/state/home_state.dart';
import 'package:mobile_app_labamu/domain/bloc/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        backgroundColor: Palette.white,
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) => {
            //
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(Util.basePaddingMargin16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserInformationContainer(cubit: cubit),
                      const SizedBox(height: Util.baseWidthHeight20),
                      ProductListContainer(cubit: cubit),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Container ProductListContainer({required HomeCubit cubit}) => Container(
        child: ListView.builder(
          itemCount: cubit.products.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = cubit.products[index];
            var priceText = 'N/A';
            if (data.price != null) {
              priceText = cubit.generalHelper.formatIdr(data.price!);
            }

            return ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.product_detail,
                  arguments: data,
                );
              },
              leading: CircleAvatar(
                backgroundColor: Palette.red,
                child: Text(
                  avatarInitials(data.name ?? ''),
                  style: TextStyle(
                    color: Palette.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(data.name ?? 'Unnamed product'),
              subtitle: Text(
                priceText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Palette.red,
                ),
              ),
            );
          },
        ),
      );

  String avatarInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      // when there are 2+ words -> use the first letter of the first word
      return parts[0].substring(0, 1).toUpperCase();
    } else {
      // when there is only 1 word -> use first and last letter
      return trimmed.length == 1
          ? trimmed.toUpperCase()
          : (trimmed[0] + trimmed[trimmed.length - 1]).toUpperCase();
    }
  }

  Container UserInformationContainer({required HomeCubit cubit}) => Container(
        decoration: BoxDecoration(
          color: Palette.red,
          borderRadius: BorderRadius.circular(Util.basePaddingMargin20),
        ),
        padding: const EdgeInsets.all(Util.basePaddingMargin16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Palette.white,
              child: Icon(
                Icons.person,
                color: Palette.red,
              ),
            ),
            const SizedBox(width: Util.baseWidthHeight16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: Util.baseTextSize18,
                    fontWeight: FontWeight.bold,
                    color: Palette.white,
                  ),
                ),
                Text(
                  "john.doe@example.com",
                  style: TextStyle(
                    fontSize: Util.baseTextSize14,
                    color: Palette.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
