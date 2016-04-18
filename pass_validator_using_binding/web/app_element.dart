@HtmlImport('app_element.html')
library pass_validator_using_binding.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'child_element.dart';

/// [ChildElement]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property dom.NodeValidator validator = new dom.NodeValidatorBuilder();

  @property String text = 'some text';
}
