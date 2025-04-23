part of 'orders_cubit.dart';

enum OrdersStatus {
  initial,
  loading,
  success,
  error,
  changeRatingSuccess,
  changeRatingLoading,
  changeRatingError
}

@immutable
class OrdersState {
  OrdersStatus? status;
  String? massage;
  List<OrderModel>? orders;

  OrdersState({this.status, this.massage, this.orders});
  OrdersState copyWith(
      {OrdersStatus? status, String? massage, List<OrderModel>? orders}) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      massage: massage ?? this.massage,
    );
  }
}

final class OrdersInitial extends OrdersState {
  OrdersInitial() : super(status: OrdersStatus.initial);
}
