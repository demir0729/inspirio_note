import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../feature/home_view/model/home_provider.dart';
import '../../../product/constant/color_constants.dart';
import '../../../product/constant/duration_constant.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/extension/dynamic_color_extension.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/model/note_model.dart';
import '../../animations/transition_animation.dart';
import '../../init/notifier/theme_notifier.dart';
import '../custom_button/popup_button_widget.dart';

class NoteCards extends StatelessWidget {
  const NoteCards({
    required this.index,
    required this.openQuery,
    required this.isComeHistory,
    required this.isComeFavorite,
    required this.item,
    super.key,
    this.onLongPress,
    this.onTap,
    this.selectedQuery,
    this.favoriteQuery,
    this.isLastItems,
  });
  final int index;
  final void Function()? onLongPress;
  final void Function()? onTap;
  final bool? selectedQuery;
  final bool openQuery;
  final bool? favoriteQuery;
  final bool isComeHistory;
  final bool isComeFavorite;
  final NoteModel item;
  final bool? isLastItems;
  @override
  Widget build(BuildContext context) {
    Color color = Color(item.color.hexColor);
    String content = item.content?.toCardShort(
            MediaQuery.of(context).size.width, false, openQuery) ??
        '';
    String title = item.title
            ?.toCardShort(MediaQuery.of(context).size.width, true, openQuery) ??
        '';
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(30),
        ),
      ),
      color: context.watch<HomeViewProvider>().cardSelectList[index]
          ? ColorConstants.selectedColor
          : (context.watch<HomeViewProvider>().isSwitch
                  ? Color(item.color.hexColor)
                  : Theme.of(context).cardColor)
              .withOpacity(0.8),
      child: InkWell(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(30),
        ),
        onLongPress: onLongPress,
        onTap: onTap,
        child: AnimatedSize(
          alignment: Alignment.topCenter,
          reverseDuration: const Duration(milliseconds: 1),
          duration: (content.length) > 40
              ? DurationConstant.duration1000()
              : DurationConstant.duration500(),
          curve: Curves.fastOutSlowIn,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTopBarWidget(
                isLastItems: isLastItems,
                isComeFavorite: isComeFavorite,
                index: index,
                openQuery: openQuery,
                favoriteQuery: favoriteQuery ?? false,
                isComeHistory: isComeHistory,
                item: item,
              ),
              _title(context, title, color, openQuery),
              CardContentWidget(
                content: content,
                color: color,
                openQuery: openQuery,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContentWidget extends StatelessWidget {
  const CardContentWidget({
    super.key,
    required this.content,
    required this.color,
    required this.openQuery,
  });
  final String content;
  final Color color;
  final bool openQuery;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 10.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 5,
            color: context.watch<HomeViewProvider>().isSwitch
                ? color.toDynamicColor
                : Theme.of(context).dividerColor,
          ),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: SizeConstant(context).height025,
                color: context.watch<HomeViewProvider>().isSwitch
                    ? color.toDynamicColor
                    : context.watch<ThemeNotifier>().contentTextColor),
          ),
        ],
      ),
    );
  }
}

IconButton _restoreIcon(
    BuildContext context, NoteModel item, bool isComeFromHistory) {
  return IconButton(
    onPressed: () {
      context.read<HomeViewProvider>().restoreItems(item, isComeFromHistory);
    },
    icon: Icon(Icons.restore,
        color: context.watch<HomeViewProvider>().isSwitch
            ? Color(item.color.hexColor).toDynamicColor
            : ColorConstants.ravenBlack,
        size: SizeConstant(context).width055),
  );
}

IconButton _favoriteIcon({
  required BuildContext context,
  required NoteModel item,
  required bool favoriteQuery,
  required bool isComeFavorite,
}) {
  return IconButton(
    onPressed: () {
      context
          .read<HomeViewProvider>()
          .favoriteItemCardState(item, isComeFavorite);
    },
    icon: AnimatedSwitcher(
      switchInCurve: Curves.bounceIn,
      duration: DurationConstant.duration275(),
      transitionBuilder: (child, anim) => CustomScaleAnimation(
        anim: anim,
        child: child,
      ),
      child: favoriteQuery
          ? Icon(Icons.favorite,
              key: const ValueKey('openArrow'),
              color: context.watch<HomeViewProvider>().isSwitch
                  ? Color(item.color.hexColor).toDynamicColor
                  : ColorConstants.ravenBlack,
              size: SizeConstant(context).width055)
          : Icon(Icons.favorite_border,
              key: const ValueKey('closeArrow'),
              color: context.watch<HomeViewProvider>().isSwitch
                  ? Color(item.color.hexColor).toDynamicColor
                  : ColorConstants.ravenBlack,
              size: SizeConstant(context).width055),
    ),
  );
}

Padding _title(
  BuildContext context,
  String title,
  Color color,
  bool openQuery,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, top: 20),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: SizeConstant(context).height027,
          color: context.watch<HomeViewProvider>().isSwitch
              ? color.toDynamicColor
              : context.watch<ThemeNotifier>().contentTextColor),
      key: const ValueKey('closeTitle'),
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
      ),
    ),
  );
}

class CardTopBarWidget extends StatelessWidget {
  const CardTopBarWidget({
    super.key,
    required this.index,
    required this.openQuery,
    required this.favoriteQuery,
    required this.isComeHistory,
    required this.isComeFavorite,
    required this.item,
    this.isLastItems,
  });
  final int index;
  final bool openQuery;
  final bool favoriteQuery;
  final bool isComeHistory;
  final bool isComeFavorite;
  final NoteModel item;
  final bool? isLastItems;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(25),
            ),
          ),
          elevation: 3,
          color: (context.watch<HomeViewProvider>().isSwitch
                  ? Color(item.color.hexColor)
                  : Theme.of(context).cardColor)
              .withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _date(context),
                Container(
                  margin: EdgeInsets.only(
                    left: SizeConstant(context).width03,
                  ),
                  color: context.watch<HomeViewProvider>().isSwitch
                      ? Color(item.color.hexColor).toDynamicColor
                      : ColorConstants.ravenBlack,
                  width: MediaQuery.of(context).size.width > 1000 ? 2 : 1,
                  height: SizeConstant(context).height03,
                ),
                IgnorePointer(
                  ignoring: context.watch<HomeViewProvider>().longPressed,
                  child: item.isHistory
                      ? _restoreIcon(context, item, isComeHistory)
                      : _favoriteIcon(
                          context: context,
                          item: item,
                          favoriteQuery: favoriteQuery,
                          isComeFavorite: isComeFavorite,
                        ),
                )
              ],
            ),
          ),
        ),
        PopupButton(
          isComeFavorite: isComeFavorite,
          isLastItems: isLastItems,
          isComeOpened: false,
          index: index,
          icon: Icons.keyboard_arrow_right_outlined,
          w: SizeConstant(context).width5,
          item: item,
          isOnTap: false,
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  Padding _date(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Text(
        item.date,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.watch<HomeViewProvider>().isSwitch
                  ? Color(item.color.hexColor).toDynamicColor
                  : ColorConstants.ravenBlack,
              fontSize: SizeConstant(context).height020,
            ),
      ),
    );
  }
}
