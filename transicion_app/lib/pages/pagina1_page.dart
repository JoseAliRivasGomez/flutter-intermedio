import 'package:flutter/material.dart';
import 'package:transicion_app/pages/pagina2_page.dart';


class Pagina1Page extends StatelessWidget {
  const Pagina1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página'),
      ),
      body: const Center(
        child: Text('Pagina 1'),
     ),
     floatingActionButton: FloatingActionButton(
       child: const Icon( Icons.access_time ),
       onPressed: (){

         Navigator.push(context, _crearRuta() );

       }
    ),
   );
  }

  Route _crearRuta() {


    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => const Pagina2Page(),
      // transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: ( context, animation, secondaryAnimation, child ) {

        final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut );

        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.5, 1.0), end: Offset.zero ).animate(curvedAnimation),
          child: child,
        );

        // return ScaleTransition(
        //   scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        //   child: child
        // );

        // return RotationTransition(
        //   turns: Tween<double>(begin: 0.0, end: 1.0 ).animate(curvedAnimation),
        //   child: child
        // );

        // return FadeTransition(
        //   opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        //   child: child
        // );

        // return RotationTransition(
        //   turns: Tween<double>(begin: 0.0, end: 1.0 ).animate(curvedAnimation),
        //   child: FadeTransition(
        //     opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        //     child: child
        //   )
        // );

      }
      );


  }
}