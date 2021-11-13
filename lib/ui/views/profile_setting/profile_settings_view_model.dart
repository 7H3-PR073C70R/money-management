import 'dart:io';
import '../../../service/image_picket_services.dart';
import 'package:stacked/stacked.dart';

class ProfileSettingsViewModel extends BaseViewModel {
  final _pickImageService = PickImageService();
  File? _imagePath;
  File? get imagePath => _imagePath;

  void setImagePath(File? value) {
    _imagePath = value;
    notifyListeners();
  }

  void pickImage() async {
    final path = await _pickImageService.selectImage(_pickImageService.imageSource);
    setImagePath(path);
  }
}