part of 'add_data_cubit.dart';

enum AddDataStatuse {
  initial,
  getSubcategoriesLoading,
  getSubcategoriesSuccess,
  getSubcategoriesError,
  addProductLoading,
  addProductSuccess,
  addProductError,
  addSubcategoryLoading,
  addSubcategorySuccess,
  addSubcategoryError,
  pickeImageLoading,
  pickeImageSuccess,
  pickeImageError,
  changeCategoryLoading,
  changeCategorySuccess
 
}

@immutable
// ignore: must_be_immutable
class AddDataState {
  String? massage;
  AddDataStatuse? statuse;
  List<SubCategoryModel>? subcategories;
  XFile? productImage;

  AddDataState(
      {this.statuse, this.massage, this.subcategories, this.productImage});
  AddDataState copyWith(
      {AddDataStatuse? statuse,
      XFile? productImage,
      String? massage,
      List<SubCategoryModel>? subcategories}) {
    return AddDataState(
        statuse: statuse ?? this.statuse,
        productImage: productImage ?? this.productImage,
        massage: massage ?? this.massage,
        subcategories: subcategories ?? this.subcategories);
  }
}

// ignore: must_be_immutable
final class AddDataInitial extends AddDataState {
  AddDataInitial() : super(statuse: AddDataStatuse.initial);
}
