import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'memorize_state.dart';

class MemorizeCubit extends Cubit<MemorizeState> {
  MemorizeCubit() : super(MemorizeInitial());
}
