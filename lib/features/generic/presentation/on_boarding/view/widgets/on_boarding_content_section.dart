import 'package:flutter/material.dart';
import 'package:task_manager_app/core/app/constants.dart';

class OnBoardingContentSection extends StatelessWidget {
  final int pageNumber;
  final Widget image;
  final Widget textColumn;
  final Animation<Offset> lightCardOffsetAnimation;
  final Animation<Offset> darkCardOffsetAnimation;

  const OnBoardingContentSection({
    super.key,
    required this.pageNumber,
    required this.image,
    required this.textColumn,
    required this.lightCardOffsetAnimation,
    required this.darkCardOffsetAnimation,
  });

  bool get isOddPageNumber => pageNumber % 2 == 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            SlideTransition(
              position: darkCardOffsetAnimation,
              child: SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: Center(
                    child: image,
                  )),
            ),
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: Constants.onBoardingImage),
          child: textColumn,
        ),
      ],
    );
  }
}
