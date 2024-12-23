import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_flex_club/src/core/util/error/failures.dart';
import 'package:fit_flex_club/src/core/util/usecase/usecase.dart';
import 'package:fit_flex_club/src/features/syncmanager/domain/usecases/check_connectivity_usecase.dart';
import 'package:injectable/injectable.dart';

part 'syncmanager_event.dart';
part 'syncmanager_state.dart';

@injectable
class SyncmanagerBloc extends Bloc<SyncmanagerEvent, SyncmanagerState> {
  final CheckConnectivityUsecase checkConnectivityUsecase;
  SyncmanagerBloc(this.checkConnectivityUsecase) : super(SyncmanagerInitial()) {
    on<SyncmanagerEvent>((event, emit) async {
      if (event is CheckConnectivityEvent) {
        await _getConnectivityStatus(event, emit);
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
}
