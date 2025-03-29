import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';

abstract class HomeRepo{
  Future<Either<Errors,List<SubCategoryModel>>>getSubCategories(String category);
}