import 'package:go_router/go_router.dart';
import 'package:jj_burgers/presentation/screens/cart_screen.dart';
import 'package:jj_burgers/presentation/screens/home_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
  ]
);