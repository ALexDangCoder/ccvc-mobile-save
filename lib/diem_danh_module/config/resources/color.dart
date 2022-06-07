import 'dart:ui';

import 'package:flutter/material.dart';

///=========== Colors for default when didn't setup app theme ===============
///https://stackoverflow.com/a/17239853
const colorPrimary = Color(0xff0ABAB5);
const colorPrimaryTransparent = Color(0x720ABAB5);
const colorAccent = Color(0xffDCFFFE);
const colorSelected = Color(0xFFE0F2F1);
const mainTxtColor = Color(0xFF30536F);
const dfTxtColor = Color(0xFF303742);
const secondTxtColor = Color(0xFF808FA8);
const highlightTxtColor = Color(0xff303742);
const subTitle = Color(0xff8F9CAE);
const attackFile = Color(0xff8F9CAE);

///=========== Using to make change app theme ================================
abstract class AppColor {}

class LightApp extends AppColor {}

class DarkApp extends AppColor {}

class DefaultApp extends AppColor {}

class BlueApp extends AppColor {}

class PinkApp extends AppColor {}

class YellowApp extends AppColor {}
