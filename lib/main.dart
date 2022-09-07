import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q8_task/cubits/user_cubit/user_cubit.dart';
import 'package:q8_task/data/network_service.dart';
import 'package:q8_task/data/repository.dart';
import 'package:q8_task/utility/light_theme.dart';
import 'package:q8_task/views/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserCubit(
            repository: Repository(networkService: NetworkService()))
          ..getAllUser()
          ..init();
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Q8 Task',
          theme: lightTheme,
          home: const HomePage()),
    );
  }
}
