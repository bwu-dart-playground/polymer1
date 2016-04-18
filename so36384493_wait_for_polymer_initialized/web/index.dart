library so36384493.web;

import 'dart:html' show document;
import 'package:polymer/polymer.dart';
import 'app_element.dart';

/// [AppElement]
dynamic main() async {
  await initPolymer();
  (document.getElementById("fooDialog") as PolymerElement)
                  .set("opened", true);
}

