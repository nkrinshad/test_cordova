
part of 'details_bloc.dart';

@immutable
abstract class DetailUserEvent {}

class EditUser extends DetailUserEvent {}

class UpdateUser extends DetailUserEvent {
  final User user;
  UpdateUser(this.user);
}

class StoreUser extends DetailUserEvent {
  final User user;
  StoreUser(this.user);
}

