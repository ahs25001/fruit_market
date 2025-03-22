import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_market/core/models/product_model.dart';
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

  Future<List<SubCategoryModel>> getSubcategories(String category) async {
    var doc = await FirebaseFirestore.instance
        .collection('Subcategories')
        .where("categoryName", isEqualTo: category)
        .get();
    return doc.docs.map((e) => SubCategoryModel.fromJson(e.data())).toList();
  }

  Future<void> addProduct(ProductModel product) async {
    var productDoc = FirebaseFirestore.instance.collection('Products').doc();

    product.id = productDoc.id;
    await productDoc.set(product.toJson());
    QuerySnapshot<Map<String, dynamic>> subCategorySnapshot =
        await FirebaseFirestore.instance
            .collection("Subcategories")
            .where("name", isEqualTo: product.subCategoryName)
            .get();

    SubCategoryModel subcategory =
        SubCategoryModel.fromJson(subCategorySnapshot.docs.first.data());
    subcategory.products!.add(product);
    await FirebaseFirestore.instance
        .collection("Subcategories")
        .doc(subcategory.id)
        .update(subcategory.toJson());
  }
}
