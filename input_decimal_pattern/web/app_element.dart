@HtmlImport('app_element.html')
library input_decimal_pattern.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';

/// [PaperInput]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property
  String inputValue = '';
}
