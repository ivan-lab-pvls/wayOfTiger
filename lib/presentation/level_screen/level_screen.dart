import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tiger_fortune/core/app_export.dart';
import 'package:tiger_fortune/data/models/level_model/level_model.dart';
import 'package:tiger_fortune/game/level_bloc/level_bloc.dart';

import '../../widgets/app_bar/app_bar_bloc.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<LevelBloc>(
      create: (context) => LevelBloc()..add(LevelLoadEvent()),
      child: LevelScreen(),
    );
  }

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  CarouselController _carouselController = CarouselController();
  int _activePage = 0;
  bool leftBtnDisabled = false;
  bool rightBtnDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  NavigatorService.goBack();
                },
                icon: CustomImageView(
                  imagePath: ImageConstant.imgLeftBtn,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.h),
                child: Container(
                  width: 120.h,
                  padding: EdgeInsets.all(5.h),
                  decoration: AppDecoration.outline,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.h,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgCoin,
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      BlocBuilder<AppBarBloc, AppBarState>(
                        bloc: AppBarBloc(),
                        builder: (context, state) {
                          return Text(
                            state.balance.toStringAsFixed(0),
                            style: theme.textTheme.titleMedium,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80.h,
              ),
              /* IconButton(
                onPressed: () {},
                icon: CustomImageView(
                  imagePath: ImageConstant.imgSettingsBtn,
                ),
              ),*/
            ],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomImageView(
            //color: Colors.black.withAlpha(1),
            imagePath: ImageConstant.imgBack,
          ),
          BlocBuilder<LevelBloc, LevelState>(
            builder: (context, state) {
              if (state is LevelLoadedState) {
                print(state.maxOpenedLevel);
                if (state.maxOpenedLevel <= 1) {
                  leftBtnDisabled = true;
                  rightBtnDisabled = true;
                }

                return CarouselSlider.builder(
                  disableGesture: true,
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    height: 550,
                    //  aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: state.maxOpenedLevel,
                    reverse: false,
                    enlargeCenterPage: true,

                    onPageChanged: (index, reason) {
                      setState(() {
                        _activePage = index;
                      });
                      if (index == 0) {
                        setState(() {
                          leftBtnDisabled = true;
                        });
                      } else {
                        setState(() {
                          leftBtnDisabled = false;
                        });
                      }
                      if (index >= state.maxOpenedLevel) {
                        setState(() {
                          rightBtnDisabled = true;
                        });
                      } else {
                        setState(() {
                          rightBtnDisabled = false;
                        });
                      }
                    },
                    //scrollDirection: Axis.,
                  ),
                  itemCount: state.levels.length,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return itemWidget(context, level: state.levels[index]);
                  },
                );
              } else {
                rightBtnDisabled = true;
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget itemWidget(BuildContext context, {required LevelModel level}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 100.v),
      child: Center(
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          //: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: 250,
              decoration: AppDecoration.outline
                  .copyWith(borderRadius: BorderRadiusStyle.circularBorder127),
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 70.v),
                      child: Text(
                        'Level',
                        style: CustomTextStyles.headLineLargeOnErrorContainer,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.v),
                      child: Text(
                        (level.index + 1).toString(),
                        style: CustomTextStyles.inknutAntiquaOnErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 300.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (!leftBtnDisabled)
                        _carouselController.previousPage(
                            duration: Duration(milliseconds: 100),
                            curve: Curves.linear);
                    },
                    focusColor: Colors.transparent,
                    icon: CustomImageView(
                      height: 80.v,
                      imagePath: leftBtnDisabled
                          ? ImageConstant.imgLeftBtnSmallDisable
                          : ImageConstant.imgLeftBtnSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      NavigatorService.pushNamed(AppRoutes.tigerGameScreen,
                          arguments: level);
                    },
                    icon: CustomImageView(
                      height: 120.v,
                      imagePath: ImageConstant.imgPlayBtn,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (!rightBtnDisabled)
                        _carouselController.nextPage(
                            duration: Duration(milliseconds: 100),
                            curve: Curves.linear);
                    },
                    icon: CustomImageView(
                      height: 80.v,
                      imagePath: rightBtnDisabled
                          ? ImageConstant.imgRightBtnSmallDisable
                          : ImageConstant.imgRightBtnSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
