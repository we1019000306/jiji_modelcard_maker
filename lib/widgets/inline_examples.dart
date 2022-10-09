import 'package:flutter/material.dart';
import 'package:jl_photo_view/jl_photo_view.dart';
import 'package:jiji_modelcard_maker/common/global.dart';

class InlineExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inline usage '),
      ),
      body: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 20.0,
              ),
              height: screenHeight / 6,
              width: screenWidth / 6,
              child: ClipRect(
                child: JLPhotoView(
                  imageProvider: const AssetImage("assets/1.png"),
                  maxScale: JLPhotoViewComputedScale.covered * 2.0,
                  minScale: JLPhotoViewComputedScale.contained * 0.8,
                  initialScale: JLPhotoViewComputedScale.covered,
                ),
              ),
            )
    );
  }
}
