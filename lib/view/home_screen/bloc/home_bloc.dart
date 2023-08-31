import 'package:context_holder/context_holder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cordova/view/home_screen/home_screen.dart';

import '../../../models/user.dart';
import '../../../services/dio_client.dart';
import '../../details_screen/bloc/details_bloc.dart';
import '../../details_screen/details_screen.dart';
part 'home_event.dart';
part 'home_state.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  BuildContext context = ContextHolder.currentContext;
  HomeBloc() : super(HomeInitial()){

    BuildContext context = ContextHolder.currentContext;
    on<GetUsers>((event, emit) async {
      emit(HomeLoading());
      List<User>? user = await getUsers();
      emit(HomeLoaded(users: user));
    });

    on<GetAllUsers>((event, emit) async {
      List<User>? currentUser = event.users;
      List<User>? user =
      await getUsers(page: currentUser!.length ~/ 4 + 1, perPage: 4);
      currentUser.addAll(user!);
      emit(HomeLoaded(users: currentUser));
    });

    on<CreateUser>((event, emit) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider<DetailUserBloc>(
              create: (context) => DetailUserBloc(),
              child: const DetailUserScreen(isCreate: true),
            )),
      );
    });

    on<DetailUser>((event, emit) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider<DetailUserBloc>(
              create: (context) => DetailUserBloc(),
              child: DetailUserScreen(user: event.user, isCreate: false),
            )),
      );
    });
    on<DeleteUser>((event, emit) async {
      await deleteUser(userId: event.userId);
    });
  }

  Future<List<User>?> getUsers({int? page, int? perPage}) async {
    List<User>? users;
    try {
      List<User>? response =
      await DioClient().getUsers(page: page, perPage: perPage);
      users = response;
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return users;
  }

  Future<void> deleteUser({required int userId}) async {
    try {
      bool response = await DioClient().deleteUser(id: userId);
      if (response && context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider<HomeBloc>(
                  create: (context) => HomeBloc(),
                  child: const HomeScreen(),
                )));
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      return;
    }
  }
}