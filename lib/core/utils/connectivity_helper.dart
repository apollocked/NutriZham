import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/connectivity_cubit.dart';

extension ConnectivityGuard on BuildContext {
  bool get isOnline => read<ConnectivityCubit>().isOnline;

  bool guardOnline({String? message}) {
    if (!isOnline) {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message ?? 'This action requires an internet connection'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    return true;
  }
}
