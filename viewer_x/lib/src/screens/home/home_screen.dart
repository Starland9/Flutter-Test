import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:viewer_x/src/core/routing/app_router.gr.dart';
import 'package:viewer_x/src/logic/cam_service.dart';

Map<String, PageRouteInfo> routes = {
  "scan": ScanRoute(cameraDescription: CamService.instance.cameras.first),
  "ticket": TicketRoute(),
  "history": HistoryRoute(),
};

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var route in routes.entries)
              TextButton(
                child: Text(route.key),
                onPressed: () => context.router.push(route.value),
              ),
          ],
        ),
      ),
    );
  }
}
