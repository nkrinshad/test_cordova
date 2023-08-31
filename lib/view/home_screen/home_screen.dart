import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cordova/view/home_screen/bloc/home_bloc.dart';

import '../../models/user.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ScrollController controller = ScrollController();
  late HomeBloc bloc;
  late List<User>? users;
  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      bloc.add(GetAllUsers(users: users));
    }
  }

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(GetUsers());
    controller.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cordova"),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.grey[300],
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            users = (state).users;
            return Column(
              children: [

                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: users!.length + 1,
                    itemBuilder: (context, index) {
                      return index < users!.length
                          ? buildCardItem(context, index, users![index], bloc)
                          : const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                            child: Center(
                                child: CircularProgressIndicator())),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.add(CreateUser()),
        tooltip: 'Add New User',
        child: const Icon(Icons.add),
      ),
    );
  }

  Padding buildCardItem(
      BuildContext context, int index, User users, HomeBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(users.name,style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600) ,),

                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: GestureDetector(
                      onTap: () =>  bloc.add(DetailUser(users)),

                      child: const Text('View',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: GestureDetector(
                      onTap: () => bloc.add(DeleteUser(users.id)),

                      child: const Text('Delete',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),)),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
