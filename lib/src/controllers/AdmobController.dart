import 'dart:io';
// import 'dart:js_interop';
// import 'dart:js_interop';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:logger/logger.dart';

import '../../MyAdmob.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const TEST = false;

class AdmobController extends GetxController {
  // AdmobInterstitial interstitialAd;
  // late InterstitialAd interstitialAd;

  // late AppOpenAd appOpenAd;
  final db = FirebaseFirestore.instance;
  MyAdmob admobConfig = MyAdmob();
  bool showAd = false;

  // final bannerController = BannerAdController();

  AppOpenAd? appOpenAd;
  bool _isShowingAd = false;
  String adUnitId = '0';
  Logger logger = Logger();

  @override
  void onInit() async {
    super.onInit();

    adUnitId = admobConfig.getOpenAdId()!;
    await readAdsFromFirebase();
    logger.v("adUnitId => $adUnitId ");

    //if show is true then show the add
   
    logger.v("showad: $showAd");
    logger.i("ADMOB CONTROLLER STARTED");
  }

  void onClose() {
    // bannerController.dispose();
  }

  Future<void> readAdsFromFirebase() async {
    final ads = db.collection("apps").doc("apuntes_dominoes");
    ads.get().then((DocumentSnapshot documentSnapshot) {
      final appAds = documentSnapshot.data() as Map<String, dynamic>;
      showAd = appAds["show"];
      logger.v(showAd);
      if (showAd) {
        loadAd();
    }
    });
  }

  /// Load an AppOpenAd.
  Future<void> loadAd() async {
    logger.v("ADMOB LOADED 😍😍----------*******");
    logger.v("adUnitId => $adUnitId");
    AppOpenAd.load(
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');

          // Handle the error.
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return appOpenAd != null;
  }

  void showAdIfAvailable() {
    logger.v("SHOWIFAVAIBLABLE 😍😍");
    if (!isAdAvailable) {
      print('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      print('Tried to show ad while already showing an ad.');
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
        loadAd();
      },
    );
    appOpenAd!.show();
  }

  String? getAdMobAppId() {
    if (Platform.isIOS) {
      return TEST ? MyAdmob.TEST_app_id_ios : MyAdmob.PROD_app_id_ios;
    } else if (Platform.isAndroid) {
      return TEST ? MyAdmob.TEST_app_id_android : MyAdmob.PROD_app_id_android;
    }
    return null;
  }

  String? getBannerAdId() {
    if (Platform.isIOS) {
      // return ;
      return TEST ? MyAdmob.TEST_banner_id_ios : MyAdmob.PROD_banner_id_ios;
    } else if (Platform.isAndroid) {
      // return ;
      return TEST
          ? MyAdmob.TEST_banner_id_android
          : MyAdmob.PROD_banner_id_android;
    }
    return null;
  }

  // String? getInterstitialAdId() {
  //   if (Platform.isIOS) {
  //     return TEST
  //         ? MyAdmob.TEST_interstitial_id_ios
  //         : MyAdmob.PROD_interstitial_id_ios;
  //   } else if (Platform.isAndroid) {
  //     return TEST
  //         ? MyAdmob.TEST_interstitial_id_android
  //         : MyAdmob.PROD_interstitial_id_android;
  //   }
  //   return null;
  // }

  String? getOpenAdId() {
    if (Platform.isIOS) {
      return TEST ? MyAdmob.TEST_open_ad_id_ios : MyAdmob.PROD_open_ad_id_ios;
    } else if (Platform.isAndroid) {
      return TEST
          ? MyAdmob.TEST_open_ad_id_android
          : MyAdmob.PROD_open_ad_id_android;
    }
    return null;
  }

  // loadInterstitial() {
  //   interstitialAd = InterstitialAd(unitId: getInterstitialAdId());
  //   logger.i("interstitial loading..");

  //   interstitialAd.load();
  // }

  // showInterstitial() async {
  //   if (interstitialAd.isLoaded) {
  //     logger.i("interstitial is loaded");
  //     interstitialAd.show();
  //   }
  // }

  // loadOpenad() {
  //   appOpenAd = AppOpenAd(timeout: Duration(minutes: 30) );

  //   appOpenAd.load(orientation: AppOpenAd.ORIENTATION_PORTRAIT);
  // }

  // showAppOpen() async {
  //   if (!appOpenAd.isAvailable) await appOpenAd.load();
  //   if (appOpenAd.isAvailable) {
  //     await appOpenAd.show();
  //     // Load a new ad right after the other one was closed
  //     appOpenAd.load();
  //   }
  // }

  // showBanner() async {
  //   bannerController.onEvent.listen((e) {
  //     final event = e.keys.first;
  //     // final info = e.values.first;
  //     switch (event) {
  //       case BannerAdEvent.loaded:
  //         // setState(() => _bannerAdHeight = (info as int)?.toDouble());
  //         break;
  //       default:
  //         break;
  //     }
  //   });
  //   bannerController.load();
  // }
}
