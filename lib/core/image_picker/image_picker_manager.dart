import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerManager {
static ImagePickerManager? _instance;
static ImagePickerManager get instance => _instance ??= ImagePickerManager();
final ImagePicker _picker = ImagePicker();
   Future<XFile?> getImageFromGallery() async {
    var deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (deviceInfo.version.sdkInt <= 32 && Platform.isAndroid) {
      var permission = await Permission.storage.request();
      if (permission == PermissionStatus.granted ||
          permission == PermissionStatus.limited) {
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        return image;
      }
    } else {
      var permission = await Permission.photos.request();
      if (permission == PermissionStatus.granted ||
          permission == PermissionStatus.limited) {
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        return image;
      }
    }
    return null;
  }
}