import 'package:bloc/bloc.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';
import 'package:fruit_market/features/orders/data/repositories/orders_repo_impl.dart';
import 'package:fruit_market/features/orders/domain/repositories/orders_repo.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  void getOrders() {
    emit(state.copyWith(status: OrdersStatus.loading));
    OrdersRepo ordersRepo = OrdersRepoImpl();
    ordersRepo.getOrders().then((response) {
      response.fold((error) {
        emit(
            state.copyWith(status: OrdersStatus.error, massage: error.massage));
      }, (r) {
        emit(state.copyWith(status: OrdersStatus.success, orders: r));
      });
    });
  }

  void changeRating(CartModel cartProduct, double newRating,String orderId) {
    emit(state.copyWith(status: OrdersStatus.changeRatingLoading));
    print("llllllllllllllllllllllllllllllllllll");
    OrdersRepo ordersRepo = OrdersRepoImpl();
    cartProduct.rating = newRating;
    ordersRepo.changeRating(cartProduct,orderId).then((response) {
      response.fold((error) {
        emit(
            state.copyWith(status: OrdersStatus.error, massage: error.massage));
      }, (r) {
        print("sssssssssssssssssssssssssssssssssss");
        emit(state.copyWith(status: OrdersStatus.changeRatingSuccess));
      });
    });
  }
}
