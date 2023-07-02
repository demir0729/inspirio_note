import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_button/dropdown_arrow_icon.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/enums/views_name_enum.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../../../product/routes/app_router.dart';
import '../model/home_provider.dart';

class ThemesDrawerItem extends StatelessWidget {
  const ThemesDrawerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeViewProvider>().themeContainerChange();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstant(context).height03,
        ),
        height: SizeConstant(context).height1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: SizeConstant(context).height03,
                  ),
                  child: Icon(
                    Icons.color_lens_outlined,
                    size: SizeConstant(context).width055,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                ),
                Text(
                  LocaleKeys.themes.locale,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: SizeConstant(context).height025,
                      ),
                ),
              ],
            ),
            DropDownArrowIcon(
              query: context.watch<HomeViewProvider>().isthemeContainer,
              isNoteCard: false,
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryDrawerItem extends StatelessWidget {
  const HistoryDrawerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeViewProvider>().itemsListGenerate(ViewsName.HISTORY);
        context.read<HomeViewProvider>().longPressedOff();
        context.router.replace(const HistoryRoute());
      },
      child: Container(
        padding: EdgeInsets.only(left: SizeConstant(context).height03),
        height: SizeConstant(context).height1,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: SizeConstant(context).height03,
              ),
              child: Icon(
                Icons.history,
                size: SizeConstant(context).width055,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            Text(
              LocaleKeys.trash.locale,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: SizeConstant(context).height025
                      // MediaQuery.of(context).size.height * 0.025,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}



class CardColorSwitchDrawerItem extends StatelessWidget {
  const CardColorSwitchDrawerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeViewProvider>().changeSwitch();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.03),
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.showCardColor.locale,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.titleMedium?.color,
                    fontSize: MediaQuery.of(context).size.height * 0.020,
                  ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.08,
              child: FittedBox(
                child: Switch(
                  value: context.watch<HomeViewProvider>().isSwitch,
                  onChanged: (value) {
                    context.read<HomeViewProvider>().changeSwitch();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
