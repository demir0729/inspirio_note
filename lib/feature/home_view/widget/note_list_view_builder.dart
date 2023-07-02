import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_card/note_card_widget.dart';
import '../../../product/model/note_model.dart';
import '../../../product/routes/app_router.dart';
import '../model/home_provider.dart';

class NotesListViewBuilder extends StatelessWidget {
  const NotesListViewBuilder({
    required this.items,
    super.key,
  });
  final List<NoteModel> items;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return NoteCards(
            isLastItems: index == items.length - 1,
            item: items[index],
            isComeFavorite: false,
            isComeHistory: false,
            favoriteQuery: items[index].isFavorite,
            openQuery: context.watch<HomeViewProvider>().cardOpenList[index],
            selectedQuery:
                context.watch<HomeViewProvider>().cardSelectList[index],
            index: index,
            onLongPress: () {
              if (items[index].isHistory) return;
              context
                  .read<HomeViewProvider>()
                  .longPressState(items[index], index);
            },
            onTap: () {
              if (context.read<HomeViewProvider>().longPressed) {
                context
                    .read<HomeViewProvider>()
                    .onTapState(items[index], index);
              } else {
                if (items[index].isHistory) return;
                context.router.replace(
                  OpenedNoteRoute(
                    item: items[index],
                  ),
                );
              }
            });
      },
    );
  }
}
