import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../feature/add_view/add_note_view.dart';
import '../../feature/favorite_view/favorite_view.dart';
import '../../feature/history_view/history_view.dart';
import '../../feature/home_view/home_view.dart';
import '../../feature/opened_note_view/opened_note_view.dart';
import '../../feature/splash/splash_view.dart';
import '../model/note_model.dart';
part 'app_router.gr.dart';


@AutoRouterConfig(
  replaceInRouteName: 'View,Route',
)
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = <AutoRoute>[
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: FavoriteRoute.page, path: '/favorite'),
    AutoRoute(page: HistoryRoute.page, path: '/history'),
    AutoRoute(page: OpenedNoteRoute.page, path: '/opened'),
    AutoRoute(page: AddNoteRoute.page, path: '/addNote'),
    AutoRoute(page: SplashRoute.page, path: '/splash'),

  ];
}

class HomeBox extends AutoRouter {
  const HomeBox({super.key});
}

/*
replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: DashboardView,
      initial: true,
      children: [
        AutoRoute(
          page: HomeBox,
          name: 'HomeBoxRoute',
          initial: true,
          children: [
            AutoRoute(page: HomeView, initial: true, path: 'home'),
            AutoRoute(page: AddNoteView, path: 'addNote'),
            AutoRoute(page: SearchView, path: 'search'),
            AutoRoute(page: HistoryView, path: 'history'),
            AutoRoute(page: FavoriteView, path: 'favorite'),
            AutoRoute(page: OpenedNoteView, path: 'openedView'),
          ],
        ),
      ],
    ),
  ], */
