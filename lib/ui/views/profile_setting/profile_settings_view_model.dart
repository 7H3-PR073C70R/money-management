import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.logger.dart';
import '../../../app/app.router.dart';
import '../../../model/user_model.dart';
import '../../../service/online_db_service.dart';
import '../../../service/shared_prefs.dart';
import '../../../service/user_service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../service/image_picket_services.dart';
import 'package:stacked/stacked.dart';

class ProfileSettingsViewModel extends BaseViewModel {
  final _pickImageService = PickImageService();
  final _userService = locator<UserService>();
  final _navigationService = NavigationService();
  final _sharedPrefs = locator<SharedPresService>();
  final _log = getLogger('ProfileSettingsViewModel');
  final _onlineDbService = OnlineDbService();

  User get user => _userService.user;
  File? _imageFile;
  File? get imagePath => _imageFile;

  void setImagePath(File? value) {
    _imageFile = value;
    notifyListeners();
  }

  void pickImage() async {
    final path =
        await _pickImageService.selectImage(_pickImageService.imageSource);
    setImagePath(path);
  }

  void gotoChangePasswordView() {
    _navigationService.navigateTo(Routes.changePasswordView);
  }

  void updateUserData({String? fname, String? lname, String? email}) async {
    try {
      final profileUrl = await getImageUrl();
      final userToSave = user.copyWith(
          fname: fname, lname: lname, email: email, profileUrl: profileUrl);
      await runBusyFuture(_onlineDbService.updateUserInfo(userToSave));
      _sharedPrefs.saveUser(userToSave);
      _navigationService.popRepeated(1);
    } catch (e) {
      _log.i(e);
    }
  }

  Future<String?> getImageUrl() async {
    if (_imageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profileImage')
          .child('${user.id}.jpg');
      await ref.putFile(_imageFile!);
      final url = await ref.getDownloadURL();
      _log.i(url);
      return url;
    }
    return null;
  }
}
