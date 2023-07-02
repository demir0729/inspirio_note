import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_show_dialog.dart';
import '../../product/constant/size_constant.dart';
import '../../product/enums/lottie_enum.dart';
import '../../product/enums/svg_enum.dart';
import '../../product/enums/views_name_enum.dart';
import '../../product/extension/lottie_extension.dart';
import '../../product/extension/string_extension.dart';
import '../../product/extension/svg_extension.dart';
import '../../product/lang/locale_keys.g.dart';
import '../../product/routes/app_router.dart';
import '../home_view/model/home_provider.dart';
import 'widget/history_list_view_builder.dart';

@RoutePage()
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeViewProvider>().itemsListGenerate(ViewsName.HOME);
        context.read<HomeViewProvider>().longPressedOff();
        context.router.replace(const HomeRoute());
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: SizeConstant(context).height1,
            leading: IconButton(
              onPressed: () {
                context
                    .read<HomeViewProvider>()
                    .itemsListGenerate(ViewsName.HOME);
                context.read<HomeViewProvider>().longPressedOff();
                context.router.replace(const HomeRoute());
              },
              icon: Icon(
                Icons.chevron_left_rounded,
                size: SizeConstant(context).width055,
              ),
            ),
            title: Text(
              LocaleKeys.trash.locale,
              style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                    fontSize: SizeConstant(context).width05,
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (context.read<HomeViewProvider>().items.isEmpty) {
                    return;
                  }
                  customShowDialog(
                    context,
                    height: SizeConstant(context).height3,
                    title: LocaleKeys.notBeUndone.locale,
                    content: context
                            .read<HomeViewProvider>()
                            .selectedItems
                            .isNotEmpty
                        ? LocaleKeys.deleteNote.locale
                        : LocaleKeys.deleteAllNote.locale,
                    confirmPress: () {
                      context.read<HomeViewProvider>().cleaningQuery();
                      context.router.pop();
                    },
                    cancelPress: () {
                      context.router.pop();
                    },
                  );
                },
                icon: Lottie.asset(
                  LottieItems.delete.getItems,
                ),
              )
            ],
          ),
          body: context.watch<HomeViewProvider>().items.isEmpty
              ? Center(
                  child: SvgPicture.asset(
                    SvgItems.empty.getItem,
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(194, 165, 165, 170),
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : Scrollbar(
                  child: HistoryListViewBuilder(
                    context: context,
                    historyItems: context.watch<HomeViewProvider>().items,
                  ),
                )),
    );
  }
}
