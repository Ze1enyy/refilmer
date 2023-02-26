import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Color bgColor = const Color(0xFF252525);
Color tileColor = const Color(0xff505050);
Color appBarColor = const Color(0xff2C2C2C);

TextStyle primaryText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: !kIsWeb ? 20 : 30);

TextStyle secondaryText = const TextStyle(
    color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15);
