import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Errors, List<SubCategoryModel>>> getSubCategories(
      String category) async {
    try {
      List<SubCategoryModel> subCategories =
          await firebaseFirestoreManager.getSubcategories(category);
      return Right(subCategories);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }
}
