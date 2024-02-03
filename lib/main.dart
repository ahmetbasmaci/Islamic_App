import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'src/app.dart';
import 'src/bloc_observer.dart';
import 'src/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await GetItManager.instance.init();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();
  runApp(const App());
}
