import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:jj_burgers/config/router/go_router.dart';
import 'package:jj_burgers/config/theme/app_theme.dart';
import 'package:jj_burgers/db_helper/mongodb.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return riverpod.ProviderScope(
      child: ChangeNotifierProvider(
        create: (_) => CartNotifier(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: AppTheme().getTheme(),
        ),
      ),
    );
  }
}
