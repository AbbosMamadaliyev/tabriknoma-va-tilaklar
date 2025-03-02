import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabriklar/assets/colors/app_colors.dart';
import 'package:tabriklar/assets/constants/app_icons.dart';
import 'package:tabriklar/assets/constants/app_images.dart';
import 'package:tabriklar/features/common/presentation/bloc/version/version_bloc.dart';
import 'package:tabriklar/features/home_page/widgets/ramadan_time_screen.dart';
import 'package:tabriklar/utils/extensions.dart';
import 'package:tabriklar/utils/my_functions.dart';

class RamadanTimeWidget extends StatefulWidget {
  const RamadanTimeWidget({super.key});

  @override
  State<RamadanTimeWidget> createState() => _RamadanTimeWidgetState();
}

class _RamadanTimeWidgetState extends State<RamadanTimeWidget> {
  late Image vectorImage;

  @override
  void initState() {
    vectorImage = Image.asset(
      AppImages.vector,
      fit: BoxFit.cover,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(vectorImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    bool isRamadan = context.watch<VersionBloc>().state.isRamadanMonth;
    if (!isRamadan) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const RamadanTimeScreen()));
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 120,
        margin: const EdgeInsets.fromLTRB(20, 24, 20, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xff23033b),
              Color(0xff8F06FA),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Transform.rotate(
                  angle: 3.14,
                  child: Image.asset(
                    AppImages.uzor,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -1,
              left: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(24),
                ),
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: .53,
                    child: vectorImage,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Toshkent vaqti bilan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            MyFunctions.formatDateFromApi(
                              DateTime.now().toString(),
                              format: 'd - MMMM',
                              locale: context.locale.languageCode,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.navBarColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 12,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFEDFB1),
                            border: Border.all(color: const Color(0xffF0A70A)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AppIcons.sun,
                                height: 24,
                                width: 24,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Saharlik: ',
                                      style: context.textTheme.displaySmall!.copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: MyFunctions.suhoorTime(),
                                      style: context.textTheme.displaySmall!.copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff16165F),
                            border: Border.all(color: const Color(0xff0f0f8c)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AppIcons.moon,
                                height: 24,
                                width: 24,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Iftorlik: ',
                                      style: context.textTheme.displaySmall!.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: MyFunctions.iftarTime(),
                                      style: context.textTheme.displaySmall!.copyWith(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
