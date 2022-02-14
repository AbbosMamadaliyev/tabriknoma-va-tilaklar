import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tabriklar/main_navigation.dart';
import 'package:tabriklar/services/get_data_from_firebase/get_images_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: () {
                  context.read<ImageListProvider>().getDataFromRtDb(index + 1);
                  Navigator.of(context).pushNamed(MainNavigationNames.photos);
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
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
    );
  }
}

class CustomChildContainerGradient extends StatelessWidget {
  final int index;
  CustomChildContainerGradient({Key? key, required this.index})
      : super(key: key);

  List<String> categories = [
    'Tug\'ulgan kun tabriklari rasmda',
    'Juma ayyomi tabriklari',
    'Aralash tabrik va tilaklar'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 24, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
