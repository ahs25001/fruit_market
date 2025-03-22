import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/add_data/data/repositories/add_data_repo_impl.dart';
import 'package:fruit_market/features/add_data/domain/repositories/add_data_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_data_state.dart';

class AddDataCubit extends Cubit<AddDataState> {
  AddDataCubit() : super(AddDataInitial());

  static AddDataCubit get(context) => BlocProvider.of(context);
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController subcategoryNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nutritionController = TextEditingController();
  FocusNode productNameFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  FocusNode decorationFocusNode = FocusNode();
  FocusNode nutritionFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void saveSubcategory() async {
    emit(state.copyWith(statuse: AddDataStatuse.addSubcategoryLoading));
    AddDataRepo addDataRepo = AddDataRepoImpl();
    SubCategoryModel subCategoryModel = SubCategoryModel(
      categoryName: categoryNameController.text,
      name: subcategoryNameController.text,
      products: [],
    );
    var response = await addDataRepo.saveSubcategory(subCategoryModel);
    response.fold(
      (error) {
        emit(state.copyWith(
            statuse: AddDataStatuse.addSubcategoryError,
            massage: error.massage));
      },
      (r) {
        subcategoryNameController.clear();
        emit(state.copyWith(statuse: AddDataStatuse.addSubcategorySuccess));
      },
    );
  }

  void getSubcategories(String category, {bool refresh = false}) async {
    emit(state.copyWith(
        statuse: refresh
            ? AddDataStatuse.changeCategoryLoading
            : AddDataStatuse.getSubcategoriesLoading));
    AddDataRepo addDataRepo = AddDataRepoImpl();
    var response = await addDataRepo.getSubcategories(category);
    response.fold((error) {
      emit(state.copyWith(
          statuse: AddDataStatuse.getSubcategoriesError,
          massage: error.massage));
    }, (r) {
      emit(state.copyWith(
          statuse: refresh
              ? AddDataStatuse.changeCategorySuccess
              : AddDataStatuse.getSubcategoriesSuccess,
          subcategories: r));
    });
  }

  void pickImage() async {
    emit(state.copyWith(statuse: AddDataStatuse.pickeImageLoading));
    AddDataRepo addDataRepo = AddDataRepoImpl();
    var response = await addDataRepo.pickeImage();
    response.fold((error) {
      emit(state.copyWith(
          statuse: AddDataStatuse.pickeImageError, massage: error.massage));
    }, (r) {
      emit(state.copyWith(
          statuse: AddDataStatuse.pickeImageSuccess, productImage: r));
    });
  }

  void addProduct() async {
    emit(state.copyWith(statuse: AddDataStatuse.addProductLoading));
    AddDataRepo addDataRepo = AddDataRepoImpl();
    List<String> nutrition = nutritionController.text.split("\n");
    ProductModel product = ProductModel(
      name: productNameController.text,
      price: priceController.text,
      categoryName: categoryNameController.text,
      rating: 3.5,
      subCategoryName: subcategoryNameController.text,
      description: descriptionController.text,
      nutrition: nutrition,
    );
    File imageFile = File(state.productImage!.path);
    var response = await addDataRepo.addProduct(product, imageFile);
    response.fold((error) {
      emit(state.copyWith(
          statuse: AddDataStatuse.addProductError, massage: error.massage));
    }, (r) {
      emit(state.copyWith(statuse: AddDataStatuse.addProductSuccess));
    });
  }
}
