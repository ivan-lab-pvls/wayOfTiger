import 'package:flutter/material.dart';
import 'package:tiger_fortune/core/app_export.dart';
import 'package:tiger_fortune/data/data_manager.dart';
import 'package:tiger_fortune/widgets/custom_outline_button.dart';

import '../../game/game_bloc/game_bloc.dart';
import '../../game/widgets/game_cell.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> images = [];
  PageController _pageController = PageController();
  int _activePage = 0;
  List<Widget> _list = [];
  bool buttonIsDisabled = false;

  @override
  void initState() {
    images = DataManager.generateRandomList();
    _list = <Widget>[
      new Center(
        child: _textPanel(
          mainText: 'Tiger fun game!',
          bodyText:
              'Together we’re going to learn how to play this\ngame. It can seem easy for you, but don’t let\nyou fool yourslelf.',
        ),
      ),
      new Center(
        child: _textPanel(
          mainText: 'First step',
          bodyText:
              'Always try to remember the order of cards\nappearing. Lets try for the first time.',
        ),
      ),
      BlocProvider<GameBloc>(
        create: (context) => GameBloc()
          ..add(StartGameEvent(gridCount: 3, level: 0, sequenceCount: 3)),
        child: _gamePanel(images),
      ),
      new Center(
        child: _textPanel(
          mainText: 'Second step',
          bodyText:
              'Now you know how to play. It’s time to tell\nyou my secret!',
        ),
      ),
      new Center(
        child: _textPanel(
          mainText: 'The secret',
          bodyText:
              'My name is Tiger. Yes, I’m a tiger. But that is\nnot confidential information. Tell this\nanyone!',
        ),
      ),
      new Center(
        child: _textPanel(
            mainText: 'Another secret',
            bodyText:
                'If you don’t remember the next card, you can\npress the question button. It will show you.',
            icon: ImageConstant.imgQuestionBtn),
      ),
      new Center(
        child: _textPanel(
            mainText: 'And one more',
            bodyText:
                'I give you three tips fo free. But next time,\nwhen you will use all of it, you an by new at\nthe shop.',
            icon: ImageConstant.imgShopBtn),
      ),
      new Center(
        child: _textPanel(
          mainText: 'Last one!',
          bodyText: 'So... Now you’re are ready. Let’s begin the\njourney!',
        ),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (int page) {
          setState(() {
            _activePage = page;
          });
          if (page == 2) {
            setState(() {
              buttonIsDisabled = true;
            });
          } else {
            setState(() {
              buttonIsDisabled = false;
            });
          }
        },
        itemBuilder: (BuildContext context, int index) {
          return _list[index];
        },
      ),
      floatingActionButton: buttonIsDisabled
          ? Container()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.h),
              child: CustomOutlinedButton(
                text: 'Next',
                buttonStyle: CustomButtonStyles.outline,
                onPressed: () {
                  if (_activePage >= _list.length - 1) {
                    NavigatorService.pushNamedAndRemoveUntil(
                        AppRoutes.mainScreen);
                  }
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear);
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _textPanel({
    String mainText = '',
    String bodyText = '',
    String icon = '',
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgBack,
          fit: BoxFit.fill,
        ),
        Positioned(
          bottom: -50,
          left: -100,
          right: -100,
          child: Container(
            child: CustomImageView(
              imagePath: ImageConstant.imgTiger,
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              Container(
                //  width: 200,
                child: Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: AppDecoration.outline,
                  child: Column(
                    children: [
                      Text(
                        mainText,
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        bodyText,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: icon.isNotEmpty
                    ? CustomImageView(
                        height: 80.v,
                        width: 80.h,
                        imagePath: icon,
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ],
    );
  }

  int currentIndex = -1;
  String message = '';

  Widget _gamePanel(List<String> images) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgBack,
          fit: BoxFit.fill,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 150.h,
              ),
              Container(
                //  width: 200,
                child: Container(
                  padding: EdgeInsets.all(10.h),
                  decoration: AppDecoration.outline,
                  child: Column(
                    children: [
                      Text(
                        'First try!',
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Tap on card in order of its appearing.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  message = context.read<GameBloc>().text;
                  return BlocBuilder<GameBloc, GameState>(
                    builder: (context, state) {
                      if (state is GameInitState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GameSequenceShowingState) {
                        return GameCell(
                          image: images[index],
                          index: index,
                          currentIndex: state.index,
                          onTap: () {},
                          isWrong: false,
                          // child: Center(child: Text('$index')),
                        );
                      } else if (state is GamePlayingState) {
                        return GameCell(
                          image: images[index],
                          index: index,
                          currentIndex: -1,
                          onTap: () {
                            context
                                .read<GameBloc>()
                                .add(CellTappedEvent(index, endCallback: () {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.linear);
                                }));
                          },
                          isWrong: false,
                          // child: Center(child: Text('$index')),
                        );
                      } else if (state is GameWrongState) {
                        message = 'TRY AGAIN';

                        return GameCell(
                          image: images[index],
                          index: index,
                          currentIndex: -1,
                          onTap: null,
                          isWrong: state.isWrong,
                          // child: Center(child: Text('$index')),
                        );
                      } else if (state is GameOverWaitState) {
                        message = 'GOOD';
                        return GameCell(
                          image: images[index],
                          index: index,
                          currentIndex: -1,
                          onTap: null,
                          isWrong: false,
                          // child: Center(child: Text('$index')),
                        );
                      } else if (state is GameOverState) {

                        state.endCallback.call();
                        return Container();
                      } else {
                        return ElevatedButton(
                          child: Text('StartGame'),
                          onPressed: () {
                            context.read<GameBloc>().add(StartGameEvent(
                                gridCount: 3, level: 0, sequenceCount: 3));
                          },
                        );
                      }
                    },
                  );
                },
              ),
              BlocBuilder<GameBloc, GameState>(builder: (context, state) {
                if (state is GameWrongState) {
                  return Text(
                    'TRY AGAIN',
                    style: theme.textTheme.titleLarge,
                  );
                } else if (state is GameOverWaitState) {
                  return Text(
                    'GOOD',
                    style: theme.textTheme.titleLarge,
                  );
                } else {
                  return Text(
                    message,
                    style: theme.textTheme.titleLarge,
                  );
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}
