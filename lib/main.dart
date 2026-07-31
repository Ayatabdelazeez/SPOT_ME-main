import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'providers/player_providers.dart';
import 'providers/scout_providers.dart';

import 'utils/app_pages.dart';
import 'utils/app_routes.dart';

import 'package:spotme/screens/scout/shortlisted_player_screen.dart';

import 'providers/subscription_provider.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spotme/l10n/app_localizations.dart';
import 'providers/language_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
        ChangeNotifierProvider(create: (_) => ScoutProvider()),

        ChangeNotifierProvider(
          create: (_) {
            final provider = SubscriptionProvider();
            provider.initialize();
            return provider;
          },
        ),

        ChangeNotifierProvider(
  create: (_) => LanguageProvider(),
),

        BlocProvider(
          create: (_) => ShortlistCubit()..loadShortlist("Football"),
        ),
      ],
      child: const SpotMe(),
    ),
  );
}

class SpotMe extends StatelessWidget {
  const SpotMe({super.key});

  @override
  Widget build(BuildContext context) {
return Consumer<LanguageProvider>(
  builder: (context, languageProvider, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: languageProvider.locale,

      supportedLocales: AppLocalizations.supportedLocales,

      localizationsDelegates:
          AppLocalizations.localizationsDelegates,

      title: "SpotMe",

      initialRoute: AppRoutes.splash,

      routes: AppPages.routes,
    );
  },
);  
  }
}
