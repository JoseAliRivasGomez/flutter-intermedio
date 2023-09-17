import 'package:disenos_profesionales/src/theme/theme.dart';
import 'package:disenos_profesionales/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HeadersPage extends StatelessWidget {
  const HeadersPage({super.key});

  @override
  Widget build(BuildContext context) {

    final primaryColor = Provider.of<ThemeChanger>(context).currentTheme.primaryColor;

    return Scaffold(
      body: HeaderWaveGradient( color: primaryColor )
    );
  }
}