import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jiji_modelcard_maker/jl_photo_view/jl_photo_view.dart';


class PhotoViewMove extends StatelessWidget {
  PhotoViewMove({
    Key? key,
    required this.imgPathList,
  }) : super(key: key);
  final List imgPathList;
  late double globlePositionX;
  late double globlePositionY;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(imgPathList.toString()),
          //Image
        ),
        body: Stack(
          alignment:Alignment.center,
          children: [
            Positioned(
              left: 20.0,
              width: 300,
              height: 300,
              child: ClipRect(
                child: PhotoView(
                  imageProvider: FileImage(File(imgPathList.first.toString())),
                  //imageProvider: const AssetImage("assets/1.png"),
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  initialScale: PhotoViewComputedScale.covered,
                  enableRotation: true,
                  enablePanAlways: true,

                ),
              ),
            ),
          ]
        // )
        // body: PhotoView.customChild(
        //       childSize: Size.square(150.0),
        //       wantKeepAlive: true,
        //       child: PhotoView(
        //         imageProvider: FileImage(File(imgPathList.first.toString())),
        //         //imageProvider: const AssetImage("assets/1.png"),
        //         maxScale: PhotoViewComputedScale.covered * 2.0,
        //         minScale: PhotoViewComputedScale.contained * 0.8,
        //         initialScale: PhotoViewComputedScale.covered,
        //         enableRotation: true,
        //         enablePanAlways: true,
        //
        //       ),
        // )
      )
    );
  }
}




