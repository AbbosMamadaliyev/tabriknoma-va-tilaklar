// import 'package:app_version_update/app_version_update.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';
import 'package:tabriklar/features/components/background_home_page.dart';
import 'package:tabriklar/features/components/custom_advanced_drawer.dart';
import 'package:tabriklar/features/home_page/home_page.dart';
import 'package:tabriklar/features/photos_page/category_photos.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int sectionIndex = 0;

  void _handleMuneButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAdvancedDrawer(
      advancedDrawerController: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: _handleMuneButtonPressed,
          ),
          title: Text(
            'Tabrik va tilaklar',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BackgroundHomePage(
          child: sectionIndex == 0 ? const HomePageBody() : const CategorPhotosWidget(),
        ),
        bottomNavigationBar: Container(
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.blue.withOpacity(.3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 4,
                    width: 56,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),
                  SvgPicture.asset(
                    AppIcons.home,
                    height: 24,
                    width: 24,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 4,
                    width: 56,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),
                  SvgPicture.asset(
                    AppIcons.gallery,
                    height: 24,
                    width: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> checkerUpdate() async {
  //   const playStoreId = 'com.mamadaliyev.abbos.tabriklar'; // If this value is null, its packagename will be considered
  //   const country = 'uz'; // If this value is null 'us' will be the default value
  //   await AppVersionUpdate.checkForUpdates(playStoreId: playStoreId, country: country).then((data) async {
  //     log('data.storeVersion: ${data.storeVersion}');
  //     log('data.storeUrl: ${data.storeUrl}');
  //     if (data.canUpdate!) {
  //       log('can updatteeee');
  //       AppVersionUpdate.showAlertUpdate();
  //
  //       // showModalBottomSheet(
  //       //     useRootNavigator: true,
  //       //     isDismissible: false,
  //       //     enableDrag: false,
  //       //     context: context,
  //       //     backgroundColor: Colors.transparent,
  //       //     builder: (context) {
  //       //       return UpdateBottomSheet(url: data.storeUrl!);
  //       //     });
  //     }
  //   });
  // }

  CurvedNavigationBar customNavigationBar() {
    return CurvedNavigationBar(
      items: const [
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.photo_library_outlined, color: Colors.white),
      ],
      index: 0,
      height: 56.h,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      color: const Color(0xff1c901e),
      backgroundColor: const Color(0xff1e027a),
      buttonBackgroundColor: Colors.transparent,
      onTap: (index) {
        setState(() {
          sectionIndex = index;
        });
        print('ss: $sectionIndex');
      },
    );
  }
}
