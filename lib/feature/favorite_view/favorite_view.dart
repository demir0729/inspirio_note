import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'widget/favorite_list_view_builder.dart';
import '../../product/extension/string_extension.dart';
import '../../product/constant/size_constant.dart';
import '../../product/enums/views_name_enum.dart';
import '../../product/lang/locale_keys.g.dart';
import '../../product/routes/app_router.dart';
import '../home_view/model/home_provider.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeViewProvider>().itemsListGenerate(ViewsName.HOME);
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
              context.router.replace(const HomeRoute());
            },
            icon: Icon(
              Icons.chevron_left_rounded,
              size: SizeConstant(context).width055,
            ),
          ),
          title: Text(
            LocaleKeys.favorites.locale,
            style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontSize: SizeConstant(context).width05,
                ),
          ),
        ),
        body: Scrollbar(
          child: FavoriteListViewBuilder(
            context: context,
            favoriteItems: context.watch<HomeViewProvider>().items,
          ),
        ),
      ),
    );
  }
}
