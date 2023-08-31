part of 'home_bloc.dart';




@immutable
abstract class HomeEvent {}
class GetUsers extends HomeEvent {}

class GetAllUsers extends HomeEvent {
  final List<User>? users;
  GetAllUsers({this.users});
}
class CreateUser extends HomeEvent {}

class DetailUser extends HomeEvent {
  final User user;
  DetailUser(this.user);
}
class DeleteUser extends HomeEvent {
  final int userId;
  DeleteUser(this.userId);
}
