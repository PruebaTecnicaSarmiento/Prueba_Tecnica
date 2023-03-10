import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar(String title) {
  final _title = title;
  return AppBar(
    title: Text(_title),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  );
}
