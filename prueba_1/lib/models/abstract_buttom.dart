
import 'package:flutter/material.dart';

abstract class AbstractButton extends StatefulWidget {
  final String text;
  final Function onTap;

  const AbstractButton({super.key, 
    required this.text, required this.onTap,
  });
}