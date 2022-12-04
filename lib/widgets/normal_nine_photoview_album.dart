import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:jl_photo_view/jl_photo_view.dart';
import 'package:jiji_modelcard_maker/common/global.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
class NormalNinePhotoViewAlbum extends StatefulWidget {
  @override
  _NormalNinePhotoViewAlbumState createState() => _NormalNinePhotoViewAlbumState();
}

class _NormalNinePhotoViewAlbumState extends State<NormalNinePhotoViewAlbum> with TickerProviderStateMixin{
  late List<Widget> _tiles;
  late AnimationController _entranceController;
  late Duration _reorderAnimationDuration;
  bool _isLongPress = false;
  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
        value: 1.0, vsync: this, duration: Duration(milliseconds: 100));
    _tiles = <Widget>[
      containerWithPictureNum('1'),
      containerWithPictureNum('2'),
      containerWithPictureNum('3'),
      containerWithPictureNum('1'),
      containerWithPictureNum('2'),
      containerWithPictureNum('3'),
      containerWithPictureNum('1'),
      containerWithPictureNum('2'),
      containerWithPictureNum('3'),

    ];

  }

  @override
  Widget build(BuildContext context) {
    var flow = Flow(
      delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
      children:_tiles,
    );

    var center = Center(
      //sAxisAlignment: CrossAxisAlignment.center,
      child: Container(
        color: Colors.grey,
        child: GestureDetector(
          child: flow,
          onTapDown: (TapDownDetails details) {
            print(details.globalPosition);
            print(details.localPosition);
            print(_tiles.length);
            _tiles.removeLast();
            print(_tiles.length);
            _tiles.add(containerWithPictureNum('3'));
            print(_tiles.length);
            _isLongPress = _isLongPress;
            print(_tiles);
            setState(() {

            });
          },
        ),
      ),
    );

    var longPressView = Center(
      // crossAxisAlignment: CrossAxisAlignment.center,
      child: Container(
        color: Colors.grey,
        child: GestureDetector(
          child: LongPressDraggable(child: _tiles[0],
              feedback: FadeTransition(
                opacity: _entranceController,
                child: Opacity(
                  opacity: 0.2,
                  child: context.widget,
                ),
              )
          ),
          onTapDown: (TapDownDetails details) {
            print(details.globalPosition);
            print(details.localPosition);
            _tiles.removeLast();
            _tiles.add(containerWithPictureNum('3'));
            print(_tiles);
            _isLongPress = _isLongPress;
            setState(() {
              _isLongPress = !_isLongPress;
            });
          },
        ),
      ),
    );
    return Scaffold(appBar: new AppBar(title: new Text("测试"),),
      body: center,
    );
  }



  Widget containerWithPictureNum(String num) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      height: screenHeight / 4 + 5,
      width: screenWidth / 4,
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

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = screenWidth/8-10;
    var y = 20.0;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w;
      } else {
        x = screenWidth/8-10;
        y += context.getChildSize(i)!.height;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width ;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return Size(screenWidth, screenHeight);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}