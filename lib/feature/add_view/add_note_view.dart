import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../core/init/notifier/theme_notifier.dart';
import '../../core/widgets/flushbar_widget.dart';
import '../../product/constant/duration_constant.dart';
import '../../product/constant/size_constant.dart';
import '../../product/extension/string_extension.dart';
import '../../product/lang/locale_keys.g.dart';
import '../../product/routes/app_router.dart';
import '../home_view/model/home_provider.dart';
import 'model/add_note_provider.dart';
import 'model/blend_mode_picker_provider.dart';
import 'model/canvas_picker_provider.dart';
import 'model/color_picker_provider.dart';
import 'model/font_family_picker_provider.dart';
import 'model/font_height_picker_provider.dart';
import 'model/font_size_picker_provider.dart';
import 'widget/appbar_widget/title_textfield.dart';
import 'widget/appbar_widget/title_textrich.dart';
import 'widget/bottom_appbar.dart';
import 'widget/canvas_image_widget.dart';
import 'widget/note_area_textfield.dart';
import 'widget/properties_in_switcher.dart';

@RoutePage()
class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key, required this.item});

  final dynamic item;
  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: DurationConstant.durationNormal());
    _controller.animateTo(context.read<HomeViewProvider>().isTicket ? 1 : 0);

    context.read<AddViewProvider>().initProperties(context, widget.item);
    context.read<ColorPickerProvider>().initProperties(context, widget.item);
    context.read<FontSizePickerProvider>().initProperties(context, widget.item);
    context
        .read<FontFamilyPickerProvider>()
        .initProperties(context, widget.item);
    context.read<CanvasPickerProvider>().initProperties(context, widget.item);
    context
        .read<BlendModePickerProvider>()
        .initProperties(context, widget.item);
    context
        .read<FontHeightPickerProvider>()
        .initProperties(context, widget.item);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AddViewProvider>().properties(context, 'null');
        context.read<AddViewProvider>().saveProperties(context);
        FocusManager.instance.primaryFocus?.unfocus();
        context.read<AddViewProvider>().saveNotes(context, widget.item);
        context.router.replace(const HomeRoute());
        return false;
      },
      child: Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: SafeArea(
          child: Stack(
            children: [
              const CanvasImage(),
              Scaffold(
                backgroundColor: Colors.transparent,
                bottomNavigationBar: GestureDetector(
                  onTap: () {
                    context.read<AddViewProvider>().properties(context, 'null');
                  },
                  child: const CustomBottomAppBar(),
                ),
                appBar: AppBar(
                  toolbarHeight: SizeConstant(context).height1,
                  title: Selector<AddViewProvider, bool>(
                    builder: (context, value, child) {
                      return value
                          ? const TitleTextfield()
                          : const TitleTextRich();
                    },
                    selector: (context, provider) {
                      return provider.isTitle;
                    },
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        if (!context.read<AddViewProvider>().isTicket) {
                          customFlushbar(context, LocaleKeys.saveTicket.locale);
                        }
                        _controller.animateTo(
                            context.read<AddViewProvider>().isTicket ? 0 : 1);
                        context.read<AddViewProvider>().selectedTicket();
                      },
                      icon: Lottie.asset(
                        context.watch<ThemeNotifier>().currentLottie,
                        controller: _controller,
                        width: SizeConstant(context).width05,
                        height: SizeConstant(context).width05,
                        repeat: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConstant(context).width02,
                      ),
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                          context
                              .read<AddViewProvider>()
                              .saveProperties(context);
                          FocusManager.instance.primaryFocus?.unfocus();
                          context
                              .read<AddViewProvider>()
                              .saveNotes(context, widget.item);
                          context.router.replace(const HomeRoute());
                        },
                        icon: Icon(
                          Icons.check,
                          size: SizeConstant(context).width05,
                        ),
                      ),
                    ),
                  ],
                ),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: const [
                    Scrollbar(
                      child: NoteAreaTextfield(),
                    ),
                    PropertiesInSwitcher()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
