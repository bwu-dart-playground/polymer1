@HtmlImport('app_element.html')
library array_selector.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property List employees = [
    {'first': 'Bob', 'last': 'Smith'},
    {'first': 'Sally', 'last': 'Johnson'},
  ];

  @reflectable
  void toggleSelection(dom.Event event, [_]) {
    final Map item =
        convertToDart(new DomRepeatModel.fromEvent(event).item);
    ($['selector'] as ArraySelector).select(item);
  }
}
