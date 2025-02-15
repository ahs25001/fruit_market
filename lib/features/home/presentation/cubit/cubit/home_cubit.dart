import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
 static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  void changePage(int index) => emit(state.copyWith(currentPage: index));
  HomeCubit() : super(HomeInitial());
}
