import 'package:flutter/material.dart';

import '../models/abstract_appbar.dart';

class MyAppBar extends AbstractAppBar {

  Gradient? gradient;

   MyAppBar({Key? key, required String title}) : super(key: key, title: title);
   

   @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: gradient ??
              const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        ),
      ),
 
    );
  }

}

