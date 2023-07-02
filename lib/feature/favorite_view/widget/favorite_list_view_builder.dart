import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_card/note_card_widget.dart';
import '../../../product/model/note_model.dart';
import '../../../product/routes/app_router.dart';
import '../../home_view/model/home_provider.dart';

class FavoriteListViewBuilder extends StatelessWidget {
  const FavoriteListViewBuilder({
    super.key,
    required this.context,
    required this.favoriteItems,
  });
  final BuildContext context;
  final List<NoteModel> favoriteItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        return NoteCards(
            isLastItems: index == favoriteItems.length - 1,
            item: favoriteItems[index],
            favoriteQuery:
                context.watch<HomeViewProvider>().items[index].isFavorite,
            isComeFavorite: true,
            isComeHistory: false,
            openQuery: context.read<HomeViewProvider>().cardOpenList[index],
            index: index,
            onLongPress: /*() =>
              context.read<HomeViewProvider>().longPressState(true, index),*/
                null,
            onTap: () {
              context
                  .read<HomeViewProvider>()
                  .onTapState(favoriteItems[index], index);
              context.router.replace(
                OpenedNoteRoute(
                  item: favoriteItems[index],
                ),
              );
            });
      },
    );
  }
}
