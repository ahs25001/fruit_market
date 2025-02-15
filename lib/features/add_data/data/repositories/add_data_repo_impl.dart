import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/firebase/firebase_firestore_manager.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/add_data/domain/repositories/add_data_repo.dart';

class AddDataRepoImpl extends AddDataRepo {
  @override
  Future<Either<Errors, void>> saveSubcategory(SubCategoryModel subcategory) async{
    try {
      await FirebaseFirestoreManager.instance.addSubcategory(subcategory);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }
}
