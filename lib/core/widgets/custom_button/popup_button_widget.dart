import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../feature/home_view/model/home_provider.dart';
import '../../../product/constant/color_constants.dart';
import '../../../product/constant/duration_constant.dart';
import '../../../product/constant/id_and_key_constant.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/enums/svg_enum.dart';
import '../../../product/extension/dynamic_color_extension.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/extension/svg_extension.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../../../product/model/note_model.dart';
import '../../../product/routes/app_router.dart';
import '../../pdf/manager.dart';
import '../../services/network_manager.dart';
import '../custom_show_dialog.dart';
import '../flushbar_widget.dart';
import 'popup_icon_widget.dart';

class PopupButton extends StatefulWidget {
  const PopupButton({
    super.key,
    required this.w,
    required this.item,
    required this.isOnTap,
    required this.alignment,
    required this.icon,
    required this.isComeOpened,
    required this.isComeFavorite,
    this.isLastItems,
    this.index,
    this.isDirectionLeft,
  });
  final double w;
  final NoteModel item;
  final bool isOnTap;
  final AlignmentGeometry alignment;
  final IconData icon;
  final bool? isDirectionLeft;
  final bool isComeOpened;
  final bool isComeFavorite;
  final bool? isLastItems;
  final int? index;
  @override
  State<PopupButton> createState() => _PopupButtonState();
}

class _PopupButtonState extends State<PopupButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (widget.isComeOpened) {
      _loadRewardedAd();
    }
    /*_googleAds = GoogleAds.instance;
    _googleAds.loadInterstitialAd();*/

    if (widget.isDirectionLeft ?? false) {
      alignment1 = const Alignment(1.0, 0.0);
      alignment2 = const Alignment(1.0, 0.0);
      alignment3 = const Alignment(1.0, 0.0);
      alignment4 = const Alignment(1.0, 0.0);
      alignment5 = const Alignment(1.0, 0.0);
    } else {
      alignment1 = const Alignment(-1.0, 0.0);
      alignment2 = const Alignment(-1.0, 0.0);
      alignment3 = const Alignment(-1.0, 0.0);
      alignment4 = const Alignment(-1.0, 0.0);
      alignment5 = const Alignment(-1.0, 0.0);
    }
    if (widget.isOnTap) {
      elevation = 0;
      radius = 20;
      angle = 4;
    } else {
      elevation = 3;
      radius = 12;
      angle = 3;
    }
    _controller = AnimationController(
      vsync: this,
      duration: DurationConstant.duration275(),
      reverseDuration: DurationConstant.duration275(),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller;
    _animation;
    super.dispose();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: IdAndKeyConstant.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
          _setFullScreenContentCallBack();
        },
        onAdFailedToLoad: (ad) {
          rewardedAd = null;
        },
      ),
    );
  }

  void _setFullScreenContentCallBack() {
    if (rewardedAd == null) return;
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {},
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) {},
    );
  }

  bool toggle = true;
  late final AnimationController _controller;
  late final Animation _animation;
  late Alignment alignment1;
  late Alignment alignment2;
  late Alignment alignment3;
  late Alignment alignment4;
  late Alignment alignment5;
  late final double elevation;
  late final double radius;
  late final double angle;
  late final RewardedAd? rewardedAd;
  NoteModel? findedhomeItem;
  NoteModel? findedFavItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
              visible: !(widget.item.isHistory || !widget.isComeOpened),
              child: PopupIcon(
                isComeOpened: widget.isComeOpened,
                toggle: toggle,
                alignment: alignment1,
                size: SizeConstant(context).height057,
                color: Color(widget.item.color.hexColor),
                svgItem: SvgItems.pdf.getItem,
                onTap: () async {
                  await downloadPdfShowDialog(context, widget.item);
                },
              )),
          ValueListenableBuilder(
            valueListenable: context.watch<PdfAndJpgManager>().isJpgIconLoading,
            builder: (context, value, child) => Visibility(
              visible: !(widget.item.isHistory || !widget.isComeOpened),
              child: !value
                  ? PopupIcon(
                      isComeOpened: widget.isComeOpened,
                      toggle: toggle,
                      alignment: alignment2,
                      size: SizeConstant(context).height057,
                      color: Color(widget.item.color.hexColor),
                      svgItem: SvgItems.download.getItem,
                      onTap: () async {
                        if (!(await NetworkManager.isConnected)) {
                          if (context.mounted) {
                            await customFlushbar(
                                context, LocaleKeys.connectionErr.locale);
                          }
                          return;
                        }
                        try {
                          if (context.mounted) {
                            await downloadJpgShowDialog(
                              context,
                              item: widget.item,
                              rewardedAd: rewardedAd!,
                            );
                          }
                        } catch (e) {
                          try {
                            if (context.mounted) {
                              await context
                                  .read<PdfAndJpgManager>()
                                  .changeJpgIconLoading();
                            }
                            if (context.mounted) {
                              await downloadJpgShowDialog(
                                context,
                                item: widget.item,
                                rewardedAd: rewardedAd!,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              customFlushbar(
                                  context, LocaleKeys.connectionErr.locale);
                            }
                          }
                        }
                      },
                    )
                  : Align(
                      alignment: alignment2,
                      child: SizedBox(
                          width: SizeConstant(context).width05,
                          height: SizeConstant(context).width05,
                          child: CircularProgressIndicator(
                            color: widget.isComeOpened
                                ? Color(widget.item.color.hexColor)
                                    .toDynamicColor
                                : (context.watch<HomeViewProvider>().isSwitch
                                    ? Color(widget.item.color.hexColor)
                                        .toDynamicColor
                                    : ColorConstants.ravenBlack),
                            strokeWidth: 1.5,
                          )),
                    ),
            ),
          ),
          Visibility(
            visible: !(widget.item.isHistory),
            child: PopupIcon(
              isComeOpened: widget.isComeOpened,
              toggle: toggle,
              color: Color(widget.item.color.hexColor),
              alignment: alignment3,
              size: SizeConstant(context).height057,
              svgItem: SvgItems.copy.getItem,
              onTap: () async {
                await Clipboard.setData(
                        ClipboardData(text: widget.item.content ?? ''))
                    .then((value) => customFlushbar(
                        context, LocaleKeys.copyClipboard.locale));
              },
            ),
          ),
          Visibility(
            visible: !(widget.item.isHistory),
            child: PopupIcon(
              isComeOpened: widget.isComeOpened,
              toggle: toggle,
              alignment: alignment4,
              size: SizeConstant(context).height057,
              color: Color(widget.item.color.hexColor),
              svgItem: SvgItems.quillpage.getItem,
              onTap: () {
                context.router.replace(
                  AddNoteRoute(
                    item: widget.item,
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: !(widget.item.isHistory ||
                widget.isComeFavorite ||
                (context
                    .watch<HomeViewProvider>()
                    .searchController
                    .text
                    .isNotEmpty)),
            child: PopupIcon(
              isComeOpened: widget.isComeOpened,
              toggle: toggle,
              color: Color(widget.item.color.hexColor),
              alignment: alignment5,
              size: SizeConstant(context).height057,
              svgItem: SvgItems.trash.getItem,
              onTap: () async {
                customShowDialog(
                  context,
                  height: SizeConstant(context).height3,
                  content: LocaleKeys.carryToTrash.locale,
                  confirmPress: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await context
                        .read<HomeViewProvider>()
                        .selectedItemState(widget.item, widget.index ?? 0);
                    if (context.mounted) {
                      await context
                          .read<HomeViewProvider>()
                          .addSelectedITemsToHistory();
                    }
                    if (!((widget.isLastItems ?? true) ||
                        widget.isComeOpened)) {
                      _toggleAnimation();
                    }
                    if (widget.isComeOpened) {
                      if (!mounted) return;
                      context.router.replace(const HomeRoute());
                    }
                    if (context.mounted) {
                      await context.router.pop();
                    }
                  },
                  cancelPress: () async {
                    await context.router.pop();
                  },
                );
              },
            ),
          ),
          Align(
            alignment: widget.alignment,
            child: Transform.rotate(
              angle: _animation.value * pi * (3 / angle),
              child: AnimatedContainer(
                duration: DurationConstant.duration275(),
                curve: Curves.easeOut,
                child: IconButton(
                  onPressed: () {
                    context
                        .read<HomeViewProvider>()
                        .openItemCardStatePro(widget.index ?? 0);
                    _toggleAnimation();
                  },
                  icon: Icon(
                    widget.icon,
                    size: SizeConstant(context).height035,
                    color: widget.isComeOpened
                        ? Color(widget.item.color.hexColor).toDynamicColor
                        : (context.watch<HomeViewProvider>().isSwitch
                            ? Color(widget.item.color.hexColor).toDynamicColor
                            : ColorConstants.ravenBlack),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleAnimation() {
    setState(() {
      if (toggle) {
        toggle = !toggle;
        _controller.forward();

        Future.delayed(DurationConstant.duration275(), () {
          setState(() {
            if (widget.isDirectionLeft ?? false) {
              alignment1 = const Alignment(-0.6, 0.0);
              alignment2 = const Alignment(-0.3, 0.0);
              alignment3 = const Alignment(0.0, 0.0);
              alignment4 = const Alignment(0.3, 0.0);
              alignment5 = const Alignment(0.6, 0.0);
            } else {
              alignment4 = const Alignment(0.8, 0.0);
              alignment3 = const Alignment(0.3, 0.0);
              alignment5 = const Alignment(-0.2, 0.0);
            }
          });
        });
      } else {
        toggle = !toggle;
        _controller.reverse();

        if (widget.isDirectionLeft ?? false) {
          alignment1 = const Alignment(1.0, 0.0);
          alignment2 = const Alignment(1.0, 0.0);
          alignment3 = const Alignment(1.0, 0.0);
          alignment4 = const Alignment(1.0, 0.0);
          alignment5 = const Alignment(1.0, 0.0);
        } else {
          alignment4 = const Alignment(-1.0, 0.0);
          alignment5 = const Alignment(-1.0, 0.0);
          alignment3 = const Alignment(-1.0, 0.0);
        }
      }
    });
  }
}
