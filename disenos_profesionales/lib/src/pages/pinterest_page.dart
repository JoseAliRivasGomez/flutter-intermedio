import 'dart:math';

import 'package:disenos_profesionales/src/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:disenos_profesionales/src/widgets/pinterest_menu.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
        // body: PinterestMenu(),
        // body: PinterestGrid(),
        body: Stack(
          children: <Widget>[
            const PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthPantalla = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    if (widthPantalla > 500) {
      widthPantalla = widthPantalla - 300;
    }

    return Positioned(
        bottom: 30,
        child: SizedBox(
            width: widthPantalla,
            child: Row(
              children: <Widget>[
                const Spacer(),
                PinterestMenu(
                  mostrar: mostrar,
                  backgroundColor: appTheme.scaffoldBackgroundColor,
                  activeColor: appTheme.primaryColor,
                  // inactiveColor: Colors.blue,
                  items: [
                    PinterestButton(
                        icon: Icons.pie_chart,
                        onPressed: () {
                          // print('Icon pie_chart');
                        }),
                    PinterestButton(
                        icon: Icons.search,
                        onPressed: () {
                          // print('Icon search');
                        }),
                    PinterestButton(
                        icon: Icons.notifications,
                        onPressed: () {
                          // print('Icon notifications');
                        }),
                    PinterestButton(
                        icon: Icons.supervised_user_circle,
                        onPressed: () {
                          // print('Icon supervised_user_circle');
                        }),
                  ],
                ),
                const Spacer(),
              ],
            )));
  }
}

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({super.key});

  @override
  PinterestGridState createState() => PinterestGridState();
}

class PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (i) => i);
  final rnd = Random();
  late List<int> extents;
  ScrollController controller = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    extents = List<int>.generate(10000, (int index) => rnd.nextInt(4) + 2);

    controller.addListener(() {
      if (controller.offset > scrollAnterior && controller.offset > 150) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }

      scrollAnterior = controller.offset;
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count;
    if (MediaQuery.of(context).size.width > 500) {
      count = 3;
    } else {
      count = 2;
    }

    return MasonryGridView.count(
      controller: controller,
      crossAxisCount: count,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final height = extents[index] == 5 ? extents[index] * 80 : extents[index] * 100;
        return _PinterestItem(index, height.toDouble());
      },
      // staggeredTileBuilder: (int index) => StaggeredTile.count(1, index.isEven ? 1 : 2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  final double height;

  const _PinterestItem(this.index, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
        margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => _mostrar;

  set mostrar(bool valor) {
    _mostrar = valor;
    notifyListeners();
  }
}
