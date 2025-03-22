import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/firebase/firebase_firestore_manager.dart';
import 'package:fruit_market/core/image_picker/image_picker_manager.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/core/supabase/supabase_storage_manager.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/add_data/domain/repositories/add_data_repo.dart';
import 'package:image_picker/image_picker.dart';

class AddDataRepoImpl extends AddDataRepo {
  @override
  Future<Either<Errors, void>> saveSubcategory(
      SubCategoryModel subcategory) async {
    try {
      await FirebaseFirestoreManager.instance.addSubcategory(subcategory);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, List<SubCategoryModel>>> getSubcategories(String category) async {
    try {
      return Right(await firebaseFirestoreManager.getSubcategories(category));
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, XFile?>> pickeImage() async {
    try {
      return Right(await ImagePickerManager.instance.getImageFromGallery());
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, void>> addProduct(
      ProductModel product, File imageFile) async {
    try {
      String imageUrl = await SupabaseManager.uploadeImage(imageFile);
      product.image = imageUrl;
      await firebaseFirestoreManager.addProduct(product);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }
}
