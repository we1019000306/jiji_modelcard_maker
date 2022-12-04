import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiji_modelcard_maker/common/global.dart';
import 'package:jl_photo_view/jl_photo_view.dart';

class DragDemoPage extends StatefulWidget {
  @override
  _DragDemoPageState createState() => _DragDemoPageState();
}

class _DragDemoPageState extends State {
  List<JLPhotoView> _viewList =[];
  ScrollController _scrollController = new ScrollController();
  int _lastTargetIndex = 0;
  GlobalKey<_JLPhotoViewWidgetState> jlphotoviewKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addViewToList(9);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag"),
      ),
      body: Container(
        color: Colors.grey,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("长按图标拖动调整排序"),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                controller: _scrollController,
                children: _viewList
                    .asMap()
                    .keys
                    .map((index) => _buildDraggableItem(index))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableItem(int index) {
    // TODO LongPressDraggable 继承自 Draggable，因此用法和 Draggable 完全一样，
    // TODO 唯一的区别就是 LongPressDraggable 触发拖动的方式是长按，而 Draggable 触发拖动的方式是按下
    return LongPressDraggable(
      // TODO 传递给 DragTarget 的数据
      data: index,
      /*// 开始拖动时回调
      onDragStarted: () {print('---1---onDragStarted');},
      // 拖动结束时回调
      onDragEnd: (DraggableDetails details) {print('---2---onDragEnd:$details');},
      // 未拖动到DragTarget控件上时回调
      onDraggableCanceled: (Velocity velocity, Offset offset) {print('---3---onDraggableCanceled velocity:$velocity,offset:$offset');},
      // 拖动到DragTarget控件上时回调
      onDragCompleted: () {print('---4---onDragCompleted');},*/
      // TODO 拖动时跟随移动的 widget
      //feedback: _buildItem(_dataList[index], isDragging: true,isLongPressing: _islongPressing),
      // feedback: _viewList[index],
       feedback: JLPhotoViewWidget(jlphotoviewKey,_viewList[index]) ,

      // TODO 用 DragTarget 包裹，表示可作为拖动的最终目标，<int>表示传递数据 data 的类型
      child: DragTarget<int>(
        builder: (context, data, rejects) {
          return _buildItem(_viewList[index]);
        },
        // 手指拖着一个widget从另一个widget头上滑走时会调用
        onLeave: (data) {
          // print('---$data is Leaving item $index---');
        },
        // 松手时，是否需要将数据给这个widget，因为需要在拖动时改变UI，所以在这里直接修改数据源
        onWillAccept: (data) {
          // print('---(target)$index will accept item (drag)$data---');
          // TODO 跨度超过一行数量，就是判定可以上/下滑动
          if ((index - _lastTargetIndex).abs() >= 3) {
            _scrollController.jumpTo(((index / 3).ceil() - 1) * 400.0); // 80为item高度
            setState(() {
              _lastTargetIndex = index;
            });
          }
          return true;
        },
        // 松手时，如果onWillAccept返回true，那么就会调用
        onAccept: (data) {
          // TODO 松手时交换数据并刷新 UI
          setState(() {
            // final dragTemp = _dataList[index];
            // final targetTemp = _dataList[data];

            if(_viewList.isNotEmpty) {
              final jlphotoDragTemp = _viewList[index];
              final jlphotoTargetTemp = _viewList[data];
              _viewList!.replaceRange(data, data+1, [jlphotoDragTemp]);
              _viewList!.replaceRange(index, index+1, [jlphotoTargetTemp]);
              print('--------_viewList--------$_viewList');
            }
            // _dataList.replaceRange(data, data + 1, [dragTemp]);
            // _dataList.replaceRange(index, index + 1, [targetTemp]);

            // JLPhotoView phv = _viewList[index];
            // print(phv.controller!.rotation);
            // print(phv.controller!.position);
            // print(phv.controller!.scale);
          });
        },
      ),

    );
  }

  Widget _buildItem(JLPhotoView phv) {

    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: screenWidth*1.1/7,
            height: screenHeight*1.45/7,
            color: Colors.grey,
            child: phv,

          ),
           Container()
        ],
      ),
    );
  }
  void addViewToList(int num) {
    // _viewList.clear();
    for (var n = 0 ;n < num ; n++){
      JLPhotoView photoView = JLPhotoView(
        imageProvider: AssetImage("assets/${n+1}.png"),
        maxScale: JLPhotoViewComputedScale.covered * 2.0,
        minScale: JLPhotoViewComputedScale.contained * 0.8,
        initialScale: JLPhotoViewComputedScale.contained,
        enablePanAlways: true,
        enableRotation: true,
        wantKeepAlive: true,
      );
      _viewList.add(photoView);
    }
    print(_viewList);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


//封装的widget
class JLPhotoViewWidget extends StatefulWidget {
  final Key key;
  final JLPhotoView photoView;
  const JLPhotoViewWidget(this.key,this.photoView);

  @override
  _JLPhotoViewWidgetState createState() => _JLPhotoViewWidgetState();

}

class _JLPhotoViewWidgetState extends State<JLPhotoViewWidget> {
  @override
  Widget build(BuildContext context) {
    // print(widget.imgUrl);
    print(widget.photoView);
    print(widget.photoView.controller);
    print(widget.photoView.controller?.rotation);
    print(widget.photoView.controller?.scale);
    print(widget.photoView.controller?.position);
    return Container(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey,

                  child: Transform(
                    transform: Matrix4.rotationZ(widget.photoView.controller != null ?  widget.photoView.controller!.rotation : 0.2),
                    child: widget.photoView,
                    // JLPhotoView(
                    //   imageProvider: AssetImage("assets/${widget.imgUrl}.png"),
                    //   maxScale: JLPhotoViewComputedScale.covered * 2.0,
                    //   minScale: JLPhotoViewComputedScale.contained * 0.8,
                    //   initialScale: JLPhotoViewComputedScale.contained,
                    //   enablePanAlways: true,
                    //   enableRotation: true,
                    //   wantKeepAlive: false,
                    // ),
                  )
                )

              ]
            )
    );

  }

}
