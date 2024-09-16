import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dastur haqida'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('  Bu dsaturda eng sara tabrik va tilaklar, sherlar jamlangan. '
              'Tabriklarni yaqinlaringizga jo\'natishingiz mumkin.'),
          const Text('\n  Agar dastur sizga yoqgan bo\'lsa baholang va do\'stlaringizga ulashing.'),
          const SizedBox(height: 4),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      final url =
                          Uri.parse('https://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar');

                      launchUrl(url, mode: LaunchMode.externalApplication);
                    },
                    icon: const Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const Text('Baholash'),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      const shareText =
                          'Bu dasturda siz yaqiningiz uchun tayyor tilaklar va tabriklar topishingiz mumkin. \n\nhttps://play.google.com/store/apps/details?id=com.mamadaliyev.abbos.tabriklar';

                      await Share.share(shareText);
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.green,
                    ),
                  ),
                  const Text('Ulashish'),
                ],
              ),
            ],
          ),
          const Divider(),
          const Text('Ilovadagi materiallar internet saytlardan olindi. Bu Dastur muallifi , '
              'ilova ichidagi materiallarga davolik qilmaydi. '),
        ],
      ),
    );
  }
}
