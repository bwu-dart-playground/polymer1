@HtmlImport('app_element.html')
library iron_list.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_list.dart';
import 'foo.dart';
import 'foo_element.dart';

/// [IronList], [FooElement]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @Property(observer: 'selectedChanged')
  Foo selected;

  @property
  List<Foo> data = <Foo>[new Foo('alpha'), new Foo('beta'), new Foo('gamma')];

  @reflectable
  selectedChanged([oldVal, newVal]) {
    print(newVal);
  }

//  @reflectable
//  void activateHandler(dom.CustomEvent e, [_]) {
//    print((e.detail.data as Foo).name);
//  }
}
