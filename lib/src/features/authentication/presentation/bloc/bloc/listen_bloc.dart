// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
// import 'package:fit_flex_club/src/features/authentication/domain/usecases/listen_to_events_usecase.dart';
// import 'package:fit_flex_club/src/features/workout_management/domain/repositories/workout_management_repository.dart';
// import 'package:injectable/injectable.dart';

// part 'listen_event.dart';
// part 'listen_state.dart';

// @injectable
// class ListenBloc extends Bloc<ListenEvent, ListenState> {
//   final ListenToEventsUsecase listenToEventsUsecase;
//   ListenBloc(this.listenToEventsUsecase) : super(ListenInitial()) {
//     on<ListenEvent>(
//       (event, emit) async {
//         if (event is ListenToEvent) {
//           await _onListen(event, emit);
//         }
//       },
//     );
//   }

//   _onListen(
//     ListenToEvent event,
//     Emitter<ListenState> emit,
//   ) async {
//     emit(ListenLoading());

//     // Wait for the usecase result
//     final result = await listenToEventsUsecase(NoParams());

//     // Check if the emit is still valid
//     if (emit.isDone) return;

//     if (result == null) {
//       // emit(ListenError(message: "Something went wrong!"));
//     } else {
//       await result.fold(
//         (failure) async {
//           // Handle failure
//           if (!emit.isDone) {
//             // emit(ListenError(message: failure.message ?? "Unknown error occurred"));
//           }
//         },
//         (eventStream) async {
//           // Process event stream
//           await for (final listenEvent in eventStream) {
//             if (emit.isDone) break; // Stop if the handler is done
//             emit(ListenComplete(listeners: listenEvent));
//           }
//         },
//       );
//     }
//   }
// }
