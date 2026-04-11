import 'package:currency_converter/core/localization/localization.dart';
import 'package:currency_converter/core/localization/localization_cubit/localization_cubit.dart';
import 'package:currency_converter/core/localization/localization_cubit/localization_state.dart';
import 'package:currency_converter/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LanguageBottomSheetWidget extends StatelessWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        final currentLang = state.languageCode;
        
        return Container(
          decoration: BoxDecoration(
            color: context.colors.cardColor,
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
                  color: context.colors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  context.l10n.select_language,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: context.colors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _LanguageOptionItem(
                code: 'en',
                name: 'English',
                flag: 'assets/icons/ic_english.png',
                context: context,
                currentLanguage: currentLang,
              ),
              _LanguageOptionItem(
                code: 'uz',
                name: "O'zbekcha",
                flag: 'assets/icons/ic_uzbek.png',
                context: context,
                currentLanguage: currentLang,
              ),
              _LanguageOptionItem(
                code: 'ru',
                name: 'Русский',
                flag: 'assets/icons/ic_russian.png',
                context: context,
                currentLanguage: currentLang,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageOptionItem extends StatelessWidget {
  final String code;
  final String name;
  final String flag;
  final String currentLanguage;
  final BuildContext context;

  const _LanguageOptionItem({
    required this.code,
    required this.name,
    required this.flag,
    required this.currentLanguage,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentLanguage == code;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<LocalizationCubit>().changeLocale(Locale(code));
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Image.asset(flag, width: 30, height: 30),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: isSelected
                        ? context.colors.primaryColor
                        : context.colors.textPrimary,
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: context.colors.primaryColor,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
