import 'dart:io';

String get nativeAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/2247696110';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/3986624511';
  }
  throw UnsupportedError("Unsupported platform");
}

String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/6300978111';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  }
  throw UnsupportedError("Unsupported platform");
}

String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-3940256099942544/1033173712';
  } else if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/4411468910';
  }
  throw UnsupportedError("Unsupported platform");
}
