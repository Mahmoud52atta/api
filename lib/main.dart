import 'package:api/cashe/helper_cache.dart';
import 'package:api/core/Api/dio_consumer.dart';
import 'package:api/cubit/user_cubit.dart';
import 'package:api/repos/user_repo.dart';
import 'package:api/screens/sign_in_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(
    BlocProvider(
      create: (context) => UserCubit(UserRepo(api: DioConsumer(dio: Dio()))),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
