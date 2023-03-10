
import 'package:flutter/material.dart';

abstract class AbstractAppBar extends StatelessWidget implements PreferredSizeWidget {
   AbstractAppBar({Key? key, required this.title}) : super(key: key);

  final String title;
  

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}