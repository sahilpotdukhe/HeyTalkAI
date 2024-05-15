// utility class to hold screen dimensions and scale factors
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heytalkai/Utilities/globals.dart';

class ScaleUtils {
  static late double _height;
  static late double _width;
  static late double _verticalScale;
  static late double _horizontalScale;
  static late double _scaleFactor;

  static void init(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _verticalScale = _height / mockUpHeight; // use a more descriptive name
    _horizontalScale = _width / mockUpWidth; // use a more descriptive name
    _scaleFactor = max(_horizontalScale, _verticalScale); // use min to ensure scale factor is not too large
  }

  static double get height => _height;
  static double get width => _width;
  static double get verticalScale => _verticalScale;
  static double get horizontalScale => _horizontalScale;
  static double get scaleFactor => _scaleFactor;
}