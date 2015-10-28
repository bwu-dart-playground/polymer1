@HtmlImport('app_element.html')
library _template.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property String message = 'Loading...';

   @Listen('click')
   void clickHandler(_, __) {
     set('message', 'changed!');
   }
}
