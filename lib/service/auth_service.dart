import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user_service.dart';
import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../constants/enums.dart';
import '../model/user_model.dart' as app_user;
import 'shared_prefs.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _sharedPrefsService = locator<SharedPresService>();
  final _userService = locator<UserService>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final log = getLogger('Auth');

  Future<void> signUpWithCred(
      {required String password,
      required String email,
      required String firstName,
      required String lastName}) async {
    try {
      UserCredential authCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      log.i(authCredential.user!.uid);
      await authCredential.user!.sendEmailVerification();

      app_user.User user = app_user.User(
          email: email,
          lname: lastName,
          fname: firstName,
          profileUrl:
              'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg');

      await _saveUserOnlineAndLocally(
          userid: authCredential.user!.uid, user: user);
    } catch (error) {
      log.i(error);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential).then((registeredUser) async {
        app_user.User user = app_user.User(
            email: registeredUser.user!.email,
            fname: registeredUser.user!.displayName!.split(' ')[0],
            lname: registeredUser.user!.displayName!.split(' ')[1],
            profileUrl: registeredUser.user!.photoURL);

        final userId = _userService.user.id;
        final registeredUserId = registeredUser.user!.uid;

        if (userId != registeredUserId) {
          await _saveUserOnlineAndLocally(
              userid: registeredUser.user!.uid, user: user);
        }
      });
    } catch (e) {
      log.i(e);
      rethrow;
    }
  }

  Future<void> signInWithCred(
      {required String email, required String password}) async {
    try {
      final authCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(authCred.user!.uid)
          .get();

      _saveUserLocally(app_user.User.fromJson(user.data()!));

      if (!authCred.user!.emailVerified) {
        throw 'User is not verified';
      }
    } catch (error) {
      log.i(error);
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      log.i(error);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
        return;
      }
      await _auth.signOut();
    } catch (error) {
      log.i(error);
      rethrow;
    }
  }

  Future<void> _saveUserOnlineAndLocally(
      {required String userid, required app_user.User user}) async {
    final userToSave = user.copyWith(currency: Currencies.ngn, id: userid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .set(userToSave.toJson());

    await _saveUserLocally(userToSave);
  }

  Future<void> _saveUserLocally(app_user.User user) async {
    await _sharedPrefsService.saveUser(user);
  }

  Future<void> sendConfirmationEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(String password) async {
    try {
      _auth.currentUser!.updatePassword(password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      await _auth.currentUser!.updateEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  bool get isUserLoggedIn => _auth.currentUser != null;
  bool get isUserVerified => _auth.currentUser!.emailVerified;
}
