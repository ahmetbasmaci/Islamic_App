import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'src/app.dart';
import 'src/bloc_observer.dart';
import 'src/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await di.init();
  Bloc.observer = AppBlocObserver();
  // await Firebase.initializeApp();
  runApp(App());
}
