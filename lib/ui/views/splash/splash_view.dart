import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_image_path.dart';
import '../../shared/const_ui_helper.dart';
import '../../shared/dumb_widgets/statusbar.dart';
import 'splash_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => model.init(),
      builder: (
        BuildContext context,
        SplashViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          color: kcPrimaryColor,
          child: Scaffold(
            body: Image.asset(
              splashImage,
              height: screenHeiht(context),
              width: screenWidth(context),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
