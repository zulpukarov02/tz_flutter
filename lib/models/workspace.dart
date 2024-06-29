import 'package:flutter/material.dart';

class Workspace {
  final String name;
  final Color color;

  Workspace(this.name, this.color);

  Workspace copyWith({String? name, Color? color}) {
    return Workspace(
      name ?? this.name,
      color ?? this.color,
    );
  }
}
