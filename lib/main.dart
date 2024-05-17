import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads_pratice/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: NativeInlinePage(),
      ),
    );
  }
}

class NativeInlinePage extends StatefulWidget {
  const NativeInlinePage({super.key});

  @override
  State createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  NativeAd? _ad;
  bool isCheck = false;
  List list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    // getNativeAd();
    // _ad = getNativeAd();
    list.clear();
    for (int i = 1; i <= 52; i++) {
      if (i % 5 == 0) {
        // NativeAd ads = getNativeAd();
        BannerAd ads = getBannerAd();
        list.add(AdWidget(ad: ads));
      } else {
        list.add(Container(height: 60, color: const Color.fromARGB(255, 60, 4, 0)));
      }
    }
  }

  NativeAd getNativeAd() {
    print("=======$nativeAdUnitId");
    return NativeAd(
      adUnitId: nativeAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isCheck = true;
            _ad = ad as NativeAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('======Ad load failed $error');
          ad.dispose();
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small),
    )..load();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('AdMob Native Inline Ad'),
      ),
      body: listView(),
    );
  }

  Widget listView() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          list.length,
          (int index) {
            return Container(
              height: 72.0,
              alignment: Alignment.center,
              child: list[index],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }
}
