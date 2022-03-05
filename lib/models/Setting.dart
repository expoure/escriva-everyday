import 'dart:convert';

import 'package:flutter/material.dart';

class Setting {
  Setting({
    required this.id,
    required this.notifications,
    required this.caminho,
    required this.sulco,
    required this.forja,
  });

  int id;
  TimeOfDay? notifications;
  int caminho;
  int sulco;
  int forja;

  factory Setting.fromRawJson(String str) => Setting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"] as int,
        caminho: json["caminho"] as int,
        sulco: json["sulco"] as int,
        forja: json["forja"] as int,
        notifications: json["notifications"] != null
            ? TimeOfDay(
                hour: int.parse(json["notifications"].toString().split(':')[0]),
                minute:
                    int.parse(json["notifications"].toString().split(':')[1]))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notifications": notifications,
        "caminho": caminho,
        "sulco": sulco,
        "forja": forja,
      };
}
