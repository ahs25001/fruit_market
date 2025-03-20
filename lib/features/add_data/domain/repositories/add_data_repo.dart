
import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class AddDataRepo {
  Future<Either<Errors, void>> saveSubcategory(SubCategoryModel subcategory);
  Future<Either<Errors, List<SubCategoryModel>>> getSubcategories();
  Future<Either<Errors, XFile?>> pickeImage();
}
