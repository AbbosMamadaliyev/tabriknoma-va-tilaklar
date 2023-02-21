import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../domain/service/connectivity.dart';
import '../main_navigation.dart';
import '../my_app.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  Future<void> retry() async {
    EasyLoading.show();
    final result = await ConnectivityX().create();
    if (result) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(connectivityX: result),
          ),
          (route) => false);
      EasyLoading.dismiss();
      return;
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d0e32),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/no_internet.gif'),
              const Text(
                'Aloqa y\'oq',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: const Text(
                  'Internet bilan aloqa borligi tekshiring',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.all(24.0.spMin),
                child: ElevatedButton(
                  onPressed: retry,
                  child: const Text('Qayta urinib ko\'rish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
