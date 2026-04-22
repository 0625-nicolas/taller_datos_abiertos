// Archivo: lib/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:taller_datos_abiertos/views/dashboard_view.dart';
import 'package:taller_datos_abiertos/views/list_view.dart';
import 'package:taller_datos_abiertos/views/detail_view.dart';

// ... el resto queda igual (final appRouter = ...)

// Esta es la variable que main.dart está buscando
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: '/list/:endpoint',
      builder: (context, state) {
        final endpoint = state.pathParameters['endpoint']!;
        return DataListView(endpointTitle: endpoint);
      },
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return DetailView(data: extra);
      },
    ),
  ],
);