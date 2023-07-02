import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/constant/size_constant.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../model/home_provider.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: TextField(
        cursorColor: Theme.of(context).inputDecorationTheme.hintStyle?.color,
        controller: context.watch<HomeViewProvider>().searchController,
        onChanged: (value) {
          context.read<HomeViewProvider>().totalValuesInItems(value);
        },
        decoration: InputDecoration(
          hintText: LocaleKeys.search.locale,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                fontSize: SizeConstant(context).width05,
              ),
          border: InputBorder.none,
        ),
        style: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
              fontSize: SizeConstant(context).width05,
            ),
      ),
    );
  }
}
