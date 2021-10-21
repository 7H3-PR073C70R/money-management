import 'package:flutter/cupertino.dart';

// Vertical Spaces
const verticalSpaceExtraLarge = SizedBox(height: 75);
const verticalSpaceLarge = SizedBox(height: 64);
const verticalSpaceMedium = SizedBox(height: 40,);
const verticalSpaceSmall = SizedBox(height: 24,);
const verticalSpaceVeryTiny = SizedBox(height: 8,);


// Vertical Spaces
const horizontalSpaceExtraLarge = SizedBox(width: 75);
const horizontalSpaceLarge = SizedBox(width: 64);
const horizontalSpaceMedium = SizedBox(width: 40,);
const horizontalSpaceSmall = SizedBox(width: 24,);
const horizontalSpaceVeryTiny = SizedBox(width: 8,);


// Screen Height and Width
screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
screenHeiht(BuildContext context) => MediaQuery.of(context).size.height;