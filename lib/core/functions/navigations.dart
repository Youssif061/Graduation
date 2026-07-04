import 'package:flutter/material.dart';

void pushTo(BuildContext context, Widget newScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newScreen));
}

void PushReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}

void navigationReplacement(BuildContext context, Widget newScreen) {
  Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (_) => newScreen));
}

void naviagationPush(BuildContext context, Widget newScreen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => newScreen));
}
