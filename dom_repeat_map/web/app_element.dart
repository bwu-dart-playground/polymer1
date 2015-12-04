@HtmlImport('app_element.html')
library dom_repeat_map.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  // see http://stackoverflow.com/questions/32791689/what-is-the-alternative-to-maps-in-polymer-dart-1-0/32812888#32812888

  Map _data = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5, 'f': 6};

  @property
  Iterable get dataKeys => _data.keys;

  @reflectable
  int dataValue(String key) => _data[key];
}
