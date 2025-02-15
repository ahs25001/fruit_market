part of 'add_data_cubit.dart';
enum AddDataStatuse { initial, loading, success, error }
@immutable
 // ignore: must_be_immutable
 class AddDataState {
  String ? massage;
  AddDataStatuse? statuse;

  AddDataState({this.statuse, this.massage});
  AddDataState copyWith({AddDataStatuse? statuse, String? massage}) {
    return AddDataState(
      statuse: statuse ?? this.statuse,
      massage: massage ?? this.massage,
    );
  }
 }

// ignore: must_be_immutable
final class AddDataInitial extends AddDataState {
  AddDataInitial() : super(statuse: AddDataStatuse.initial);
}
