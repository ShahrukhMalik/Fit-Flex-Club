import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/repositories/sync_manager_repository.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/check_connectivity_usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/event_listener_usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/mark_event_listened_usecase.dart';
import 'package:injectable/injectable.dart';

part 'syncmanager_event.dart';
part 'syncmanager_state.dart';

@injectable
class SyncmanagerBloc extends Bloc<SyncmanagerEvent, SyncmanagerState> {
  final CheckConnectivityUsecase checkConnectivityUsecase;
  final EventListenerUsecase eventListenerUsecase;
  final MarkEventListenedUsecase markEventListenedUsecase;
  SyncmanagerBloc(
    this.checkConnectivityUsecase,
    this.eventListenerUsecase,
    this.markEventListenedUsecase,
  ) : super(SyncmanagerInitial()) {
    on<SyncmanagerEvent>((event, emit) async {
      // if (event is CheckConnectivityEvent) {
      //   await _getConnectivityStatus(event, emit);
      // }
      // if (event is SyncOnlineDataEvent) {
      //   await _eventListener(event, emit);
      // }
      if (event is MarkEventListened) {
        await _markEventListened(event, emit);
      }
    });
  }

  Future<void> _getConnectivityStatus(
    SyncmanagerEvent event,
    Emitter<SyncmanagerState> emit,
  ) async {
    emit(
      SyncmanagerLoading(
        isCheckingConnectivity: true,
        syncingData: null,
      ),
    );
    final result = await checkConnectivityUsecase(NoParams());
    if (emit.isDone) return;
    result?.fold(
      (l) {
        emit(SyncmanagerError(failures: l));
      },
      (r) async {
        await for (final isOnline in r) {
          if (emit.isDone) break;
          emit(
            SyncmanagerComplete(
              isOnline: isOnline,
              isDataSynced: null,
            ),
          );
        }
      },
    );
  }

  Future<void> _eventListener(
    SyncOnlineDataEvent event,
    Emitter<SyncmanagerState> emit,
  ) async {
    // emit(
    //   SyncmanagerLoading(
    //     isCheckingConnectivity: null,
    //     syncingData: true,
    //   ),
    // );

    // final result = await eventListenerUsecase(NoParams());
    // if (emit.isDone) return;
    // result?.fold(
    //   (l) {
    //     emit(SyncmanagerError(failures: l));
    //   },
    //   (r) async {
    //     if (r == null) {
    //       emit(
    //         SyncmanagerError(
    //           failures: ServerFailure(
    //             message: "Somewhere went wrong",
    //           ),
    //         ),
    //       );
    //     } else {
    //       await for (final syncResult in r) {
    //         // if (emit.isDone) break;
    //         emit(
    //           SyncmanagerComplete(
    //             isOnline: null,
    //             isDataSynced: null,
    //             listenerEvents: syncResult?['eventType'],
    //             docId: syncResult?['docId'],
    //           ),
    //         );
    //       }
    //     }
    //   },
    // );
  }

  Future<void> _markEventListened(
    MarkEventListened event,
    Emitter<SyncmanagerState> emit,
  ) async {
    emit(
      SyncmanagerLoading(
        isCheckingConnectivity: null,
        syncingData: true,
      ),
    );

    final result = await markEventListenedUsecase(Params(docId: event.docId));

    result?.fold(
      (l) {
        emit(SyncmanagerError(failures: l));
      },
      (r) async {
        emit(SyncmanagerComplete(isDataSynced: true));
      },
    );
  }
}
