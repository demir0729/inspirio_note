/*import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../product/constant/id_and_key_constant.dart';

class GoogleAds {
  GoogleAds._();
  static GoogleAds? _instance;
  static GoogleAds get instance {
    if (_instance != null) {
      return _instance!;
    }
    return _instance = GoogleAds._();
  }

  InterstitialAd? _interstitialAd;
  void loadInterstitialAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
        adUnitId: IdAndKeyConstant.adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            if (showAfterLoad) showInterstitialAd();
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    }
  }
}*/
