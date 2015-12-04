@HtmlImport('app_element.html')
library style_nested_elements.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_button.dart';

/// [PaperButton]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();
}
