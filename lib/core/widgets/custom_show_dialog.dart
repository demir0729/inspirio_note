import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../feature/home_view/model/home_provider.dart';
import '../../product/constant/color_constants.dart';
import '../../product/constant/size_constant.dart';
import '../../product/enums/lottie_enum.dart';
import '../../product/enums/quality_enum.dart';
import '../../product/enums/views_name_enum.dart';
import '../../product/extension/lottie_extension.dart';
import '../../product/extension/string_extension.dart';
import '../../product/lang/locale_keys.g.dart';
import '../../product/model/note_model.dart';
import '../../product/routes/app_router.dart';
import '../init/notifier/theme_notifier.dart';
import '../pdf/manager.dart';

Future<dynamic> customShowDialog(
  BuildContext context, {
  final String? title,
  final String? content,
  required void Function() confirmPress,
  required void Function() cancelPress,
  final String? confirmPressTitle,
  final String? cancelPressTitle,
  final double? height,
}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: context.watch<ThemeNotifier>().mainThemeLayerColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        height: height ?? SizeConstant(context).height45,
        width: SizeConstant(context).width9,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10.0, right: 10, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: !(title == null || title.isEmpty),
                child: Text(
                  title ?? '',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: SizeConstant(context).width04,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                content ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).textTheme.labelLarge?.color,
                      fontSize: SizeConstant(context).width035,
                    ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cancelPressTitle == null
                      ? SizedBox(
                          width: SizeConstant(context).width1,
                          child: FittedBox(
                            child: FloatingActionButton(
                              onPressed: cancelPress,
                              child: Icon(
                                Icons.close,
                                color: context
                                    .watch<ThemeNotifier>()
                                    .mainThemeLayerColor,
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: ColorConstants.ravenBlack,
                          ),
                          onPressed: cancelPress,
                          child: Text(
                            cancelPressTitle,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: ColorConstants.cuteBlue,
                                  fontSize: SizeConstant(context).width035,
                                ),
                          ),
                        ),
                  confirmPressTitle == null
                      ? SizedBox(
                          width: SizeConstant(context).width1,
                          child: FittedBox(
                            child: FloatingActionButton(
                              onPressed: confirmPress,
                              child: Icon(
                                Icons.check,
                                color: context
                                    .watch<ThemeNotifier>()
                                    .mainThemeLayerColor,
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: ColorConstants.ravenBlack,
                          ),
                          onPressed: confirmPress,
                          child: Text(
                            confirmPressTitle,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: ColorConstants.cuteBlue,
                                  fontSize: SizeConstant(context).width035,
                                ),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> downloadJpgShowDialog(
  BuildContext context, {
  required NoteModel item,
  required RewardedAd rewardedAd,
}) {
  void showRewardedAd() {
    rewardedAd.show(
      onUserEarnedReward: (ad, reward) {},
    );
  }

  ValueNotifier<JpgQualities> qualities = ValueNotifier(JpgQualities.max);
  double quality = 6;
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: context.watch<ThemeNotifier>().drawerBackColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        height: SizeConstant(context).height45,
        width: SizeConstant(context).width9,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10.0, right: 10, left: 10),
          child: ValueListenableBuilder(
            valueListenable: qualities,
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.chooseQuality.locale,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                fontSize: SizeConstant(context).width04,
                                color: Theme.of(context).colorScheme.background,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          if (context
                              .read<PdfAndJpgManager>()
                              .isJpgLoading
                              .value) return;
                          context.router.pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.background,
                          size: SizeConstant(context).width05,
                        ))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: RadioListTile<JpgQualities>(
                          visualDensity: VisualDensity.compact,
                          secondary: Lottie.asset(
                            LottieItems.play.getItems,
                          ),
                          title: Text(
                            LocaleKeys.highQuality.locale,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontSize: SizeConstant(context).width04,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          activeColor: Theme.of(context).colorScheme.background,
                          value: JpgQualities.max,
                          groupValue: value,
                          onChanged: (value) {
                            qualities.value = value!;
                            quality = 6;
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: RadioListTile<JpgQualities>(
                          visualDensity: VisualDensity.compact,
                          title: Text(
                            LocaleKeys.normalQuality.locale,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  fontSize: SizeConstant(context).width04,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          activeColor: Theme.of(context).colorScheme.background,
                          value: JpgQualities.min,
                          groupValue: value,
                          onChanged: (value) {
                            qualities.value = value!;
                            quality = 2;
                          }),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                    valueListenable:
                        context.watch<PdfAndJpgManager>().isJpgLoading,
                    builder: (context, value, child) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              minimumSize: Size(
                                SizeConstant(context).width9,
                                SizeConstant(context).height09,
                              )),
                          onPressed: () async {
                            if (value) return;

                            if (quality == 6) {
                              showRewardedAd();
                            }
                            await context.read<PdfAndJpgManager>().createPdf(
                                  item,
                                  context,
                                  isConvertJpg: true,
                                  quality: quality,
                                );
                            if (context.mounted) {
                              context
                                  .read<HomeViewProvider>()
                                  .itemsListGenerate(ViewsName.HOME);
                              context.router.replace(const HomeRoute());
                            }
                          },
                          child: !value
                              ? Text(
                                  LocaleKeys.saveAsJpg.locale,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        fontSize:
                                            SizeConstant(context).width035,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .color,
                                      ),
                                )
                              : Column(
                                  children: [
                                    Text(
                                      LocaleKeys.converting.locale,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize:
                                                SizeConstant(context).width035,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .color,
                                          ),
                                    ),
                                    Text(
                                      LocaleKeys.patience.locale,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize:
                                                SizeConstant(context).width03,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .color,
                                          ),
                                    ),
                                  ],
                                ),
                        )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> downloadPdfShowDialog(BuildContext context, NoteModel item) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: context.watch<ThemeNotifier>().drawerBackColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        height: SizeConstant(context).height5,
        width: SizeConstant(context).width9,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10.0, right: 10, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.pdf.locale,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: SizeConstant(context).width04,
                              color: Theme.of(context).colorScheme.background,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        if (context
                            .read<PdfAndJpgManager>()
                            .isPdfLoading
                            .value) {
                          return;
                        }
                        context.router.pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.background,
                        size: SizeConstant(context).width05,
                      ))
                ],
              ),
              Text(
                LocaleKeys.pdfContent.locale,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: SizeConstant(context).width03,
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
              ValueListenableBuilder(
                  valueListenable:
                      context.watch<PdfAndJpgManager>().isPdfLoading,
                  builder: (context, value, child) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            minimumSize: Size(
                              SizeConstant(context).width9,
                              SizeConstant(context).height09,
                            )),
                        onPressed: () async {
                          if (value) return;
                          await context.read<PdfAndJpgManager>().createPdf(
                                item,
                                context,
                                isConvertJpg: false,
                                quality: 2,
                              );
                          if (context.mounted) {
                            context.router.pop();
                          }
                        },
                        child: !value
                            ? Text(
                                LocaleKeys.convertPdf.locale,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      fontSize: SizeConstant(context).width035,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .color,
                                    ),
                              )
                            : Column(
                                children: [
                                  Text(
                                    LocaleKeys.converting.locale,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize:
                                              SizeConstant(context).width035,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color,
                                        ),
                                  ),
                                  Text(
                                    LocaleKeys.patience.locale,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize:
                                              SizeConstant(context).width03,
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                      )),
            ],
          ),
        ),
      ),
    ),
  );
}
