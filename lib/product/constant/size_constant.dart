import 'package:flutter/material.dart';

class SizeConstant {
  BuildContext context;
  SizeConstant(this.context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
  late final double width;
  late final double height;

  double get height025 => height * 0.025;
  double get height019 => height * 0.019;
  double get height020 => height * 0.020;
  double get height027 => height * 0.027;
  double get height3 => height * 0.3;
  double get height7 => height * 0.07;
  double get height057 => height * 0.057;
  double get height035 => height * 0.035;
  double get height03 => height * 0.03;
  double get height01 => height * 0.01;
  double get height09 => height * 0.09;
  double get height45 => height * 0.45;
  double get height5 => height * 0.50;
  double get height11 => height * 0.11;
  double get height07 => height * 0.07;
  double get height1 => height * 0.1;

  double get width055 => width * 0.055;
  double get width05 => width * 0.05;
  double get width5 => width * 0.5;
  double get width06 => width * 0.06;
  double get width03 => width * 0.03;
  double get width035 => width * 0.035;
  double get width04 => width * 0.04;
  double get width9 => width * 0.9;
  double get width1 => width * 0.1;
  double get width4 => width * 0.4;
  double get width7 => width * 0.7;
  double get width01 => width * 0.01;
  double get width02 => width * 0.02;
  double get width15 => width * 0.15;
  double get width35 => width * 0.35;
  double get width85 => width * 0.85;
  double get width3 => width * 0.3;
}
