import 'package:flutter/material.dart';


class CuadradoAnimadoPage extends StatelessWidget {
  const CuadradoAnimadoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _CuadradoAnimado()
      ),
    );
  }
}

class _CuadradoAnimado extends StatefulWidget {
 
  @override
  __CuadradoAnimadoState createState() => __CuadradoAnimadoState();
}

class __CuadradoAnimadoState extends State<_CuadradoAnimado> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  // animaciones
  late Animation<double> moverDerecha;
  late Animation<double> moverArriba;
  late Animation<double> moverIzquierda;
  late Animation<double> moverAbajo;
  late Animation<double> moverDerecha2;

  @override
  void initState() { 
    super.initState();
    // inicializar todo

    controller = AnimationController(vsync: this, duration: const Duration( milliseconds: 6000 ));

    moverDerecha = Tween( begin: 0.0, end: 100.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.20, curve: Curves.bounceOut ))
    );

    moverArriba = Tween( begin: 0.0, end: -300.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.20, 0.4, curve: Curves.bounceOut ))
    );

    moverIzquierda = Tween( begin: 0.0, end: -200.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.4, 0.6, curve: Curves.bounceOut ))
    );

    moverAbajo = Tween( begin: 0.0, end: 300.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.6, 0.8, curve: Curves.bounceOut ))
    );

    moverDerecha2 = Tween( begin: 0.0, end: 100.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.8, 1, curve: Curves.bounceOut ))
    );
    
    controller.addListener((){
      if ( controller.status == AnimationStatus.completed ) {
        controller.repeat();
      }
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    controller.forward();

    return AnimatedBuilder(
      animation: controller,
      child: _Rectangulo(),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(moverDerecha.value + moverIzquierda.value + moverDerecha2.value, moverArriba.value + moverAbajo.value ),
          child: child,
        );
      },
    );
  }
}






class _Rectangulo extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return Container(
       width: 70,
       height: 70,
       decoration: const BoxDecoration(
         color: Colors.blue
       ),
     );
   }
}