import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:disenos_profesionales/src/theme/theme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:disenos_profesionales/src/routes/routes.dart';

class LauncherPage extends StatelessWidget {
  const LauncherPage({super.key});

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseños en Flutter - Teléfono'),
        backgroundColor: appTheme.primaryColor,
      ),
      drawer: _MenuPrincipal(),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: _ListaOpciones(),
      )
   );
  }
}

class _ListaOpciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;


    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: ( context, i) => Divider(
        color: appTheme.primaryColorLight,
      ), 
      itemCount: pageRoutes.length,
      itemBuilder: (context, i) => ListTile(

        leading: FaIcon( pageRoutes[i].icon , color: appTheme.primaryColor ),
        title: Text( pageRoutes[i].titulo ),
        trailing: Icon( Icons.chevron_right, color: appTheme.primaryColor ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> pageRoutes[i].page ));
        },

      ), 
    );
  }
}

class _MenuPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);
    final primaryColor = appTheme.currentTheme.primaryColor;

    return Drawer(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: CircleAvatar(
                backgroundColor: primaryColor,
                child: const Text('FH', style: TextStyle( fontSize: 50),),
              ),
            ),
          ),


          Expanded(
            child: _ListaOpciones()
          ),


          ListTile(
            leading: Icon( Icons.lightbulb_outline, color: primaryColor ),
            title: const Text('Dark Mode'),
            trailing: Switch.adaptive(
              value: appTheme.darkTheme ,
              activeColor: primaryColor,
              onChanged: ( value ) => appTheme.darkTheme = value
            ),
          ),


          SafeArea(
            bottom: true,
            top: false,
            left: false,
            right: false,
            child: ListTile(
              leading: Icon( Icons.add_to_home_screen, color: primaryColor ),
              title: const Text('Custom Theme'),
              trailing: Switch.adaptive(
                value: appTheme.customTheme, 
                activeColor: primaryColor,
                onChanged: ( value ) => appTheme.customTheme = value
              ),
            ),
          ),
          

        ],
      ),
    );
  }
}