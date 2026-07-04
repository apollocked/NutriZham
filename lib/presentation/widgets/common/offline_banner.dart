import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/connectivity_cubit.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isOffline =
        context.watch<ConnectivityCubit>().state is ConnectivityOffline;
    return AnimatedSlide(
      duration: const Duration(milliseconds: 250),
      offset: isOffline ? Offset.zero : const Offset(0, -2),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isOffline ? 1.0 : 0.0,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 4,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.error.withOpacity(0.95),
                Theme.of(context).colorScheme.error.withOpacity(0.85),
              ],
            ),
          ),
          child: const SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off_rounded, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  'You are offline',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
