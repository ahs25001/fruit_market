import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/auth/data/models/user_model.dart';

class FirebaseFirestoreManager {
  static FirebaseFirestoreManager? _instance;

  static FirebaseFirestoreManager get instance {
    _instance ??= FirebaseFirestoreManager();
    return _instance!;
  }

  Future<UserModel> getUser(String id) async {
    var doc =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    return UserModel.fromJson(doc.data()!);
  }

  Future<void> addUser(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel.id)
        .set(userModel.toJson());
  }

  Future<void> addSubcategory(SubCategoryModel subcategory) async {
    var doc = FirebaseFirestore.instance.collection('Subcategories').doc();

    subcategory.id = doc.id;
    await doc.set(subcategory.toJson());
  }
}
