part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  getSubcategoriesLoading,
  getSubcategoriesSuccess,
  addProductToFavoriteSuccess,
  changeQuntityLoading,
  changeQuntitySuccess,
  removeProductFromFavoriteSuccess,
  error
}

@immutable
// ignore: must_be_immutable
class HomeState {
  HomeStatus? status;
  int? currentPage;
  String? massage;
  int? currentTab;
  List<SubCategoryModel?>? fruitSubCategories;
  List<SubCategoryModel?>? vegetablesSubCategories;
  List<SubCategoryModel?>? dryFruitsSubCategories;
  List<FavoriteModel>? favoriteProducts;
  List<String>? favoriteProductsIds;
  CartModel? cartModel;
  HomeState(
      {this.status,
      this.currentTab,
      this.currentPage,
      this.cartModel,
      this.favoriteProductsIds,
      this.favoriteProducts,
      this.fruitSubCategories,
      this.dryFruitsSubCategories,
      this.vegetablesSubCategories,
      this.massage});

  HomeState copyWith(
      {HomeStatus? status,
      int? currentPage,
      int? currentTab,
      CartModel? cartModel,
      List<FavoriteModel>? favoriteProducts,
      List<String>? favoriteProductsIds,
      String? massage,
      List<SubCategoryModel?>? fruitSubCategories,
      List<SubCategoryModel?>? vegetablesSubCategories,
      List<SubCategoryModel?>? dryFruitsSubCategories}) {
    return HomeState(
        cartModel: cartModel ?? this.cartModel,
        currentTab: currentTab ?? this.currentTab,
        massage: massage ?? this.massage,
        status: status ?? this.status,
        favoriteProducts: favoriteProducts ?? this.favoriteProducts,
        favoriteProductsIds: favoriteProductsIds ?? this.favoriteProductsIds,
        fruitSubCategories: fruitSubCategories ?? this.fruitSubCategories,
        vegetablesSubCategories:
            vegetablesSubCategories ?? this.vegetablesSubCategories,
        dryFruitsSubCategories:
            dryFruitsSubCategories ?? this.dryFruitsSubCategories,
        currentPage: currentPage ?? this.currentPage);
  }
}

// ignore: must_be_immutable
final class HomeInitial extends HomeState {
  HomeInitial()
      : super(
            status: HomeStatus.initial,
            currentPage: 1,
            currentTab: 0,
            favoriteProducts: [],
            favoriteProductsIds: []);
}
