import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safe_digital_learning/l10n/app_localizations.dart';



import 'routes/app_routes.dart';
import 'core/auth/auth_wrapper.dart';
import 'core/locale/locale_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ← no longer needs localeProvider in constructor

  @override
  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      title: 'Safe Digital Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('mr'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: AuthWrapper(localeProvider: localeProvider),  // ← NO const
      routes: AppRoutes.routes,
    );
  }
}