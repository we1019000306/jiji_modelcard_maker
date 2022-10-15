import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';
import 'package:jl_photo_view/jl_photo_view.dart';
import 'package:jiji_modelcard_maker/common/global.dart';
import 'package:image/image.dart';

class WrapExample extends StatefulWidget {
  @override
  _WrapExampleState createState() => _WrapExampleState();
  var img1 = AssetImage("assets/1.png");
  
}

class _WrapExampleState extends State<WrapExample> {
  final double _iconSize = 90;
  late List<Widget> _tiles;
  @override
  void initState() {
    super.initState();
    _tiles = <Widget>[

      containerWithPictureNum('1'),
      containerWithPictureNum('2'),
      // containerWithPictureNum('3'),
      // containerWithPictureNum('4'),
      // containerWithPictureNum('1'),
      // containerWithPictureNum('2'),
      // containerWithPictureNum('3'),
      // containerWithPictureNum('4'),
      // containerWithPictureNum('1'),

    ];
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _tiles.removeAt(oldIndex);
        _tiles.insert(newIndex, row);

      });
    }

    var wrap = ReorderableWrap(
      spacing: 0.0,
      runSpacing: 0.0,
      padding: const EdgeInsets.all(10),
      maxMainAxisCount: 3,
      minMainAxisCount: 3,
      children: _tiles,
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
      onReorderStarted: (int index) {
        //this callback is optional
        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
      }
    );

    var center = Center(
      // crossAxisAlignment: CrossAxisAlignment.center,
      child: Container(
        color: Colors.white,
        child: wrap,
        // ButtonBar(
        //   alignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //     IconButton(
        //       iconSize: 50,
        //       icon: Icon(Icons.add_circle),
        //       color: Colors.deepOrange,
        //       padding: const EdgeInsets.all(0.0),
        //       onPressed: () {
        //         var newTile = Icon(Icons.filter_9_plus, size: _iconSize);
        //         setState(() {
        //           _tiles.add(newTile);
        //         });
        //       },
        //     ),
        //     IconButton(
        //       iconSize: 50,
        //       icon: Icon(Icons.remove_circle),
        //       color: Colors.teal,
        //       padding: const EdgeInsets.all(0.0),
        //       onPressed: () {
        //         setState(() {
        //           _tiles.removeAt(0);
        //         });
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
    return new Scaffold(appBar: new AppBar(title: new Text("测试"),),
      body: center,
    );


  }
  Widget containerWithPictureNum(String num) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
      height: screenHeight / 6,
      width: screenWidth / 6,
      child: ClipRect(
        child: JLPhotoView(
          imageProvider: AssetImage("assets/$num.png"),
          maxScale: JLPhotoViewComputedScale.covered * 2.0,
          minScale: JLPhotoViewComputedScale.contained * 0.8,
          initialScale: JLPhotoViewComputedScale.covered,
          enablePanAlways: true,
          enableRotation: true,
        ),
      ),
    );
  }

}
