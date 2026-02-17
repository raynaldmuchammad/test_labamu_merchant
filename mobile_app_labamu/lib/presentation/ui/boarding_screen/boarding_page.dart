import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_labamu/core/constant/routes.dart';
import 'package:mobile_app_labamu/core/constant/utils.dart';
import 'package:mobile_app_labamu/core/app/palette.dart';
import 'package:mobile_app_labamu/domain/bloc/boarding_cubit.dart';
import 'package:mobile_app_labamu/state/boarding_state.dart';

class BoardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BoardingPageState();
}

class BoardingPageState extends State<BoardingPage> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BoardingCubit>();
    return Scaffold(
      backgroundColor: Palette.grey100,
      body: BlocConsumer<BoardingCubit, BoardingState>(
        listener: (context, state) {
          //
        },
        builder: (context, state) {
          return SafeArea(
            child: PageView.builder(
              controller: cubit.controller,
              itemCount: cubit.pages.length,
              onPageChanged: (index) {
                cubit.changePage(index);
              },
              itemBuilder: (context, index) {
                var content = cubit.pages[index];
                dynamic image = Image.network(content['image']);
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Util.basePaddingMargin16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Util.basePaddingMargin16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Util.baseRoundedCorner,
                          ),
                        ),
                        child: image,
                      ),
                      const SizedBox(height: Util.baseWidthHeight80),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          content['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: Util.baseTextSize18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: Util.baseWidthHeight16),
                      Container(
                        child: Text(
                          content['description'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: Util.baseTextSize14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<BoardingCubit, BoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<BoardingCubit>();
          return Container(
            height: Util.baseWidthHeight200,
            padding: const EdgeInsets.symmetric(
              vertical: Util.basePaddingMargin20,
              horizontal: Util.basePaddingMargin56,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                cubit.isLastPage
                    ? Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: Util.baseWidthHeight185,
                              height: Util.baseWidthHeight48,
                              decoration: BoxDecoration(
                                color: Palette.red,
                                borderRadius: BorderRadius.circular(
                                  Util.baseRoundedCorner12,
                                ),
                              ),
                              child: TextButton(
                                child: Text(
                                  "Get Started",
                                  style: TextStyle(
                                    color: Palette.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.landing,
                                    (route) => false,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                height: Util.baseWidthHeight48,
                                decoration: BoxDecoration(
                                  color: Palette.red,
                                  borderRadius: BorderRadius.circular(
                                    Util.baseRoundedCorner12,
                                  ),
                                ),
                                child: TextButton(
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      color: Palette.white,
                                      fontSize: Util.baseTextSize16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      Routes.landing,
                                      (route) => false,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: Util.baseWidthHeight24),
                            Expanded(
                                child: Container(
                              height: Util.baseWidthHeight48,
                              decoration: BoxDecoration(
                                color: Palette.red,
                                borderRadius: BorderRadius.circular(
                                  Util.baseRoundedCorner12,
                                ),
                              ),
                              child: TextButton(
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Palette.white,
                                    fontSize: Util.baseTextSize16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  cubit.controller.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            )),
                          ],
                        ),
                      ),
                const SizedBox(height: Util.baseWidthHeight24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cubit.pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: index == cubit.pageIndex
                          ? Util.baseWidthHeight24
                          : Util.baseWidthHeight12,
                      height: Util.baseWidthHeight8,
                      margin: const EdgeInsets.symmetric(
                        vertical: Util.basePaddingMargin8,
                        horizontal: Util.basePaddingMargin8,
                      ),
                      decoration: BoxDecoration(
                        color: index == cubit.pageIndex
                            ? Palette.red
                            : Palette.grey300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(Util.baseRoundedCorner12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
