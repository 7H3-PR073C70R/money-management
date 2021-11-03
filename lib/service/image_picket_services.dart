import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickImageService {
  final ImagePicker _picker = ImagePicker();
  ImageSource get imageSource => ImageSource.gallery;
  Future<File?>? selectImage(ImageSource source) async {
    final path = await _picker.pickImage(source: source);
    return path != null ? File(path.path) : null;
  }
}