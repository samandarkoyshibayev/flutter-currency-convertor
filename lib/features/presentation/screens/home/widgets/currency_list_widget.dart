import 'package:flutter/material.dart';

import '../../../dialogs/converter_dialog.dart';
import 'currency_item_widget.dart';
import 'filter_chips_widget.dart';

class CurrencyListWidget extends StatelessWidget {
  final List filteredCurrencies;
  final String sortBy;
  final AnimationController listController;
  final ValueChanged<String> onSortChanged;
  final VoidCallback onSortButtonTap;

  const CurrencyListWidget({
    super.key,
    required this.filteredCurrencies,
    required this.sortBy,
    required this.listController,
    required this.onSortChanged,
    required this.onSortButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: FilterChipsWidget(
            sortBy: sortBy,
            onSortChanged: onSortChanged,
            onSortButtonTap: onSortButtonTap,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final currency = filteredCurrencies[index];

                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.2, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: listController,
                      curve: Interval(
                        (index / filteredCurrencies.length) * 0.3,
                        1.0,
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: listController,
                    child: Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 8 : 0),
                      child: CurrencyItemWidget(
                        currency: currency,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return CurrencyConverterSheet(
                                currency: currency,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              childCount: filteredCurrencies.length,
            ),
          ),
        ),
      ],
    );
  }
}