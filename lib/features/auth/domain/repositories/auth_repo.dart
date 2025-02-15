abstract class AuthRepo {
  Future<void> loginWithGoogle();

  Future<void> loginWithFacebook();

  Future<void> completeInfo(
      {required String name, required String phone,required String id, required String address});
}
