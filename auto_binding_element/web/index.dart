//library auto_binding_element.main;

import 'dart:html';
import 'package:polymer/polymer.dart';
//import 'dart:js';

// TODO(zoechi) https://github.com/dart-lang/polymer-dart/issues/574

//Map<String, dynamic> $;
//JsObject $;
DomBind template;
main() async {
  await initPolymer();
  template = document.querySelector('#t') as DomBind;

  template.on['dom-change'].listen((e) {
    print('dom-change');
  });

//  $ = template.$;
//  var templateJs = template.jsElement;
  final model = new MyModel();
  template['model'] = model;
  // event handlers can't have `.` in declarative syntax and therefore
  // need to be assigned to the template.
  template['buttonTap'] = model.buttonTap;
}

class MyModel extends JsProxy {
  @reflectable
  String value = 'something';

  @reflectable
  buttonTap([Event e, args]) {
    print(template.$['mybutton'].id);
    print('tap! $value');
  }
}
