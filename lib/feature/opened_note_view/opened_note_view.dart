import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_button/popup_button_widget.dart';
import '../../product/constant/size_constant.dart';
import '../../product/enums/views_name_enum.dart';
import '../../product/extension/dynamic_color_extension.dart';
import '../../product/extension/img_extension.dart';
import '../../product/extension/string_extension.dart';
import '../../product/lang/locale_keys.g.dart';
import '../../product/model/note_model.dart';
import '../../product/routes/app_router.dart';
import '../home_view/model/home_provider.dart';

@RoutePage()
class OpenedNoteView extends StatefulWidget {
  const OpenedNoteView({super.key, required this.item});
  final NoteModel item;

  @override
  State<OpenedNoteView> createState() => _OpenedNoteViewState();
}

class _OpenedNoteViewState extends State<OpenedNoteView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.item.title == ''
        ? LocaleKeys.nameless.locale
        : (widget.item.title ?? LocaleKeys.nameless.locale);
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeViewProvider>().itemsListGenerate(ViewsName.HOME);
        context.router.replace(const HomeRoute());
        return false;
      },
      child: SelectionArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
                color: Color(widget.item.color.hexColor).toDynamicColor,
                size: SizeConstant(context).width055,
              ),
            ),
            backgroundColor: Color(widget.item.color.hexColor).withOpacity(0.9),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: PopupButton(
                  isComeFavorite: false,
                  isComeOpened: true,
                  icon: Icons.add,
                  alignment: Alignment.centerRight,
                  w: SizeConstant(context).width85,
                  item: widget.item,
                  isOnTap: true,
                  isDirectionLeft: true,
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Image.asset(
                widget.item.canvas.convertToImgItems.getItems,
                width: SizeConstant(context).width,
                height: SizeConstant(context).height,
                fit: BoxFit.cover,
                colorBlendMode: widget.item.blendMode.convertToBlendMode,
                color: Color(widget.item.backgroundColor.hexColor)
                    .withOpacity(widget.item.opacity),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 1,
                        color:
                            Color(widget.item.color.hexColor).toDynamicColor),
                  ),
                ),
                width: SizeConstant(context).width,
                height: SizeConstant(context).height,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0, bottom: 10),
                      child: Text(
                        widget.item.content ?? '',
                        style: TextStyle(
                          color: Color(widget.item.color.hexColor),
                          fontSize: widget.item.fontSize,
                          fontFamily: widget.item.fontFamily.split('-').first,
                          height: widget.item.fontHeight,
                        ),
                        textAlign: widget.item.isTextCenter
                            ? TextAlign.center
                            : TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
