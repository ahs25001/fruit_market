part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, error }

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
  HomeState(
      {this.status,
      this.currentTab,
      this.currentPage,
      this.fruitSubCategories,
      this.dryFruitsSubCategories,
      this.vegetablesSubCategories,
      this.massage});

  HomeState copyWith(
      {HomeStatus? status,
      int? currentPage,
      int? currentTab,
      String? massage,
      List<SubCategoryModel?>? fruitSubCategories,
      List<SubCategoryModel?>? vegetablesSubCategories,
      List<SubCategoryModel?>? dryFruitsSubCategories}) {
    return HomeState(
        currentTab: currentTab ?? this.currentTab,
        massage: massage ?? this.massage,
        status: status ?? this.status,
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
  HomeInitial() : super(status: HomeStatus.initial, currentPage: 1,currentTab: 0);
}
