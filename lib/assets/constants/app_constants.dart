import 'package:tabriklar/assets/constants/app_images.dart';
import 'package:tabriklar/domain/models/useful_apps_model.dart';
import 'package:tabriklar/domain/models/useful_channel_model.dart';

class AppConstants {
  static const String baseUrl = 'https://api.example.com';

  static List<UsefulAppModel> apps = [
    UsefulAppModel(
      title: 'Wallpapers - Pexels',
      image: AppImages.wallpaperApp,
      storeLink: 'https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.walpapers',
    ),
    UsefulAppModel(
      title: 'Just.do',
      image: AppImages.justDo,
      storeLink: 'https://play.google.com/store/apps/details?id=com.just.do',
    ),
    UsefulAppModel(
      title: 'IELTS Band Calculator',
      image: AppImages.ieltsBand,
      storeLink: 'https://play.google.com/store/apps/details?id=rm.studio.ieltsbandcalculator',
    ),
  ];

  static List<UsefulChannelModel> channels = [
    UsefulChannelModel(
      title: '𝐌𝐮𝐥𝐭𝐢𝐥𝐞𝐯𝐞𝐥 𝐌𝐚𝐬𝐭𝐞𝐫𝐲',
      description: '''Multilevel imtihoniga C1 darajali ustoz bilan tayyorlaning! 🎯 
𝐈𝐬𝐡𝐨𝐧𝐜𝐡𝐥𝐢 𝐭𝐚’𝐥𝐢𝐦, 𝐘𝐮𝐪𝐨𝐫𝐢 𝐧𝐚𝐭𝐢𝐣𝐚 🚀''',
      storeLink: 'https://t.me/+pN7X5k1GXt80ZDFi',
      usersCount: 17,
      image: AppImages.mMastery,
    ),
    UsefulChannelModel(
      title: '𝐏𝐢𝐨𝐧𝐲 𝐒𝐭𝐨𝐫𝐞 💗',
      description: '''• Лучшее для лучших 💗💗💗
• Срок доставки 1-3 дней 
• Доставка по всему Узбекистану''',
      storeLink: 'https://t.me/+Gl-USbSEQh1kNzc6',
      usersCount: 2,
      image: AppImages.piony,
    ),
  ];
}
