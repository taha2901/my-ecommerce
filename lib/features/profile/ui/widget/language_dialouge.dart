import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/gen/locale_keys.g.dart';
import 'package:flutter/material.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  late Locale selectedLocale;

  @override
  void initState() {
    super.initState();
    selectedLocale = Localizations.localeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return AlertDialog(
      title: Text(LocaleKeys.select_language.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<Locale>(
            activeColor: AppColors.primary,
            value: const Locale('en'),
            groupValue: selectedLocale,
            title: Text(LocaleKeys.language_english.tr()),
            onChanged: (value) {
              setState(() => selectedLocale = value!);
            },
          ),
          RadioListTile<Locale>(
            activeColor: AppColors.primary,
            value: const Locale('ar'),
            groupValue: selectedLocale,
            title: Text(LocaleKeys.language_arabic.tr()),
            onChanged: (value) {
              setState(() => selectedLocale = value!);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            LocaleKeys.cancel.tr(),
            style: TextStyle(color: AppColors.primary),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (selectedLocale != currentLocale) {
              await context.setLocale(selectedLocale);
            }
            Navigator.pop(context);
          },
          child: Text(
            LocaleKeys.ok.tr(),
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
