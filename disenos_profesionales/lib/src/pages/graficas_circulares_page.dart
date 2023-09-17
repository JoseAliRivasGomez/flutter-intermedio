import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:disenos_profesionales/src/theme/theme.dart';

import 'package:disenos_profesionales/src/widgets/radial_progress.dart';


class GraficasCircularesPage extends StatefulWidget {
  const GraficasCircularesPage({super.key});
  
  @override
  GraficasCircularesPageState createState() => GraficasCircularesPageState();
}

class GraficasCircularesPageState extends State<GraficasCircularesPage> {
  
  double porcentaje = 0.0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon( Icons.refresh ),
        onPressed: (){
          setState(() {
            porcentaje += 10;
            if ( porcentaje > 100 ) {
              porcentaje = 0;
            }
          });
        }
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(flex: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(porcentaje: porcentaje, color: Colors.yellow ),
              CustomRadialProgress(porcentaje: porcentaje * 1.2, color: Colors.lightBlue )
            ],
          ),
          const Spacer(flex: 1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadialProgress(porcentaje: porcentaje * 1.4, color: Colors.lightGreen ),
              CustomRadialProgress(porcentaje: porcentaje * 1.6, color: Colors.orange )
            ],
          ),
          const Spacer(flex: 10,),
        ],
      )
    );
  }
}

class CustomRadialProgress extends StatelessWidget {

  final Color color;

  const CustomRadialProgress({
    super.key,
    required this.porcentaje,
    required this.color
  });

  final double porcentaje;

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return SizedBox(
      width: 180,
      height: 180,
      child: RadialProgress( 
        porcentaje: porcentaje,
        colorPrimario: color,
        colorSecundario: appTheme.textTheme.bodyLarge!.color!,
        grosorPrimario: 15,
        grosorSecundario: 20,
      ),
      // child: Text('$porcentaje %', style: TextStyle(fontSize: 50.0) ),
    );
  }
}