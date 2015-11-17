@HtmlImport('child_element.html')
library pass_validator_using_binding.web.child_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('child-element')
class ChildElement extends PolymerElement {
  ChildElement.created() : super.created();

  @property dom.NodeValidator validator;

  @property String text;
}
