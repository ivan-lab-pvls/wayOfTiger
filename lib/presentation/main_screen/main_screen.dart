import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:tiger_fortune/core/app_export.dart';

import '../../data/player_stats.dart';
import '../../widgets/app_bar/app_bar_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static Widget builder(BuildContext context) {
    return MainScreen();
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              IconButton(
                onPressed: () {
                  levelDonePopUp();
                },
                icon: CustomImageView(
                  imagePath: ImageConstant.imgSettingsBtn,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: AppDecoration.gradientRedToOnPrimary,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 140.v,
                ),
                _buttonMain(
                  context,
                  text: 'Tiger game',
                  imagePath: ImageConstant.imgMainBtnTiger,
                  iconImagePath: ImageConstant.imgPlayBtn,
                  onTap: () =>
                      NavigatorService.pushNamed(AppRoutes.levelScreen),
                ),
                SizedBox(
                  height: 10.v,
                ),
                _buttonMain(
                  context,
                  text: 'Mini game',
                  imagePath: ImageConstant.imgMainBtnMini,
                  iconImagePath: ImageConstant.imgPlayBtn,
                  onTap: () =>
                      NavigatorService.pushNamed(AppRoutes.miniGameScreen),
                ),
                SizedBox(
                  height: 10.v,
                ),
                _buttonMain(
                  context,
                  text: 'Shop',
                  imagePath: ImageConstant.imgMainBtnShop,
                  iconImagePath: ImageConstant.imgShopBtn,
                  onTap: () => NavigatorService.pushNamed(AppRoutes.shopScreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonMain(
    BuildContext context, {
    String text = '',
    String imagePath = '',
    String iconImagePath = '',
    Function? onTap,
  }) {
    return Container(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            onTap?.call();
          },
          child: Stack(
            children: [
              Container(
                child: CustomImageView(
                  imagePath: imagePath,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: theme.textTheme.headlineMedium,
                    ),
                    Container(
                      height: 70.v,
                      child: CustomImageView(
                        imagePath: iconImagePath,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void levelDonePopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: AppDecoration.outlineBlack,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Center(
                child: Container(
                  child: Material(
                    type: MaterialType.transparency,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgElderScroll,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 20.h,
                top: 120.v,
                child: IconButton(
                  onPressed: () {
                    NavigatorService.goBack();
                  },
                  icon: CustomImageView(
                    imagePath: ImageConstant.imgXBtn,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 450.v,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Container(
                          width: 200.h,
                          height: 60.v,
                          //  padding: EdgeInsets.all(5.h),
                          decoration: AppDecoration.outline,
                          child: Center(
                            child: Text(
                              'SETTINGS',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.v,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => const Reader(
                                      link:
                                          'https://docs.google.com/document/d/1dgdj-BAqncgOKQxsGbRGp0eZ96e2sIq8PKqhjHLVANE/edit?usp=sharing',
                                    )),
                          );
                        },
                        child: Text(
                          'PRIVACY POLICY',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: appTheme.brown),
                        ),
                      ),
                      SizedBox(
                        height: 20.v,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => const Reader(
                                      link:
                                          'https://docs.google.com/document/d/16ri7p-jns-bZuSlTgVj3CKVvx1NU2z6lPJ55DKmd-BA/edit?usp=sharing',
                                    )),
                          );
                        },
                        child: Text(
                          'TERMS OF USE',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: appTheme.brown),
                        ),
                      ),
                      SizedBox(
                        height: 20.v,
                      ),
                      TextButton(
                        onPressed: () {
                          InAppReview.instance
                              .openStoreListing(appStoreId: '6499271557');
                        },
                        child: Text(
                          'RATE APP',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: appTheme.brown),
                        ),
                      ),
                      SizedBox(
                        height: 20.v,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => const Reader(
                                      link:
                                          'https://forms.gle/MT9ruGPbwWdvUh8v8',
                                    )),
                          );
                        },
                        child: Text(
                          'SUPPORT',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: appTheme.brown),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.7),
    );
  }
}

class Reader extends StatelessWidget {
  final String link;

  const Reader({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(link)),
        ),
      ),
    );
  }
}
