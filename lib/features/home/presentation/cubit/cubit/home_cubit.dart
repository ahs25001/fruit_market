import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/home/data/models/favorite_model.dart';
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
    emit(state.copyWith(status: HomeStatus.getSubcategoriesLoading));
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
        },
        (subcategries) {
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
          status: HomeStatus.getSubcategoriesSuccess,
          dryFruitsSubCategories: dryFruitsSubCategories,
          fruitSubCategories: fruitSubCategories,
          vegetablesSubCategories: vegetablesSubCategories));
    }
  }

  void changeTab(int newTabIndex) {
    emit(state.copyWith(currentTab: newTabIndex));
  }

  void getFavoriteList() {
    HomeRepo homeRepo = HomeRepoImpl();
    homeRepo.getFavoriteList().listen(
      (event) {
        List<FavoriteModel> favoriteProducts = event.docs.map(
          (e) {
            return FavoriteModel.fromJson(e.data());
          },
        ).toList();

        List<String> favoriteProductsIds = favoriteProducts
            .map(
              (e) => e.id ?? "",
            )
            .toList();
        List<FavoriteModel> sortedFavoriteProducts = [];
        List<String>categories=["Fruits","Vegetables","Dry Fruits"];
        int index=0;
        for (var categoriy in categories) {
          for(var product in favoriteProducts){
            if(product.categoryName==categoriy){
              sortedFavoriteProducts.insert(index,product);
              index++;
            }
          }
        }
        emit(state.copyWith(
            favoriteProducts: sortedFavoriteProducts,
            favoriteProductsIds: favoriteProductsIds));
      },
    );
  }

  void addProductToFavorite(ProductModel? productModel) async {
    HomeRepo homeRepo = HomeRepoImpl();
    var response = await homeRepo.addProductToFavoriteList(productModel);
    response.fold(
      (l) => emit(state.copyWith(status: HomeStatus.error, massage: l.massage)),
      (r) =>
          emit(state.copyWith(status: HomeStatus.addProductToFavoriteSuccess)),
    );
  }

  void removeProductFromFavorite(String modelId) async {
    HomeRepo homeRepo = HomeRepoImpl();
    var response = await homeRepo.removeProductFromFavoriteList(modelId);
    response.fold(
      (l) => emit(state.copyWith(status: HomeStatus.error, massage: l.massage)),
      (r) => emit(
          state.copyWith(status: HomeStatus.removeProductFromFavoriteSuccess)),
    );
  }

  void incQuantityInFavorite(FavoriteModel productModel) async {
    emit(state.copyWith(status: HomeStatus.changeQuntityLoading));
    productModel.quntitiy = (productModel.quntitiy ?? 1) + 1;
    HomeRepo homeRepo = HomeRepoImpl();
    var response = await homeRepo.updateFavoriteProduct(productModel);
    response.fold(
      (error) {
        emit(state.copyWith(status: HomeStatus.error, massage: error.massage));
      },
      (r) {
        emit(state.copyWith(status: HomeStatus.changeQuntitySuccess));
      },
    );
  }

  void decQuantityInFavorite(FavoriteModel productModel) async {
    if ((productModel.quntitiy ?? 1) > 1) {
      emit(state.copyWith(status: HomeStatus.changeQuntityLoading));
      productModel.quntitiy = (productModel.quntitiy ?? 1) - 1;
      HomeRepo homeRepo = HomeRepoImpl();
      var response = await homeRepo.updateFavoriteProduct(productModel);
      response.fold(
        (error) {
          emit(
              state.copyWith(status: HomeStatus.error, massage: error.massage));
        },
        (r) {
          emit(state.copyWith(status: HomeStatus.changeQuntitySuccess));
        },
      );
    }
  }

  HomeCubit() : super(HomeInitial()) {
    getFavoriteList();
  }
}
