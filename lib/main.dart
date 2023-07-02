import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/core/pdf/manager.dart';
import 'package:my_notes/feature/add_view/model/blend_mode_picker_provider.dart';
import 'package:my_notes/feature/add_view/model/canvas_picker_provider.dart';
import 'package:my_notes/feature/add_view/model/font_height_picker_provider.dart';
import 'package:sizer/sizer.dart';
import 'core/init/application_init.dart';
import 'feature/add_view/model/font_family_picker_provider.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'feature/add_view/model/add_note_provider.dart';
import 'feature/add_view/model/color_picker_provider.dart';
import 'feature/add_view/model/font_size_picker_provider.dart';
import 'feature/home_view/model/home_provider.dart';
import 'product/constant/app_constant.dart';
import 'product/lang/language_manager.dart';
import 'product/routes/app_router.dart';

Future<void> main(List<String> args) async {
  await ApplicationInit.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddViewProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => PdfAndJpgManager(),
        ),
        ChangeNotifierProvider(
          create: (context) => ColorPickerProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => FontSizePickerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FontFamilyPickerProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => CanvasPickerProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => BlendModePickerProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => FontHeightPickerProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeNotifier(),
        ),
      ],
      builder: (context, child) => EasyLocalization(
        fallbackLocale: LanguageManager.instance.enLocale,
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstant.LANG_ASSET_PATH,
        child: const MyApp(),
      ),
    ),
  );
}

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        title: 'Inspirio Note',
        theme: context.watch<ThemeNotifier>().currentTheme,
        routerDelegate: _appRouter.delegate(
          //initialRoutes: [const SplashRoute()],
          deepLinkBuilder: (deepLink) => const DeepLink(
            [SplashRoute()],
          ),
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.deviceLocale,
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
