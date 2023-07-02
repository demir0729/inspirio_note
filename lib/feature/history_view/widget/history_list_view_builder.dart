import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_card/note_card_widget.dart';
import '../../../product/model/note_model.dart';
import '../../home_view/model/home_provider.dart';

class HistoryListViewBuilder extends StatelessWidget {
  const HistoryListViewBuilder({
    super.key,
    required this.context,
    required this.historyItems,
  });
  final BuildContext context;
  final List<NoteModel> historyItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        return NoteCards(
          item: historyItems[index],
          isComeFavorite: false,
          isComeHistory: true,
          openQuery: context.watch<HomeViewProvider>().cardOpenList[index],
          selectedQuery:
              context.watch<HomeViewProvider>().cardSelectList[index],
          index: index,
          onLongPress: () => context
              .read<HomeViewProvider>()
              .longPressState(historyItems[index], index),
          onTap: () => context
              .read<HomeViewProvider>()
              .onTapState(historyItems[index], index),
        );
      },
    );
  }
}
