
import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';

abstract class AddDataRepo {
  Future<Either<Errors, void>> saveSubcategory(SubCategoryModel subcategory);
}
