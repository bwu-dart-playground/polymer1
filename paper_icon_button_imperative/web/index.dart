library _template.web;

import 'dart:html' as dom;
import 'package:polymer/polymer.dart';
import 'app_element.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/communication_icons.dart';

/// [AppElement]
main() async {
  await initPolymer();
  PaperButton paperButtonForget = new PaperButton();
  IronIcon iconClear = new IronIcon()..icon = 'communication:email';
  paperButtonForget.append(iconClear);
  paperButtonForget.append(new dom.Text("Forget"));
  paperButtonForget.attributes['raised']='true';
  dom.document.body.append(paperButtonForget);
}

