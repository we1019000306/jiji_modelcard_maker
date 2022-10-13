
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JiJiModelPhotoViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  double photoViewRotation = 0.0;
  double deltaDx = 0.0;
  double deltaDy = 0.0;
  double photoViewScale = 0.0;

  void updatePhotoViewScale(double rotation,double dx,double dy,double scale){
    photoViewRotation = rotation;
    deltaDx = dx;
    deltaDy = dy;
    photoViewScale = scale;

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('photoViewRotation', photoViewRotation));
    //properties.add(DoubleProperty('photoViewScale', photoViewScale));
  }



}