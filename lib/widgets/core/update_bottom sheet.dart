// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class UpdateBottomSheet extends StatelessWidget {
//   final String url;
//   const UpdateBottomSheet({super.key, required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 396,
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//         color: Colors.white,
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               WScaleAnimation(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: SvgPicture.asset(AppIcons.close),
//                   )),
//             ],
//           ),
//           SvgPicture.asset(AppIcons.rocket, color: mainColor, width: 64, height: 64),
//           Padding(
//             padding: const EdgeInsets.only(top: 20, bottom: 8.0),
//             child: Text(
//               LocaleKeys.update_the_app.tr(),
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                     color: white,
//                   ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
//             child: Text(
//               LocaleKeys.update_app_subtitle.tr(),
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headline2!.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//             ),
//           ),
//           // const SizedBox(height: 28),
//           const Spacer(),
//           WButton(
//             margin: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 8, right: 20, left: 20),
//             onTap: () {
//               launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//             },
//             color: mainColor,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Yangilash'),
//                 const SizedBox(width: 12),
//                 SvgPicture.asset(
//                   AppIcons.refresh,
//                   color: black,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
