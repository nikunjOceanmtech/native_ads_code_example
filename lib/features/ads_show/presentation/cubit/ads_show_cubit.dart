import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads_pratice/global.dart';

class AdsShowCubit extends Cubit<double> {
  AdsShowCubit() : super(0);

  List<NativeAd?> list = [];

  Future<void> getData() async {
    list.clear();
    for (int i = 0; i < 30; i++) {
      await getNativeAd();
    }
  }

  Future<NativeAd> getNativeAd() async {
    NativeAd ads = NativeAd(
      adUnitId: nativeAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          list.add(ad as NativeAd);
          emit(Random().nextDouble());
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('======Ad load failed $error');
          ad.dispose();
        },
      ),
      factoryId: 'listTile',
    );
    await ads.load();
    return ads;
  }

  BannerAd getBannerAd() {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      request: const AdRequest(
        keywords: <String>['foo', 'bar'],
        contentUrl: 'http://foo.com/bar.html',
        nonPersonalizedAds: true,
      ),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) async {
          debugPrint('======Ad load failed $error');
          await ad.dispose();
        },
      ),
      size: AdSize.banner,
    )..load();
  }

  void getIntiticalAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(
        keywords: <String>['foo', 'bar'],
        contentUrl: 'http://foo.com/bar.html',
        nonPersonalizedAds: true,
      ),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  String value = "";

  void changeValue({required String clickedValue}) {
    value = clickedValue;
    emit(Random().nextDouble());
  }
}
