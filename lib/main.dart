import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/home_screen/bloc/home_bloc.dart';
import 'view/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cordova Technical Test',

      navigatorKey: ContextHolder.key,
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}


