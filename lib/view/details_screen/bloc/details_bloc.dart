import 'package:flutter/material.dart';
import 'package:context_holder/context_holder.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cordova/view/home_screen/bloc/home_bloc.dart';
import '../../../models/user.dart';
import '../../../services/dio_client.dart';
import '../../home_screen/home_screen.dart';
part 'details_event.dart';
part 'details_state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  BuildContext context = ContextHolder.currentContext;
  DetailUserBloc() : super(DetailUserInitial()) {
    on<EditUser>((event, emit) {
      emit(EditingUser());
    });

    on<UpdateUser>((event, emit) async {
      await updateUser(user: event.user);
    });

    on<StoreUser>((event, emit) async {
      await createUser(user: event.user);
    });


  }

  Future<void> createUser({required User user}) async {
    try {
      User? response = await DioClient().createUser(
          data: User(
            id: 0,
            name: user.name,
            email: user.email,
            gender: user.gender,
            status: user.status,
          ));
      if (response != null && context.mounted) {
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

  Future<void> updateUser({required User user}) async {
    try {
      User? response = await DioClient().updateUser(
          data: User(
            id: user.id,
            name: user.name,
            email: user.email,
            gender: user.gender,
            status: user.status,
          ));
      if (response != null && context.mounted) {
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