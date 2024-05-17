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
    adsShowCubit.getData();
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
    return 1 == 1
        ? BlocBuilder<AdsShowCubit, double>(
            bloc: adsShowCubit,
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(adsShowCubit.value),
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
                          return adsShowCubit.list[index] != null
                              ? Container(
                                  height: 72.0,
                                  color: Colors.amber,
                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  alignment: Alignment.center,
                                  child: AdWidget(ad: adsShowCubit.list[index]!),
                                )
                              : const SizedBox.shrink();
                        }
                        return const SizedBox.shrink();
                      },
                      itemCount: adsShowCubit.list.length,
                    ),
                  ),
                ],
              );
            },
          )
        : SingleChildScrollView(
            child: Column(
              children: List.generate(
                adsShowCubit.list.length,
                (int index) {
                  return Container(
                    height: 72.0,
                    alignment: Alignment.center,
                    child: index % 3 == 0
                        ? adsShowCubit.list[index] != null
                            ? AdWidget(ad: adsShowCubit.list[index]!)
                            : const SizedBox.shrink()
                        : Text("=======${index + 1}"),
                  );
                },
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
