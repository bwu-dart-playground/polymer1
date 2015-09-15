library auto_binding_element.main;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'dart:js';

// TODO(zoechi) https://github.com/dart-lang/polymer-dart/issues/574

//Map<String, dynamic> $;
JsObject $;
main() async {
  await initPolymer();
  var template = document.querySelector('#t') as DomBind;

  template.on['dom-change'].listen((e) {
    print('dom-change');
  });

  $ = template.$;
  print('x');
  var templateJs = template.jsElement;
  final model = new MyModel();
  templateJs['model'] = jsValue(model);
  // event handlers can't have `.` in declarative syntax and therefore
  // need to be assigned to the template.
  templateJs['buttonTap'] = model.buttonTap;
}

@jsProxyReflectable
class MyModel extends JsProxy {
  String value = 'something';

  buttonTap([Event e, args]) {
    print($['mybutton'].id);
    print('tap!');
  }
}
