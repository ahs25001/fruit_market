
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    emit(state.copyWith(statuse: AddDataStatuse.loading));
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
            statuse: AddDataStatuse.error, massage: error.massage));
      },
      (r) {
        subcategoryNameController.clear();
        emit(state.copyWith(statuse: AddDataStatuse.success));
      },
    );
  }
void getSubcategories()async{
  emit(state.copyWith(statuse: AddDataStatuse.loading));
  AddDataRepo addDataRepo = AddDataRepoImpl();
  var response = await addDataRepo.getSubcategories();
  response.fold((error) {
    emit(state.copyWith(statuse: AddDataStatuse.error, massage: error.massage));
  }, (r) {
    emit(state.copyWith(statuse: AddDataStatuse.success, subcategories: r));
  });
}
void pickImage()async{
  emit(state.copyWith(statuse: AddDataStatuse.loading));
  AddDataRepo addDataRepo = AddDataRepoImpl();
  var response = await addDataRepo.pickeImage();
  response.fold((error) {
    emit(state.copyWith(statuse: AddDataStatuse.error, massage: error.massage));
  }, (r) {
    emit(state.copyWith(statuse: AddDataStatuse.success, productImage: r));
  });}
}
