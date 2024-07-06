import 'package:flutter/material.dart';

class RouterNavigateObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didPush: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didPop: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didRemove: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('didReplace: ${newRoute!.settings.name}');
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didStartUserGesture: ${route.settings.name}');
  }

  @override
  void didStopUserGesture() {
    print('didStopUserGesture');
  }
}
