import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'start_up_view_model.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var _radius = const Radius.circular(20);
    return ViewModelBuilder<StartUpViewModel>.reactive(
      builder: (context, model, child) => StatusBar(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.index != 0)
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 37),
                  child: GestureDetector(
                      onTap: () => model.updateIndex(true),
                      child: SvgPicture.asset(backArrowSvg)),
                ),
              SizedBox(
                height: _size.height * 0.45,
                child: Center(
                    child: SvgPicture.asset(model.doc[model.index]['image'])),
              ),
              Container(
                height: _size.height * 0.45,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: _radius, topRight: _radius),
                    color: kcPrimaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: _size.height * 0.25,
                      width: _size.width * 0.7,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BoxText.headingFive(model.doc[model.index]['title'],
                              color: Colors.white),
                          const SizedBox(
                            height: 24,
                          ),
                          BoxText.body(model.doc[model.index]['subtitle'],
                              color: Colors.white),
                          SizedBox(
                            height: 62,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BuildCircle(isIndex: model.index == 0),
                                const SizedBox(
                                  width: 15,
                                ),
                                BuildCircle(isIndex: model.index == 1),
                                const SizedBox(
                                  width: 15,
                                ),
                                BuildCircle(isIndex: model.index == 2),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35, right: 35, bottom: 44),
                      child: model.index != 2
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: model.gotoLoginOrSignUP,
                                  child: BoxText.body(
                                    skipText,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => model.updateIndex(false),
                                  child: BoxText.body(
                                    nextText,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          : GestureDetector(
                              onTap: model.gotoLoginOrSignUP,
                              child: Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(52),
                                    color: Colors.white),
                                child: const Center(
                                  child: Icon(
                                    Icons.done,
                                    size: 45,
                                    color: kcPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}

class BuildCircle extends StatelessWidget {
  final bool isIndex;
  const BuildCircle({Key? key, required this.isIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isIndex ? 15 : 10,
      width: isIndex ? 15 : 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isIndex ? 15 : 10),
          color: Colors.white),
    );
  }
}
