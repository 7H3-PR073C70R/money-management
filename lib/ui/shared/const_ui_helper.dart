// Vertical Spaces
import 'package:flutter/cupertino.dart';

const verticalSpaceExtraLarge = SizedBox(height: 75);
const verticalSpaceLarge = SizedBox(height: 64);
const verticalSpaceMedium = SizedBox(height: 40,);
const verticalSpaceSmall = SizedBox(height: 24,);
const verticalSpaceVeryTiny = SizedBox(height: 8,);




// Screen Height and Width
screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
screenHeiht(BuildContext context) => MediaQuery.of(context).size.height;