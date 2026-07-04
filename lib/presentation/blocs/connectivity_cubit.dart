import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ConnectivityState {
  const ConnectivityState();
}
class ConnectivityOnline extends ConnectivityState {
  const ConnectivityOnline();
}
class ConnectivityOffline extends ConnectivityState {
  const ConnectivityOffline();
}

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit() : super(const ConnectivityOnline());

  bool get isOnline => state is ConnectivityOnline;

  Future<void> initialize() async {
    final result = await _connectivity.checkConnectivity();
    _updateState(result);
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  void _updateState(List<ConnectivityResult> result) {
    if (result.isEmpty || result.every((r) => r == ConnectivityResult.none)) {
      emit(const ConnectivityOffline());
    } else {
      emit(const ConnectivityOnline());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
