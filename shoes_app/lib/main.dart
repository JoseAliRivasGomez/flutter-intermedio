import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/models/zapato_model.dart';

import 'package:shoes_app/src/pages/zapato_page.dart';
 
void main() {

  return runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => ZapatoModel() ),
      ],
      child: const MyApp()
    )
  );

}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ShoesApp',
      debugShowCheckedModeBanner: false,
      home: ZapatoPage()
      // home: ZapatoDescPage()
    );
  }
}