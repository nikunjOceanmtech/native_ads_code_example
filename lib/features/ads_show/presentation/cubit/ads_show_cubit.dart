import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads_pratice/global.dart';

class AdsShowCubit extends Cubit<double> {
  AdsShowCubit() : super(0);

  Map<int, NativeAd> mapOfNativeAd = {};

  Future<NativeAd?> getNativeAd1({required int index}) async {
    Completer<NativeAd> completer = Completer<NativeAd>();

    if (mapOfNativeAd.containsKey(index)) {
      completer.complete(mapOfNativeAd[index]);
      return completer.future;
    }
    NativeAd? nativeAd;
    nativeAd = NativeAd(
      adUnitId: nativeAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeAd = ad as NativeAd;
          completer.complete(ad);
          mapOfNativeAd.addAll({index: ad});
        },
        onAdFailedToLoad: (ad, error) {
          completer.completeError(error);
          debugPrint('======Ad load failed $error');
          ad.dispose();
        },
      ),
      factoryId: 'listTile',
      // nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small),
    );
    await nativeAd?.load();
    return completer.future;
  }

  String value = "";
  void changeValue({required String clickedValue}) {
    value = clickedValue;
    emit(Random().nextDouble());
  }
}
