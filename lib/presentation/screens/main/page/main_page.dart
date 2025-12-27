import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../../di/injection.dart';
import '../../../dialogs/converter_dialog.dart';

import '../bloc/main_page_bloc.dart';
import '../widgets/currency_item_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../widgets/filter_chips_widget.dart';
import '../widgets/loading_state_widget.dart';
import '../widgets/main_page_header_widget.dart';
import '../widgets/search_bar_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  String selectedLanguage = 'EN';
  bool isDarkMode = false;
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
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    return BlocProvider(
      create: (_) => sl<MainPageBloc>()..add(GetCurrenciesEvent()),
      child: Scaffold(
        backgroundColor: colors.backgroundColor,
        body: Column(
          children: [
            BlocBuilder<MainPageBloc, MainPageState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colors.primaryColor.withOpacity(0.05),
                        colors.cardColor,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainScreenHeaderWidget(
                            selectedDate: selectedDate,
                            selectedLanguage: selectedLanguage,
                            isDarkMode: isDarkMode,
                            onThemeToggle: () {
                              setState(() {
                                isDarkMode = !isDarkMode;
                              });
                            },
                            onLanguageSelect: () =>
                                _showLanguageBottomSheet(context),
                            onDateSelect: () => _selectDate(context),
                          ),
                          const SizedBox(height: 16),
                          SearchBarWidget(
                            isSearchExpanded: isSearchExpanded,
                            searchQuery: searchQuery,
                            searchTextController: _searchTextController,
                            selectedLanguage: selectedLanguage,
                            isDarkMode: isDarkMode,
                            onExpand: () {
                              setState(() {
                                isSearchExpanded = true;
                              });
                              _searchController.forward();
                            },
                            onCollapse: () {
                              setState(() {
                                isSearchExpanded = false;
                                searchQuery = '';
                                _searchTextController.clear();
                              });
                              _searchController.reverse();
                            },
                            onClear: () {
                              setState(() {
                                searchQuery = '';
                                _searchTextController.clear();
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toLowerCase();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<MainPageBloc, MainPageState>(
                builder: (context, state) {
                  if (state is MainScreenLoading) {
                    return LoadingStateWidget(
                      selectedLanguage: selectedLanguage,
                      isDarkMode: isDarkMode,
                    );
                  }

                  if (state is MainScreenError) {
                    return ErrorStateWidget(
                      message: state.message,
                      selectedLanguage: selectedLanguage,
                      isDarkMode: isDarkMode,
                      onRetry: () {
                        context.read<MainPageBloc>().add(
                          GetCurrenciesEvent(),
                        );
                      },
                    );
                  }

                  if (state is MainScreenLoaded) {
                    var filteredCurrencies = state.currencies.where((currency) {
                      if (searchQuery.isEmpty) return true;
                      return currency.ccy.toLowerCase().contains(searchQuery) ||
                          currency.ccyNmEN.toLowerCase().contains(searchQuery);
                    }).toList();

                    if (sortBy == 'name') {
                      filteredCurrencies.sort((a, b) => a.ccy.compareTo(b.ccy));
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
                      return EmptyStateWidget(
                        selectedLanguage: selectedLanguage,
                        isDarkMode: isDarkMode,
                      );
                    }

                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: FilterChipsWidget(
                            sortBy: sortBy,
                            selectedLanguage: selectedLanguage,
                            isDarkMode: isDarkMode,
                            onSortChanged: (value) {
                              setState(() => sortBy = value);
                            },
                            onSortButtonTap: _showSortBottomSheet,
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
                                      parent: _listController,
                                      curve: Interval(
                                        (index / filteredCurrencies.length) *
                                            0.3,
                                        1.0,
                                        curve: Curves.easeOut,
                                      ),
                                    ),
                                  ),
                                  child: FadeTransition(
                                    opacity: _listController,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: index == 0 ? 8 : 0,
                                      ),
                                      child: CurrencyItemWidget(
                                        currency: currency,
                                        isDarkMode: isDarkMode,
                                        selectedLanguage: selectedLanguage,
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) {
                                              return CurrencyConverterSheet(
                                                selectedLanguage:
                                                selectedLanguage,
                                                currency: currency,
                                                isDarkMode: isDarkMode,
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
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: colors.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  AppStrings.t('sort_by', selectedLanguage),
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSortOption(
                AppStrings.t('name', selectedLanguage),
                'name',
                Icons.sort_by_alpha_rounded,
                colors,
              ),
              _buildSortOption(
                AppStrings.t('most_popular', selectedLanguage),
                'popular',
                Icons.star_rounded,
                colors,
              ),
              _buildSortOption(
                AppStrings.t('trending', selectedLanguage),
                'trending',
                Icons.trending_up_rounded,
                colors,
              ),
              _buildSortOption(
                AppStrings.t('highest_rate', selectedLanguage),
                'rate',
                Icons.arrow_upward_rounded,
                colors,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(
      String label,
      String value,
      IconData icon,
      AppThemeColors colors,
      ) {
    final isSelected = sortBy == value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            sortBy = value;
          });
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primaryColor.withOpacity(0.15)
                      : colors.searchBarColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isSelected ? colors.primaryColor : colors.textSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? colors.primaryColor : colors.textPrimary,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: colors.primaryColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colors.primaryColor,
              onPrimary: Colors.white,
              surface: colors.cardColor,
              onSurface: colors.textPrimary,
            ),
            dialogBackgroundColor: colors.cardColor,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      if (context.mounted) {
        log('Formatted date: $picked');
        context.read<MainPageBloc>().add(GetCurrenciesByDateEvent(picked));
      }
    }
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final colors = AppThemeColors(isDarkMode: isDarkMode);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: colors.cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.textSecondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  AppStrings.t('select_language', selectedLanguage),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: colors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildLanguageOption('EN', 'English', 'assets/icons/ic_english.png', colors),
              _buildLanguageOption('UZ', 'O\'zbekcha', 'assets/icons/ic_uzbek.png', colors),
              _buildLanguageOption('RU', 'Русский', 'assets/icons/ic_russian.png', colors),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
      String code,
      String name,
      String flag,
      AppThemeColors colors,
      ) {
    final isSelected = selectedLanguage == code;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            selectedLanguage = code;
          });
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Image.asset(flag, width: 30,height: 30,),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: isSelected ? colors.primaryColor : colors.textPrimary,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: colors.primaryColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}