import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cordova/view/details_screen/bloc/details_bloc.dart';

import '../../models/user.dart';

class DetailUserScreen extends StatelessWidget {
  final User? user;
  final bool isCreate;
  const DetailUserScreen({super.key, this.user, required this.isCreate});

  @override
  Widget build(BuildContext context) {
    DetailUserBloc bloc = BlocProvider.of<DetailUserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<DetailUserBloc, DetailUserState>(
          builder: (context, state) {
            bloc.state.nameTextEditingController.text = user?.name ?? "";
            bloc.state.emailTextEditingController.text = user?.email ?? "";
            bloc.state.genderTextEditingController.text = user?.gender ?? "";
            bloc.state.statusTextEditingController.text = user?.status ?? "";
            return Form(
              child: Column(
                children: [
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.nameTextEditingController,
                    decoration: const InputDecoration(

                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        hintText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.emailTextEditingController,
                    decoration: const InputDecoration(

                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.genderTextEditingController,
                    decoration: const InputDecoration(

                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        hintText: "Gender",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.statusTextEditingController,

                    decoration: const InputDecoration(

                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        hintText: "Status",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  Visibility(
                    visible: !isCreate,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: state is EditingUser
                              ? () => bloc.add(UpdateUser(User(
                              id: user!.id,
                              name: state.nameTextEditingController.text,
                              email: state.emailTextEditingController.text,
                              gender: state.genderTextEditingController.text,
                              status: state.statusTextEditingController.text)))
                              : null,
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50)),
                          child: const Text('UPDATE',style: TextStyle(fontWeight: FontWeight.w800,),),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Visibility(
                    visible: isCreate,
                    child: ElevatedButton(
                      onPressed: () {
                        User data = User(
                          id: 0,
                          name: bloc.state.nameTextEditingController.text,
                          email: bloc.state.emailTextEditingController.text,
                          gender: bloc.state.genderTextEditingController.text,
                          status: bloc.state.statusTextEditingController.text,
                        );
                        bloc.add(StoreUser(data));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      child: const Text('CREATE'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isCreate,
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () => bloc.add(EditUser()),
          tooltip: 'Edit User',
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}