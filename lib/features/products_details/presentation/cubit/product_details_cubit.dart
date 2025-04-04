
import 'package:bloc/bloc.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/products_details/data/repositories/product_details_repo_impl.dart';
import 'package:fruit_market/features/products_details/domain/repositories/product_details_repo.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  void addProductToCart(CartModel cartModel) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));
    ProductDetailsRepo productDetailsRepo = ProductDetailsRepoImpl();
    var response = await productDetailsRepo.addProductToCart(cartModel);
    response.fold(
      (l) => emit(state.copyWith(
          status: ProductDetailsStatus.error, massage: l.massage)),
      (r) => emit(
          state.copyWith(status: ProductDetailsStatus.addProductToCartSuccess)),
    );
  }
  void removeProductfromCart(String  productId) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading));
    ProductDetailsRepo productDetailsRepo = ProductDetailsRepoImpl();
    var response = await productDetailsRepo.removeProductFromCart(productId);
    response.fold(
      (l) => emit(state.copyWith(
          status: ProductDetailsStatus.error, massage: l.massage)),
      (r) => emit(
          state.copyWith(status: ProductDetailsStatus.removeProductFromCartSuccess)),
    );
  }
}
