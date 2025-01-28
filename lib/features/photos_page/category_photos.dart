import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/src/provider.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/view_models/get_data_from_firebase/get_images_provider.dart';

import '../../domain/service/ad_helper.dart';

class CategorPhotosWidget extends StatefulWidget {
  const CategorPhotosWidget({Key? key}) : super(key: key);

  @override
  _CategorPhotosWidgetState createState() => _CategorPhotosWidgetState();
}

class _CategorPhotosWidgetState extends State<CategorPhotosWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<String> imgs = ['0', 'juma1', 'new_year'];
  bool startAnimation = false;

  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });

    if (Platform.isAndroid) {
      _bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: AdHelper.listener,
      )..load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 3 + (_bannerAd == null ? 0 : 1),
              itemBuilder: (context, index) {
                if (index == 3) {
                  return _bannerAd == null
                      ? Container()
                      : Container(
                          height: 64.h,
                          width: 1.sw,
                          padding: EdgeInsets.only(top: 16.h),
                          child: AdWidget(ad: _bannerAd!),
                        );
                }
                return Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: InkWell(
                    onTap: () {
                      context.read<ImageListProvider>().getDataFromRtDb(index + 1);
                      Navigator.of(context).pushNamed(MainNavigationNames.photos);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: (300 + index * 100)),
                      transform: Matrix4.translationValues(startAnimation ? 0 : 340.w, 0, 0),
                      curve: Curves.easeInOut,
                      height: 156.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.r),
                        image: DecorationImage(
                          image: AssetImage('assets/images/${imgs[index]}.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: CustomChildContainerGradient(index: index),
                    ),
                  ),
                );
              }),
        ),
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: _bannerAd == null
        //       ? Container()
        //       : SizedBox(
        //           height: 52.h,
        //           width: 1.sw,
        //           child: AdWidget(ad: _bannerAd!),
        //         ),
        // )
      ],
    );
  }
}

class CustomChildContainerGradient extends StatelessWidget {
  final int index;

  CustomChildContainerGradient({Key? key, required this.index}) : super(key: key);

  final List<String> categories = [
    'Tug\'ulgan kun tabriklari rasmda',
    'Juma ayyomi tabriklari',
    'Aralash tabrik va tilaklar'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: 24.w, bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black12,
            Colors.black,
          ],
        ),
      ),
      child: Text(
        categories[index],
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
