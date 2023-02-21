import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:tabriklar/view_models/get_data_from_firebase/get_images_provider.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ImageListProvider>();
    var imageLinkList = model.imageLinkList;
    var defaultLink = model.defaultLink;
    var isActiveBtn = model.isActiveBtn;
    var isLoading = model.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabriklar rasmda'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: imageLinkList.length,
              itemBuilder: (context, index) {
                var image = imageLinkList[index] ?? defaultLink;
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.0, right: 4, left: 4, top: 4),
                  child: Card(
                    elevation: 8,
                    child: Column(
                      children: [
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Image.network(image),
                        InkWell(
                          child: SizedBox(
                            height: 64.h,
                            width: double.infinity,
                            child: IconButton(
                              icon: isActiveBtn[index]
                                  ? const CircularProgressIndicator(
                                      color: Color(0xff1c901e),
                                    )
                                  : const Icon(
                                      Icons.send,
                                      color: Color(0xff1c901e),
                                    ),
                              onPressed: () {
                                model.shareImage(image ?? defaultLink, index);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
