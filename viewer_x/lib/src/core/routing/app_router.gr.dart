// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:camera/camera.dart' as _i7;
import 'package:flutter/foundation.dart' as _i6;
import 'package:viewer_x/src/screens/history/history_screen.dart' as _i1;
import 'package:viewer_x/src/screens/home/home_screen.dart' as _i2;
import 'package:viewer_x/src/screens/scan/scan_screen.dart' as _i3;
import 'package:viewer_x/src/screens/ticket/ticket_screen.dart' as _i4;

/// generated route for
/// [_i1.HistoryScreen]
class HistoryRoute extends _i5.PageRouteInfo<void> {
  const HistoryRoute({List<_i5.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HistoryScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.ScanScreen]
class ScanRoute extends _i5.PageRouteInfo<ScanRouteArgs> {
  ScanRoute({
    _i6.Key? key,
    required _i7.CameraDescription cameraDescription,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         ScanRoute.name,
         args: ScanRouteArgs(key: key, cameraDescription: cameraDescription),
         initialChildren: children,
       );

  static const String name = 'ScanRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScanRouteArgs>();
      return _i3.ScanScreen(
        key: args.key,
        cameraDescription: args.cameraDescription,
      );
    },
  );
}

class ScanRouteArgs {
  const ScanRouteArgs({this.key, required this.cameraDescription});

  final _i6.Key? key;

  final _i7.CameraDescription cameraDescription;

  @override
  String toString() {
    return 'ScanRouteArgs{key: $key, cameraDescription: $cameraDescription}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScanRouteArgs) return false;
    return key == other.key && cameraDescription == other.cameraDescription;
  }

  @override
  int get hashCode => key.hashCode ^ cameraDescription.hashCode;
}

/// generated route for
/// [_i4.TicketScreen]
class TicketRoute extends _i5.PageRouteInfo<void> {
  const TicketRoute({List<_i5.PageRouteInfo>? children})
    : super(TicketRoute.name, initialChildren: children);

  static const String name = 'TicketRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.TicketScreen();
    },
  );
}
