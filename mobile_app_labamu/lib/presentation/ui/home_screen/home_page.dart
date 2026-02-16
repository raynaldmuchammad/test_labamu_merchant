import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/app/palette.dart';
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
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
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
                      UserInformationContainer(),
                      const SizedBox(height: Util.baseWidthHeight20),
                      ProductListContainer(),
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

  Container ProductListContainer() => Container(
        child: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed("/product", arguments: "Product ${index + 1}");
                },
                leading: CircleAvatar(
                  backgroundColor: Palette.red,
                  child: Text(
                    "P${index + 1}",
                    style: TextStyle(
                      color: Palette.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text("Product ${index + 1}"),
                subtitle: Text("Description for product ${index + 1}"),
              );
            }),
      );

  Container UserInformationContainer() => Container(
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
