@HtmlImport('app_element.html')
library select_checkbox_menu.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';
import 'select_checkbox_menu.dart';

/// [SelectCheckboxMenu]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @reflectable
  void printSelected([_, __]) {
    print(items.where((Map e) => e['checked']));
  }
  @property
  List items = [
    {'name': 'Croissant', 'checked': false},
    {'name': 'Donut', 'checked': false},
    {'name': 'Financier', 'checked': true},
    {'name': 'madeleine', 'checked': false},
    {'name': 'a', 'checked': false},
    {'name': 'b', 'checked': false},
    {'name': 'c', 'checked': false},
    {'name': 'd', 'checked': false},
    {'name': 'e', 'checked': false},
    {'name': 'f', 'checked': false},
    {'name': 'g', 'checked': false},
    {'name': 'h', 'checked': false},
    {'name': 'i', 'checked': false},
    {'name': 'j', 'checked': false},
    {'name': 'k', 'checked': false},
    {'name': 'l', 'checked': false},
    {'name': 'm', 'checked': false},
    {'name': 'n', 'checked': false},
    {'name': 'o', 'checked': false},
    {'name': 'p', 'checked': false},
    {'name': 'q', 'checked': false},
    {'name': 'r', 'checked': false},
    {'name': 's', 'checked': false},
    {'name': 't', 'checked': false},
    {'name': 'u', 'checked': false},
    {'name': 'v', 'checked': false},
    {'name': 'w', 'checked': false},
    {'name': 'x', 'checked': false},
    {'name': 'y', 'checked': false},
    {'name': 'z', 'checked': false},
    {'name': 'a1', 'checked': false},
    {'name': 'a2', 'checked': false},
    {'name': 'a3', 'checked': false},
    {'name': 'a4', 'checked': false},
    {'name': 'a5', 'checked': false},
    {'name': 'a6', 'checked': false},
  ];

  @property
  List items2 = [
    new Item('Croissant', false),
    new Item('Donut', false),
    new Item('Financier', true),
    new Item('madeleine', false),
    new Item('a', false),
    new Item('b', false),
    new Item('c', false),
    new Item('d', false),
    new Item('e', false),
    new Item('f', false),
    new Item('g', false),
    new Item('h', false),
    new Item('i', false),
    new Item('j', false),
    new Item('k', false),
    new Item('l', false),
    new Item('m', false),
    new Item('n', false),
    new Item('o', false),
    new Item('p', false),
    new Item('q', false),
    new Item('r', false),
    new Item('s', false),
    new Item('t', false),
    new Item('u', false),
    new Item('v', false),
    new Item('w', false),
    new Item('x', false),
    new Item('y', false),
    new Item('z', false),
    new Item('a1', false),
    new Item('a2', false),
    new Item('a3', false),
    new Item('a4', false),
    new Item('a5', false),
    new Item('a6', false),
  ];
}

class Item extends JsProxy {
  String name;
  bool checked;

  Item(this.name, this.checked);

  dynamic operator [](String key) {
    switch(key) {
      case 'name': return name;
      case 'checked': return checked;
      default: throw 'Property "${key}" doesn\'t exist';
    }
  }
}
