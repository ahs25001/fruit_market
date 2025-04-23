import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/home/data/models/favorite_model.dart';
import 'package:fruit_market/features/home/data/repositories/home_repo_impl.dart';
import 'package:fruit_market/features/home/domain/repositories/home_repo.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  void changePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void getCurrentUser() {
    emit(state.copyWith(status: HomeStatus.getUserLoading));

    HomeRepo homeRepo = HomeRepoImpl();
    homeRepo.getUser(FirebaseAuth.instance.currentUser!.uid).then((response) {
      response.fold(
        (l) =>
            emit(state.copyWith(status: HomeStatus.error, massage: l.massage)),
        (user) {
          currentUser = user;
          emit(state.copyWith(status: HomeStatus.getUserSuccess));
        },
      );
    });
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
        List<String> categories = ["Fruits", "Vegetables", "Dry Fruits"];
        int index = 0;
        for (var categoriy in categories) {
          for (var product in favoriteProducts) {
            if (product.categoryName == categoriy) {
              sortedFavoriteProducts.insert(index, product);
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

  void addProductToFavorite(ProductModel? productModel,String subcategoryId) async {
    HomeRepo homeRepo = HomeRepoImpl();
    var response = await homeRepo.addProductToFavoriteList(productModel,subcategoryId);
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

  void getCart() {
    HomeRepo homeRepo = HomeRepoImpl();
    homeRepo.getCart().listen(
      (event) {
        List<CartModel> productsInCart = event.docs.map(
          (e) {
            return CartModel.fromJson(e.data());
          },
        ).toList();

        List<CartModel> sortedCartProducts = [];
        List<String> categories = ["Fruits", "Vegetables", "Dry Fruits"];
        int index = 0;
        for (var categoriy in categories) {
          for (var product in productsInCart) {
            if (product.categoryName == categoriy) {
              sortedCartProducts.insert(index, product);
              index++;
            }
          }
        }
        List<String> cartIds = sortedCartProducts
            .map(
              (e) => e.id ?? "",
            )
            .toList();
        num totalPrice = 0;
        for (var product in sortedCartProducts) {
          totalPrice +=
              num.parse(product.price ?? "0") * (product.quntitiy ?? 1);
        }
        emit(state.copyWith(
          cartIds: cartIds,
          totalPrice: totalPrice,
          cartProducts: sortedCartProducts,
        ));
      },
    );
  }

  void addProductToCart(CartModel? cartModel) async {
    HomeRepo homeRepo = HomeRepoImpl();
    var response = await homeRepo.addProductToCart(cartModel!);
    response.fold(
      (l) => emit(state.copyWith(status: HomeStatus.error, massage: l.massage)),
      (r) => emit(state.copyWith(status: HomeStatus.addProductToCartSuccess)),
    );
  }

  void removeProductFromCart(String modelId) async {
    HomeRepo homeRepo = HomeRepoImpl();
    var response = await homeRepo.removeProductFromCart(modelId);
    response.fold(
      (l) => emit(state.copyWith(status: HomeStatus.error, massage: l.massage)),
      (r) =>
          emit(state.copyWith(status: HomeStatus.removeProductFromCartSuccess)),
    );
  }

  void incQuantityInCart(CartModel cartModel) async {
    emit(state.copyWith(status: HomeStatus.changeQuntityLoading));
    cartModel.quntitiy = (cartModel.quntitiy ?? 1) + 1;
    HomeRepo homeRepo = HomeRepoImpl();
    var response = await homeRepo.updateCart(cartModel);
    response.fold(
      (error) {
        emit(state.copyWith(status: HomeStatus.error, massage: error.massage));
      },
      (r) {
        emit(state.copyWith(status: HomeStatus.changeQuntitySuccess));
      },
    );
  }

  void decQuantityInCart(CartModel cartModel) async {
    if ((cartModel.quntitiy ?? 1) > 1) {
      emit(state.copyWith(status: HomeStatus.changeQuntityLoading));
      cartModel.quntitiy = (cartModel.quntitiy ?? 1) - 1;
      HomeRepo homeRepo = HomeRepoImpl();
      var response = await homeRepo.updateCart(cartModel);
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

  void placeOrder() {
    emit(state.copyWith(status: HomeStatus.placeOrderLoading));
    HomeRepo homeRepo = HomeRepoImpl();
    OrderModel orderModel = OrderModel(
      dateInMilleSeconds: DateTime.now().millisecondsSinceEpoch,
      products: state.cartProducts ?? [],
      totalPrice: state.totalPrice ?? 0,
      uid: currentUser?.id ?? "",
    );
    homeRepo.placeOrders(orderModel).then((value) {
      value.fold((error) {
        emit(state.copyWith(status: HomeStatus.error, massage: error.massage));
      }, (r) {
        emit(state.copyWith(status: HomeStatus.placeOrderSuccess));
        for (var model in state.cartProducts ?? []) {
          removeProductFromCart(model.id ?? "");
        }
      });
    });
  }

  HomeCubit() : super(HomeInitial()) {
    getFavoriteList();
    getCart();
  }
}
