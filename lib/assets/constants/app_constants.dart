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

class RamadanTimes {
  static const Map<int, String> suhoor = {
    1: '5:40',
    2: '5:38',
    3: '5:37',
    4: '5:35',
    5: '5:33',
    6: '5:32',
    7: '5:30',
    8: '5:29',
    9: '5:27',
    10: '5:25',
    11: '5:24',
    12: '5:22',
    13: '5:20',
    14: '5:18',
    15: '5:17',
    16: '5:15',
    17: '5:13',
    18: '5:12',
    19: '5:10',
    20: '5:08',
    21: '5:06',
    22: '5:04',
    23: '5:03',
    24: '5:01',
    25: '4:59',
    26: '4:57',
    27: '4:55',
    28: '4:54',
    29: '4:52',
    30: '4:50',
  };

  static const Map<int, String> iftar = {
    1: '18:17',
    2: '18:18',
    3: '18:19',
    4: '18:20',
    5: '18:21',
    6: '18:22',
    7: '18:24',
    8: '18:25',
    9: '18:26',
    10: '18:27',
    11: '18:28',
    12: '18:29',
    13: '18:30',
    14: '18:32',
    15: '18:33',
    16: '18:34',
    17: '18:35',
    18: '18:36',
    19: '18:37',
    20: '18:38',
    21: '18:39',
    22: '18:40',
    23: '18:41',
    24: '18:42',
    25: '18:44',
    26: '18:45',
    27: '18:46',
    28: '18:47',
    29: '18:48',
    30: '18:49',
  };
}
