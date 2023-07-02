import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../core/animations/transition_animation.dart';
import '../../product/constant/duration_constant.dart';
import '../../product/constant/size_constant.dart';
import '../../product/enums/lottie_enum.dart';
import '../../product/enums/views_name_enum.dart';
import '../../product/extension/lottie_extension.dart';
import '../../product/routes/app_router.dart';
import 'model/home_provider.dart';
import 'widget/floating_action__button.dart';
import 'widget/home_drawer_menu.dart';
import 'widget/note_list_view_builder.dart';
import 'widget/search_textfield_widget.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final res =
            context.read<HomeViewProvider>().searchController.text.isNotEmpty;
        if (res) {
          context.read<HomeViewProvider>().searchController.clear();
          FocusManager.instance.primaryFocus?.unfocus();
          context.read<HomeViewProvider>().itemsListGenerate(ViewsName.HOME);
          return false;
        }
        return true;
      },
      child: Scaffold(
          floatingActionButton: const SpesificFloatingActionButton(),
          resizeToAvoidBottomInset: false,
          onDrawerChanged: (isOpened) {
            FocusManager.instance.primaryFocus?.unfocus();
            if (!isOpened) {
              context.read<HomeViewProvider>().themeContainerOff();
            }
          },
          drawer: const HomeDrawerMenu(),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Icon(
                    Icons.menu,
                    size: SizeConstant(context).width05,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            toolbarHeight: SizeConstant(context).height1,
            title: const SearchTextfield(),
            actions: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.search_outlined,
                  color:
                      Theme.of(context).inputDecorationTheme.hintStyle?.color,
                  size: SizeConstant(context).width05,
                ),
              ),
              AnimatedSwitcher(
                transitionBuilder: (child, anim) =>
                    CustomFadeAnimation(anim: anim, child: child),
                duration: DurationConstant.duration500(),
                child: context.watch<HomeViewProvider>().longPressed
                    ? IconButton(
                        onPressed: () {
                          context
                              .read<HomeViewProvider>()
                              .addSelectedITemsToHistory();
                        },
                        icon: Icon(
                          Icons.delete_outlined,
                          size: SizeConstant(context).width05,
                        ),
                      )
                    : IconButton(
                        key: const ValueKey('icon2'),
                        onPressed: () {
                          context
                              .read<HomeViewProvider>()
                              .itemsListGenerate(ViewsName.FAVORITE);
                          context.router.replace(const FavoriteRoute());
                        },
                        icon: Icon(
                          Icons.favorite_outline_outlined,
                          size: SizeConstant(context).width05,
                        ),
                      ),
              ),
            ],
          ),
          body: context.watch<HomeViewProvider>().items.isEmpty
              ? Center(
                  child: Lottie.asset(
                    LottieItems.adddoc.getItems,
                    width: SizeConstant(context).width35,
                  ),
                )
              : Scrollbar(
                  child: NotesListViewBuilder(
                    items: context.watch<HomeViewProvider>().items,
                  ),
                )),
    );
  }
}
