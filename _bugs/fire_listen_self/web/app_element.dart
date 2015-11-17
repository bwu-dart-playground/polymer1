@HtmlImport('app_element.html')
library fire_listen_self.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  ready() {
    on['syntax-highlight'].listen(print);
    fire('syntax-highlight', detail: {'detail': 'xxx'});
  }
}
