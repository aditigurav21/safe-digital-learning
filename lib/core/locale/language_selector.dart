import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



import 'locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final l = AppLocalizations.of(context)!;

    final langs = [
      {'label': '🇬🇧 English', 'code': 'en'},
      {'label': '🇮🇳 हिंदी', 'code': 'hi'},
      {'label': '🇮🇳 मराठी', 'code': 'mr'},
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l.selectLanguage,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        ...langs.map((lang) {
          final isSelected = localeProvider.locale.languageCode == lang['code'];
          return GestureDetector(
            onTap: () {
              localeProvider.setLocale(Locale(lang['code']!));
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange.shade50 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Text(lang['label']!, style: const TextStyle(fontSize: 15)),
                  const Spacer(),
                  if (isSelected)
                    const Icon(Icons.check_circle, color: Colors.orange, size: 20),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

/// Call this from any screen's AppBar or button to show the language picker.
void showLanguageSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.all(24),
      child: LanguageSelector(),
    ),
  );
}