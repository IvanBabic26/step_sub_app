import 'package:flutter/material.dart';
import 'package:step_sub/design/images.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, this.isMainScreen = true});

  final bool isMainScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMainScreen ? double.infinity : null,
      padding: isMainScreen ? EdgeInsets.only(top: MediaQuery.of(context).padding.top) : null,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.backgroundImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
