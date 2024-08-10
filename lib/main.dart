import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/features/first_screen/providers/name_provider.dart';
import 'package:suitmedia/features/second_screen/provider/user_name_provider.dart';
import 'package:suitmedia/features/third_screen/providers/user_provider.dart';
import 'package:suitmedia/features/third_screen/services/user_service.dart';
import 'package:suitmedia/routers/go_router_provider.dart';
import 'package:suitmedia/utils/my_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        ChangeNotifierProvider(create: (_) => NameProvider()),
        ChangeNotifierProvider(create: (_) => UserNameProvider()),

        Provider<UserService>(
          create: (context) => UserService(dio: context.read<Dio>()),
        ),
        ChangeNotifierProvider(
            create: (context) => UserProvider(context.read<UserService>())),
        Provider(create: (_) => AppRouter()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerProvider = Provider.of<AppRouter>(context);

    return MaterialApp.router(
      title: 'MyTelkomsat',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      routeInformationParser: routerProvider.router.routeInformationParser,
      routeInformationProvider: routerProvider.router.routeInformationProvider,
      routerDelegate: routerProvider.router.routerDelegate,
    );
  }
}
