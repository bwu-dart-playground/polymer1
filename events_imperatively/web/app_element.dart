@HtmlImport('app_element.html')
library events_imperatively.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_button.dart';

/// [PaperButton]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  void attached() {
    super.attached();
    listen($['btn'], 'click', 'clickHandler');
  }

  @reflectable
  void clickHandler([_, __]) {
    print('click');
  }
}
