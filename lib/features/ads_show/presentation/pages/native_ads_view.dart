import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:test_ads_pratice/di/get_it.dart';
import 'package:test_ads_pratice/features/ads_show/presentation/cubit/ads_show_cubit.dart';

class NativeInlinePage extends StatefulWidget {
  const NativeInlinePage({super.key});

  @override
  State createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  late AdsShowCubit adsShowCubit;

  @override
  void initState() {
    adsShowCubit = getItInstance<AdsShowCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text('AdMob Native Inline Ad'),
      ),
      body: listView(),
    );
  }

  Widget listView() {
    return Column(
      children: [
        BlocBuilder<AdsShowCubit, double>(
          bloc: adsShowCubit,
          builder: (context, state) {
            return Container(
              height: 150,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(adsShowCubit.value),
            );
          },
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (index % 3 == 0) {
                return const SizedBox.shrink();
              }
              return InkWell(
                onTap: () {
                  adsShowCubit.changeValue(clickedValue: "=======$index");
                },
                child: Container(
                  height: 72.0,
                  color: Colors.amber,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  alignment: Alignment.center,
                  child: Text("=======$index"),
                ),
              );
            },
            separatorBuilder: (context, index) {
              if (index % 3 == 0) {
                return FutureBuilder(
                  future: adsShowCubit.getNativeAd1(index: index),
                  builder: (context, snapshot) {
                    if (snapshot.data != null && snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return Container(
                        height: 72.0,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        child: AdWidget(ad: snapshot.data!),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        height: 72.0,
                        color: Colors.amber,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        child: Text("======${snapshot.error}"),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              }
              return const SizedBox.shrink();
            },
            itemCount: 1 == 1 ? 50 : adsShowCubit.mapOfNativeAd.length,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
