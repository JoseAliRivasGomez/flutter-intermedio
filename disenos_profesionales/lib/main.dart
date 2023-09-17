import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:disenos_profesionales/src/theme/theme.dart';
import 'package:disenos_profesionales/src/models/layout_model.dart';

import 'package:disenos_profesionales/src/pages/launcher_tablet_page.dart';
import 'package:disenos_profesionales/src/pages/launcher_page.dart';

// void main() => runApp(
//   MultiProvider(
//     providers: [
//       Provider<ThemeChanger>(create: (_) => new ThemeChanger( 2 )),
//       Provider<LayoutModel>(create: (_) => new LayoutModel())
//     ],
//     child: MyApp(),
//   )
// );

void main() => runApp(ChangeNotifierProvider(
      create: (_) => LayoutModel(),
      child: ChangeNotifierProvider(
          create: (_) => ThemeChanger(2), child: const MyApp()),
    ));

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          // print('Orientation $orientation');

          final screenSize = MediaQuery.of(context).size;

          if (screenSize.width > 500) {
            return const LauncherTabletPage();
          } else {
            return const LauncherPage();
          }
        },
      ),
    );
  }
}
