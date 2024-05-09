import 'package:flutter/material.dart';
import 'package:tiger_fortune/widgets/custom_outline_button.dart';

import '../../core/app_export.dart';
import '../../data/player_stats.dart';
import '../../widgets/app_bar/app_bar_bloc.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  static Widget builder(BuildContext context) {
    return ShopScreen();
  }

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
          Container(
            decoration: AppDecoration.fadeContainer,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  height: 180.v,
                  imagePath: ImageConstant.imgShopBtn,
                ),
                CustomOutlinedButton(
                  onPressed: () {
                    if (PlayerStats.balance >= 100) {
                      PlayerStats.decreaseBalance(100);
                      PlayerStats.increaseHint(1);
                      setState(() {

                      });
                    }
                  },
                  isDisabled: PlayerStats.balance < 100,
                  //  decoration:  PlayerStats.balance < 100? AppDecoration.outline: AppDecoration.outline,
                  buttonStyle: PlayerStats.balance < 100
                      ? CustomButtonStyles.outlineGray
                      : CustomButtonStyles.outline,
                  width: 200,
                  text: 'Buy',
                  rightIcon: Row(
                    children: [
                      SizedBox(
                        width: 10.h,
                      ),
                      Container(
                        width: 40.h,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgCoin,
                        ),
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Text(
                        '100',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
