import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:fruit_market/features/auth/domain/repositories/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static AuthCubit get(context) => BlocProvider.of(context);

  void loginWithGoogle() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AuthRepo authRepo = AuthRepoImpl();
      await authRepo.loginWithGoogle();
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, massage: e.toString()));
    }
  }

  void loginWithFacebook() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AuthRepo authRepo = AuthRepoImpl();
      await authRepo.loginWithFacebook();
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: AuthStatus.error, massage: e.toString()));
    }
  }

  void completeInfo() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      AuthRepo authRepo = AuthRepoImpl();
      await authRepo.completeInfo(
          name: nameController.text,
          phone: phoneController.text,
          id: FirebaseAuth.instance.currentUser!.uid,
          address: addressController.text);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: AuthStatus.error, massage: e.toString()));
    }
  }
}
