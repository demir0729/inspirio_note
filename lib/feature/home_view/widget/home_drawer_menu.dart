import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/init/notifier/theme_notifier.dart';
import '../../../core/widgets/custom_card/drawer_card.dart';
import '../../../product/constant/duration_constant.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/enums/app_theme_enum.dart';
import '../../../product/enums/svg_enum.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/extension/svg_extension.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../model/home_provider.dart';
import 'drawer_items_widgets.dart';

class HomeDrawerMenu extends StatefulWidget {
  const HomeDrawerMenu({
    super.key,
  });

  @override
  State<HomeDrawerMenu> createState() => _HomeDrawerMenuState();
}

class _HomeDrawerMenuState extends State<HomeDrawerMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
      width: SizeConstant(context).width7,
      child: ListView(
        physics: const ScrollPhysics(),
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Card(
              elevation: 8,
              color: context.watch<ThemeNotifier>().drawerBackColor,
              margin: EdgeInsets.zero,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AnimatedSwitcher(
                  duration: DurationConstant.duration500(),
                  child: SvgPicture.asset(
                    context.watch<ThemeNotifier>().currentDrawerBack,
                    colorFilter: ColorFilter.mode(
                      context.watch<ThemeNotifier>().drawerSvgColor,
                      BlendMode.srcIn,
                    ),
                    key: ValueKey(
                        context.watch<ThemeNotifier>().currentDrawerBack),
                  ),
                ),
              ),
            ),
          ),
          const ThemesDrawerItem(),
          AnimatedSize(
            duration: DurationConstant.duration500(),
            curve: Curves.easeInOut,
            child: Container(
              height: context.watch<HomeViewProvider>().isthemeContainer
                  ? (SizeConstant(context).height07 * 4) + 33
                  : 1,
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              child: context.watch<HomeViewProvider>().isthemeContainer
                  ? Column(
                      children: [
                        DrawerCard(
                          onTap: () {
                            context
                                .read<ThemeNotifier>()
                                .changeTheme(AppThemes.whitelight.name);
                          },
                          title: LocaleKeys.whiteTheme.locale,
                          iconPath: SvgItems.lotus.getItem,
                        ),
                        DrawerCard(
                          onTap: () {
                            context
                                .read<ThemeNotifier>()
                                .changeTheme(AppThemes.ravenblack.name);
                          },
                          title: LocaleKeys.ravenTheme.locale,
                          iconPath: SvgItems.raven.getItem,
                        ),
                        DrawerCard(
                          onTap: () {
                            context
                                .read<ThemeNotifier>()
                                .changeTheme(AppThemes.owlnight.name);
                          },
                          title: LocaleKeys.owlTheme.locale,
                          iconPath: SvgItems.owl.getItem,
                        ),
                        DrawerCard(
                          onTap: () {
                            context
                                .read<ThemeNotifier>()
                                .changeTheme(AppThemes.foxwedding.name);
                          },
                          title: LocaleKeys.foxTheme.locale,
                          iconPath: SvgItems.fox.getItem,
                        ),
                      ],
                    )
                  : null,
            ),
          ),
          const HistoryDrawerItem(),
          Divider(
            height: 0,
            color: Theme.of(context).primaryColor.withOpacity(0.6),
          ),
          const CardColorSwitchDrawerItem(),
        ],
      ),
    );
  }
}
