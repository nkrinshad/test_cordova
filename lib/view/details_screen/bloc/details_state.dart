part of 'details_bloc.dart';

@immutable
abstract class DetailUserState {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final genderTextEditingController = TextEditingController();
  final statusTextEditingController = TextEditingController();
}

class DetailUserInitial extends DetailUserState {}

class EditingUser extends DetailUserState {}