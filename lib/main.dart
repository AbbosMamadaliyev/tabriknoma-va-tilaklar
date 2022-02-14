import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabriklar/services/categor_model_provider/categor_model_provider.dart';
import 'package:tabriklar/services/database/db_service_provider.dart';
import 'package:tabriklar/services/db_table_model_provider/db_table_model_provider.dart';
import 'package:tabriklar/services/get_data_from_firebase/get_images_provider.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DbServiceProver(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CategoryModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => DbTableModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ImageListProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
