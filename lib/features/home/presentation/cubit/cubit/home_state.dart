part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, error }

@immutable
// ignore: must_be_immutable
class HomeState {
  HomeStatus? status;
  int? currentPage;
  HomeState({this.status, this.currentPage});

  HomeState copyWith({HomeStatus? status, int? currentPage}) {
    return HomeState(
        status: status ?? this.status,
        currentPage: currentPage ?? this.currentPage);
  }
}

// ignore: must_be_immutable
final class HomeInitial extends HomeState {
  HomeInitial() : super(status: HomeStatus.initial, currentPage: 1);
}
