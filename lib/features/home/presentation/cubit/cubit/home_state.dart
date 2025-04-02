part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  getSubcategoriesLoading,
  getSubcategoriesSuccess,
  addProductToFavoriteSuccess,
  addProductToCartSuccess,
  changeQuntityLoading,
  changeQuntitySuccess,
  removeProductFromFavoriteSuccess,
  removeProductFromCartSuccess,
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
  List<CartModel>? cartProducts;
  List<String>? cartIds;
  HomeState(
      {this.status,
      this.currentTab,
      this.currentPage,
      this.cartIds,
      this.cartProducts,
      this.favoriteProductsIds,
      this.favoriteProducts,
      this.fruitSubCategories,
      this.dryFruitsSubCategories,
      this.vegetablesSubCategories,
      this.massage});

  HomeState copyWith(
      {HomeStatus? status,
      int? currentPage,
      List<String>? cartIds,
      int? currentTab,
      List<CartModel>? cartProducts,
      List<FavoriteModel>? favoriteProducts,
      List<String>? favoriteProductsIds,
      String? massage,
      List<SubCategoryModel?>? fruitSubCategories,
      List<SubCategoryModel?>? vegetablesSubCategories,
      List<SubCategoryModel?>? dryFruitsSubCategories}) {
    return HomeState(
        cartIds: cartIds ?? this.cartIds,
        cartProducts: cartProducts ?? this.cartProducts,
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
