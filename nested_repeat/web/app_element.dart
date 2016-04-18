@HtmlImport('app_element.html')
library nested_repeat.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property List<List<int>> items = [["1","2"],["3","4"]];

  @reflectable
  test([dom.Event event, _]) {
    // First model
    ($['firstRepeat'] as DomRepeat).modelForElement(event.target);

    // Second model
    ($$('#secondRepeat') as DomRepeat).modelForElement(event.target);
  }
}
