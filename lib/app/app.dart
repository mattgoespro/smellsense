import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smellsense/app/application/providers/asset.provider.dart';
import 'package:smellsense/app/application/providers/database_service.provider.dart';
import 'package:smellsense/app/application/providers/infrastructure.provider.dart';
import 'package:smellsense/app/router.config.dart';
import 'package:smellsense/app/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: routerConfig,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
        );
      },
      providers: [
        FutureProvider<Infrastructure?>(
          create: (context) async {
            var dbService =
                await DatabaseServiceProvider.createDatabaseService();
            return Infrastructure(
              databaseService: dbService,
              assetProvider: AssetProvider(),
            );
          },
          initialData: null,
        ),
      ],
      child: router,
    );
  }
}
