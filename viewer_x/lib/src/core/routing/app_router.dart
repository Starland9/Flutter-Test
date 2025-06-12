import 'package:auto_route/auto_route.dart';
import 'package:viewer_x/src/core/routing/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: TicketRoute.page),
    AutoRoute(page: ScanRoute.page),
    AutoRoute(page: HistoryRoute.page),
  ];
}
