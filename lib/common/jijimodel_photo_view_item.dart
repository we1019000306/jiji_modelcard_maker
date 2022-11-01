import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JiJiModelPhotoViewItem with ChangeNotifier, DiagnosticableTreeMixin {
  late Key key;
  double _currentScale = 0.0;
  double _currentRotation = 0.0;
  Offset _currentPosition = const Offset(0.0, 0.0);

  double get currentScale{
   return _currentScale;
  }

  set currentScale(double newScale) {
   _currentScale = newScale;
   print('Item....$_currentScale');
   notifyListeners();
  }

  double get currentRotation{
   return _currentRotation;
  }

  set currentRotation(double newRotation) {
   _currentRotation = newRotation;
   print('Item....$_currentRotation');
   notifyListeners();
  }

  Offset get currentPosition{
    return _currentPosition;
  }

  set currentPosition(Offset newPosition) {
    _currentPosition = newPosition;
    print('Item....$_currentPosition');
    notifyListeners();
  }
}