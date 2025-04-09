import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'broadcast_state.dart';

class BroadcastCubit extends Cubit<BroadcastState> {
  BroadcastCubit() : super(BroadcastInitial());
}
