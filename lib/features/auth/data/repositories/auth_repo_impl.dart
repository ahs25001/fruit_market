import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/auth/data/models/user_model.dart';

import '../../domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<void> completeInfo(
      {required String name,
      required String id,
      required String phone,
      required String address}) async {
    await firebaseFirestoreManager.addUser(UserModel(
        name: name,
        phone: phone,
        address: address,
        id: id,
        email: FirebaseAuth.instance.currentUser!.email ?? "eeeee"));
  }

  @override
  Future<void> loginWithFacebook() async {
    await firebaseAuthManager.loginWithFacebook();
  }

  @override
  Future<void> loginWithGoogle() async {
    await firebaseAuthManager.loginWithGoogle();
  }
}
