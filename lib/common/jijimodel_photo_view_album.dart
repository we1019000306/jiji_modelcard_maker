import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jiji_modelcard_maker/common/jijimodel_photo_view_item.dart';

class JiJiModelPhotoViewAlbum with ChangeNotifier, DiagnosticableTreeMixin {
   final Map<Key,JiJiModelPhotoViewItem>? _pvItemMap = {};

   void addPhotoViewItemWithKey (JiJiModelPhotoViewItem newItem, Key newKey) {
     _pvItemMap![newKey] = newItem;
   }

   void updatePhotoViewItemwithKey(JiJiModelPhotoViewItem newItem, Key newKey) {
     _pvItemMap!.update(newKey, (value) => newItem);
   }


   void removeItem(Key oldKey) {
     _pvItemMap!.remove(oldKey);
   }

   JiJiModelPhotoViewItem? currentItem(Key itemKey) {
     print(itemKey);
     return _pvItemMap!.containsKey(itemKey) ? _pvItemMap![itemKey] : null;
   }

   void clearAllItems(){
     _pvItemMap!.clear();
   }

}