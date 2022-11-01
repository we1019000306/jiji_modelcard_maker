import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jiji_modelcard_maker/common/global.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:jiji_modelcard_maker/widgets/normal_nine_photoview_album.dart';
import 'package:jiji_modelcard_maker/widgets/photoview_move.dart';
import 'wrap_example.dart';
import 'package:provider/provider.dart';
import 'package:jiji_modelcard_maker/common/jijimodel_photo_view_album.dart';

class Custom1 extends StatefulWidget {
  Custom1({Key? key}) : super(key: key);

  @override
  State<Custom1> createState() => _Custom1State();
}

class _Custom1State extends State<Custom1> {
  List imgPathList = [];
  final controller = MultiImagePickerController(
      maxImages: 12, allowedImageTypes: const ['jpg', 'jpeg', 'png']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom 1'),
      ),
      body: Column(
        children: [
          MultiImagePickerView(
            controller: controller,
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 170,
                childAspectRatio: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0),
            initialContainerBuilder: (context, pickerCallback) {
              return SizedBox(
                height: 500,
                width: screenWidth,
                child: Center(
                  child: ElevatedButton(
                      child: const Text('Add Images'),
                      onPressed: () {
                        pickerCallback();
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.resolveWith<double>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)
                                  ||  states.contains(MaterialState.disabled)) {
                                return 0;
                              }
                              return 10;
                            },
                          )
                      )
                  ),
                ),
              );
            },
            itemBuilder: (context, file, deleteCallback) {
              imgPathList.add(file.path);
              print(imgPathList);
              return ImageCard(file: file, deleteCallback: deleteCallback);
            },
            addMoreBuilder: (context, pickerCallback) {
              return SizedBox(
                height: 300,
                width: 300,
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black : Colors.white,
                      shape: CircleBorder(),
                    ),
                    child:  Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black : Colors.white,
                        size: 30,
                      ),
                    ),
                    onPressed: () {
                      pickerCallback();
                    },
                  ),
                ),
              );
            },
            onChange: (list) {
              // print('got the list');
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Provider.of<JiJiModelPhotoViewAlbum>(context, listen: false);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NormalNinePhotoViewAlbum(
                      //imgPathList: imgPathList,
                    );
                  },
                ),
              );
            },
            child: Text('jumpToNextView'),
            style: ButtonStyle(
              //foregroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor : MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                    }
                    return Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black : Colors.white; // Use the component's default.
                  }
              ),
            ),

          ),
        ],
      )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, required this.file, required this.deleteCallback})
      : super(key: key);

  final ImageFile file;
  final Function(ImageFile file) deleteCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(0.0),
          child: !file.hasPath
              ? Image.memory(
                  file.bytes!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('No Preview'));
                  },
                )
              : Image.file(
                  File(file.path!),
                  fit: BoxFit.cover,
                ),
        ),
          InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(0.0),

            child: InkWell(
            excludeFromSemantics: true,
            onLongPress: () {},
            child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 20,
                )),
            onTap: () {
              deleteCallback(file);
            },
          ),
        ),
      ],
    );
  }
}


