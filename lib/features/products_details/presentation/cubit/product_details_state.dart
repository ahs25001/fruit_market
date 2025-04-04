part of 'product_details_cubit.dart';

enum ProductDetailsStatus {
  init,
  loading,
  addProductToCartSuccess,
  removeProductFromCartSuccess,
  error
}

@immutable
class ProductDetailsState {
  ProductDetailsStatus? status;
  String? massage;

  ProductDetailsState({this.status, this.massage});
  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    String? massage,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      massage: massage ?? this.massage,
    );
  }
}

final class ProductDetailsInitial extends ProductDetailsState {
  ProductDetailsInitial() : super(status: ProductDetailsStatus.init);
}
