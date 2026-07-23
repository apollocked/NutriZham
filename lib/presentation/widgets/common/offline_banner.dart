import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrizham/presentation/blocs/connectivity_cubit.dart';
import 'package:nutrizham/l10n/app_localizations.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isOffline =
        context.watch<ConnectivityCubit>().state is ConnectivityOffline;
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      crossFadeState:
          isOffline ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 4,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.error.withValues(alpha: 0.95),
              Theme.of(context).colorScheme.error.withValues(alpha: 0.85),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, color: Theme.of(context).colorScheme.onError, size: 18),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.youAreOffline,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      secondChild: const SizedBox.shrink(),
    );
  }
}
