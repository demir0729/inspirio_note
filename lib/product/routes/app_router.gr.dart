// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddNoteRoute.name: (routeData) {
      final args = routeData.argsAs<AddNoteRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNoteView(
          key: args.key,
          item: args.item,
        ),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteView(),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryView(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    OpenedNoteRoute.name: (routeData) {
      final args = routeData.argsAs<OpenedNoteRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OpenedNoteView(
          key: args.key,
          item: args.item,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashView(),
      );
    },
  };
}

/// generated route for
/// [AddNoteView]
class AddNoteRoute extends PageRouteInfo<AddNoteRouteArgs> {
  AddNoteRoute({
    Key? key,
    required dynamic item,
    List<PageRouteInfo>? children,
  }) : super(
          AddNoteRoute.name,
          args: AddNoteRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNoteRoute';

  static const PageInfo<AddNoteRouteArgs> page =
      PageInfo<AddNoteRouteArgs>(name);
}

class AddNoteRouteArgs {
  const AddNoteRouteArgs({
    this.key,
    required this.item,
  });

  final Key? key;

  final dynamic item;

  @override
  String toString() {
    return 'AddNoteRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [FavoriteView]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoryView]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OpenedNoteView]
class OpenedNoteRoute extends PageRouteInfo<OpenedNoteRouteArgs> {
  OpenedNoteRoute({
    Key? key,
    required NoteModel item,
    List<PageRouteInfo>? children,
  }) : super(
          OpenedNoteRoute.name,
          args: OpenedNoteRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'OpenedNoteRoute';

  static const PageInfo<OpenedNoteRouteArgs> page =
      PageInfo<OpenedNoteRouteArgs>(name);
}

class OpenedNoteRouteArgs {
  const OpenedNoteRouteArgs({
    this.key,
    required this.item,
  });

  final Key? key;

  final NoteModel item;

  @override
  String toString() {
    return 'OpenedNoteRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
