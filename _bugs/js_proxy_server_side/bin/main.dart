import 'package:polymer/polymer.dart';


void main() {
}

class MyModel extends JsProxy {
  @reflectable
  String name;

  MyModel(this.name);
}
