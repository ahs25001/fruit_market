import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/home/data/repositories/home_repo_impl.dart';
import 'package:fruit_market/features/home/domain/repositories/home_repo.dart';
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  void changePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void getSubcategories() async {
    emit(state.copyWith(status: HomeStatus.loading));
    HomeRepo homeRepo = HomeRepoImpl();
    List<String> categories = ["Vegetables", "Fruits", "Dry Fruits"];
    List<SubCategoryModel>? fruitSubCategories;
    List<SubCategoryModel>? vegetablesSubCategories;
    List<SubCategoryModel>? dryFruitsSubCategories;
    for (var category in categories) {
      var response = await homeRepo.getSubCategories(category);
      response.fold(
        (error) {
          print(error.massage);
          emit(
            state.copyWith(status: HomeStatus.error, massage: error.massage));
        },(subcategries) {
          if (category == "Vegetables") {
            vegetablesSubCategories = subcategries;
          } else if (category == "Fruits") {
            fruitSubCategories = subcategries;
          } else if (category == "Dry Fruits") {
            dryFruitsSubCategories = subcategries;
          }
        },
      );
    }
    if (state.status != HomeStatus.error) {
      print("Sucessssss");
      emit(state.copyWith(
          status: HomeStatus.success,
          dryFruitsSubCategories: dryFruitsSubCategories,
          fruitSubCategories: fruitSubCategories,
          vegetablesSubCategories: vegetablesSubCategories));
    }
  }

  void changeTab(int newTabIndex) {
    emit(state.copyWith(currentTab: newTabIndex));
  }

  HomeCubit() : super(HomeInitial());
}
