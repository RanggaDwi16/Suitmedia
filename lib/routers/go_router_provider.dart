import 'package:go_router/go_router.dart';
import 'package:suitmedia/features/first_screen/pages/first_screen_page.dart';
import 'package:suitmedia/features/second_screen/pages/second_screen_page.dart';
import 'package:suitmedia/features/third_screen/pages/third_screen_page.dart';
import 'package:suitmedia/routers/router_name.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          initialLocation: '/',
          debugLogDiagnostics: false,
          routes: [
            GoRoute(
              path: '/',
              name: RouterName.firstScreen,
              builder: (context, state) => const FirstScreen(),
            ),
            GoRoute(
              path: '/second',
              name: RouterName.secondScreen,
              builder: (context, state) => const SecondScreen(),
            ),
            GoRoute(
              path: '/third',
              name: RouterName.thirdScreen,
              builder: (context, state) => const ThirdScreen(),
            ),
          ],
        );
}
