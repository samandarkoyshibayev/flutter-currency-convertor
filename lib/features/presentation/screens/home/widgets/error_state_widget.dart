import 'package:currency_converter/core/error/error_type.dart';
import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:currency_converter/features/data/repository/repository_impl.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final AppError error;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  String _resolveMessage(BuildContext context) {
    final l10n = context.l10n;
    return switch (error.key) {
      ErrorKey.network       => l10n.error_network,
      ErrorKey.timeout       => l10n.error_timeout,
      ErrorKey.server400     => l10n.error_server_400,
      ErrorKey.server401     => l10n.error_server_401,
      ErrorKey.server404     => l10n.error_server_404,
      ErrorKey.server500     => l10n.error_server_500,
      ErrorKey.serverUnknown => l10n.error_server_unknown(error.code ?? '?'),
      ErrorKey.noData        => l10n.error_no_data,
      ErrorKey.unknown       => l10n.error_unknown,
    };
  }

  IconData get _icon {
    return switch (error.key) {
      ErrorKey.network       => Icons.wifi_off_rounded,
      ErrorKey.timeout       => Icons.timer_off_rounded,
      ErrorKey.server404     => Icons.search_off_rounded,
      ErrorKey.noData        => Icons.calendar_today_outlined,
      ErrorKey.server500     => Icons.cloud_off_rounded,
      _                      => Icons.error_outline_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: context.colors.cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _icon,
                  color: Colors.red,
                  size: 52,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.error_title,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _resolveMessage(context),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.refresh_rounded, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      context.l10n.retry,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}