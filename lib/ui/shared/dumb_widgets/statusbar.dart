import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBar extends StatelessWidget {
  final Color color;
  final Widget child;
  const StatusBar({ Key? key, this.color = Colors.white, required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: color,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
      child: child
    );
  }
}