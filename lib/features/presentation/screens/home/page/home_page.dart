// lib/features/presentation/screens/home/home_page.dart

import 'dart:developer';

import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:currency_converter/core/theme/theme_cubit/theme_cubit.dart';
import 'package:currency_converter/features/presentation/screens/home/widgets/sort_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection.dart';
import '../bloc/home_page_bloc.dart';
import '../widgets/currency_list_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/language_bottom_sheet_widget.dart';
import '../widgets/loading_state_widget.dart';
import '../widgets/top_section_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  late AnimationController _searchController;
  late AnimationController _listController;
  String searchQuery = '';
  final TextEditingController _searchTextController = TextEditingController();
  bool isSearchExpanded = false;
  String sortBy = 'name';

  @override
  void initState() {
    super.initState();
    _searchController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _listController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _listController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomePageBloc>()..add(const GetCurrenciesEvent()),
      child: Scaffold(
        backgroundColor: context.colors.backgroundColor,
        body: Column(
          children: [
            BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) {
                return TopSectionWidget(
                  selectedDate: selectedDate,
                  isSearchExpanded: isSearchExpanded,
                  searchQuery: searchQuery,
                  searchTextController: _searchTextController,
                  onThemeToggle: () {
                    context.read<ThemeCubit>().toggle();
                  },
                  onLanguageSelect: () => _showLanguageBottomSheet(context),
                  onDateSelect: () => _selectDate(context),
                  onSearchExpand: () {
                    setState(() => isSearchExpanded = true);
                    _searchController.forward();
                  },
                  onSearchCollapse: () {
                    setState(() {
                      isSearchExpanded = false;
                      searchQuery = '';
                      _searchTextController.clear();
                    });
                    _searchController.reverse();
                  },
                  onSearchClear: () {
                    setState(() {
                      searchQuery = '';
                      _searchTextController.clear();
                    });
                  },
                  onSearchChanged: (value) {
                    setState(() => searchQuery = value.toLowerCase());
                  },
                );
              },
            ),
            Expanded(
              child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
                  if (state is HomeScreenLoading) {
                    return LoadingStateWidget();
                  }

                  if (state is HomeScreenError) {
                    return ErrorStateWidget(
                      error: state.error,
                      onRetry: () { context
                            .read<HomePageBloc>()
                            .add(const GetCurrenciesEvent());
                      },
                    );
                  }

                  if (state is HomeScreenLoaded) {
                    var filteredCurrencies =
                        state.currencies.where((currency) {
                      if (searchQuery.isEmpty) return true;
                      return currency.ccy
                              .toLowerCase()
                              .contains(searchQuery) ||
                          currency.ccyNmEN
                              .toLowerCase()
                              .contains(searchQuery);
                    }).toList();

                    if (sortBy == 'name') {
                      filteredCurrencies
                          .sort((a, b) => a.ccy.compareTo(b.ccy));
                    } else if (sortBy == 'popular') {
                      final popular = [
                        'USD',
                        'EUR',
                        'GBP',
                        'JPY',
                        'RUB',
                        'CNY',
                      ];
                      filteredCurrencies.sort((a, b) {
                        final aIndex = popular.indexOf(a.ccy);
                        final bIndex = popular.indexOf(b.ccy);
                        if (aIndex == -1 && bIndex == -1) return 0;
                        if (aIndex == -1) return 1;
                        if (bIndex == -1) return -1;
                        return aIndex.compareTo(bIndex);
                      });
                    } else if (sortBy == 'trending') {
                      filteredCurrencies.sort((a, b) {
                        final aDiff = double.tryParse(
                              a.diff.replaceAll(RegExp(r'[^0-9.-]'), ''),
                            ) ??
                            0;
                        final bDiff = double.tryParse(
                              b.diff.replaceAll(RegExp(r'[^0-9.-]'), ''),
                            ) ??
                            0;
                        return bDiff.compareTo(aDiff);
                      });
                    } else if (sortBy == 'rate') {
                      filteredCurrencies.sort((a, b) {
                        final aRate = double.tryParse(a.rate) ?? 0;
                        final bRate = double.tryParse(b.rate) ?? 0;
                        return bRate.compareTo(aRate);
                      });
                    }

                    if (filteredCurrencies.isEmpty) {
                      return EmptyStateWidget();
                    }

                    return CurrencyListWidget(
                      filteredCurrencies: filteredCurrencies,
                      sortBy: sortBy,
                      listController: _listController,
                      onSortChanged: (value) =>
                          setState(() => sortBy = value),
                      onSortButtonTap: _showSortBottomSheet,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SortBottomSheetWidget(
          sortBy: sortBy,
          onSortSelected: (value) => setState(() => sortBy = value),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.colors.primaryColor,
              onPrimary: Colors.white,
              surface: context.colors.cardColor,
              onSurface: context.colors.textPrimary,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: context.colors.cardColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      if (context.mounted) {
        log('Selected date: $picked');
        context
            .read<HomePageBloc>()
            .add(GetCurrenciesByDateEvent(picked));
      }
    }
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bottomSheetContext) {
        return LanguageBottomSheetWidget();
      },
    );
  }
}