library iron_list.foo;

import 'package:polymer/polymer.dart';

class Foo extends JsProxy {
  @reflectable String name = '';
  @reflectable bool selected = false;
  Foo(this.name);
}
