import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../product/constant/color_constants.dart';
import '../../product/enums/lottie_enum.dart';
import '../../product/extension/lottie_extension.dart';
import '../../product/constant/size_constant.dart';
import '../../product/routes/app_router.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (context.mounted) {
      context.router.replace(const HomeRoute());
    }
    //await DefaultCacheManager().emptyCache();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.ravenBlack,
        body: Center(
          child: SizedBox(
            width: SizeConstant(context).width3,
            height: SizeConstant(context).height3,
            child: Lottie.asset(
              LottieItems.write.getItems,
            ),
          ),
        ),
      ),
    );
  }
}
