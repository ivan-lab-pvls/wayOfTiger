import 'package:flutter/material.dart';
import 'package:tiger_fortune/core/app_export.dart';

class GameCell extends StatefulWidget {
  final String image;
  final VoidCallback? onTap;
  final int index;
  final int currentIndex;
  final bool isWrong;

  const GameCell({
    Key? key,
    required this.onTap,
    required this.image,
    required this.index,
    required this.currentIndex,
    required this.isWrong,
  }) : super(key: key);

  @override
  State<GameCell> createState() => _GameCellState();
}

class _GameCellState extends State<GameCell> {
  bool taped = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isWrong) {
      if (taped = true)
        setState(() {
          taped = false;
        });
    }
    return GestureDetector(
      onTap: () {
        if (widget.currentIndex == -1) {
          setState(() {
            taped = true;
          });
        }
        widget.onTap?.call();
      },
      child: Container(
        decoration: widget.index == widget.currentIndex || taped ? AppDecoration.outlineBlack: AppDecoration.outline,
        /*   color: widget.index == widget.currentIndex || taped
            ? widget.image
            : widget.color.withOpacity(0.5),*/
        margin:  EdgeInsets.all(8.h),
        child: widget.index == widget.currentIndex || taped
            ? CustomImageView(
                fit: BoxFit.fitWidth,
                imagePath: widget.image,
              )
            : Container(),
      ),
    );
  }

  void clearTaped() {
    setState(() {
      taped = false;
    });
  }
}
