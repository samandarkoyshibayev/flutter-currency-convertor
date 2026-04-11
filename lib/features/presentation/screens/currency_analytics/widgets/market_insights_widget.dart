import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';

class MarketInsightsWidget extends StatelessWidget {
  final bool isPositive;
  final Animation<Offset> animation;

  const MarketInsightsWidget({
    super.key,
    required this.isPositive,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {

    return SlideTransition(
      position: animation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           context.l10n.market_insights,
            style: TextStyle(
              color: context.colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 16),
          _buildInsightCard(
            isPositive
                ? context.l10n.bullish_title
                : context.l10n.bearish_title,
            isPositive
                ? context.l10n.bullish_desc
                : context.l10n.bearish_desc,
            isPositive
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
            isPositive ? context.colors.accentColor : context.colors.errorColor,
            context,
          ),
          const SizedBox(height: 12),
          _buildInsightCard(
            context.l10n.stability_title,
           context.l10n.stability_desc,
            Icons.shield_outlined,
            context.colors.primaryColor,
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
      String title,
      String description,
      IconData icon,
      Color color,
      BuildContext context
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: context.colors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}