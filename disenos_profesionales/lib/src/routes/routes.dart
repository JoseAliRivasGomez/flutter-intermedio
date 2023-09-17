import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:disenos_profesionales/src/pages/graficas_circulares_page.dart';
import 'package:disenos_profesionales/src/pages/headers_page.dart';
import 'package:disenos_profesionales/src/pages/pinterest_page.dart';
import 'package:disenos_profesionales/src/pages/slider_list_page.dart';
import 'package:disenos_profesionales/src/retos/cuadrado_animado_page.dart';
import 'package:disenos_profesionales/src/pages/emergency_page.dart';
import 'package:disenos_profesionales/src/pages/slideshow_page.dart';
import 'package:disenos_profesionales/src/pages/animaciones_page.dart';

final pageRoutes = <_Route>[

  _Route( FontAwesomeIcons.slideshare , 'Slideshow',  const SlideshowPage() ),
  _Route( FontAwesomeIcons.truckMedical , 'Emergencia',  const EmergencyPage() ),
  _Route( FontAwesomeIcons.heading , 'Encabezados',  const HeadersPage() ),
  _Route( FontAwesomeIcons.turnUp , 'Animaciones', const AnimacionesPage() ),
  _Route( FontAwesomeIcons.peopleCarryBox , 'Cuadro Animado', const CuadradoAnimadoPage() ),
  _Route( FontAwesomeIcons.circleNotch , 'Barra Progreso', const GraficasCircularesPage() ),
  _Route( FontAwesomeIcons.pinterest , 'Pinterest', const PinterestPage() ),
  _Route( FontAwesomeIcons.mobile , 'Slivers', const SliverListPage() ),

];





class _Route {

  final IconData icon;
  final String titulo;
  final Widget page;

  _Route(this.icon, this.titulo, this.page);

}