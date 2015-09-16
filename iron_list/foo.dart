library iron_list.foo;

import 'package:polymer/polymer.dart';

class Foo extends JsProxy {
  String name;
  Foo(this.name);
  bool selected = false;
}
