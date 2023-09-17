import 'package:disenos_profesionales/src/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:disenos_profesionales/src/widgets/slideshow.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {

    bool isLarge;
    if ( MediaQuery.of(context).size.height > 500 ) {
      isLarge = true;
    } else {
      isLarge = false;
    }

    final children = [
      const Expanded(child: MiSlideshow()),
      const Expanded(child: MiSlideshow())
    ];

    return Scaffold(
      // backgroundColor: Colors.purple,
      // body: MiSlideshow(),
      body: ( isLarge ) 
              ? Column( children: children )
              : Row( children: children )
    );
  }
}

class MiSlideshow extends StatelessWidget {
  const MiSlideshow({super.key});

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);
    final primaryColor = appTheme.currentTheme.primaryColor;

    return Slideshow(
      bulletPrimario: 20,
      bulletSecundario: 12,
      // puntosArriba: true,
      colorPrimario: ( appTheme.darkTheme ) ? primaryColor : const Color(0xffFF5A7E),
      // colorSecundario: Colors.red,
      slides: <Widget>[
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
    );
  }
}

