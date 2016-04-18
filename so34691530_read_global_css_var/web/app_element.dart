@HtmlImport('app_element.html')
library so34691530_read_global_css_var.web.app_element;

import 'dart:async' show Future;
import 'dart:html' show document;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  ready() {
    new Future(() {
      // seems not to be possible, `style is="cusotm-style" isn't upgraded to a custom element
//      CustomStyle style = document.querySelector('#globalStyle');
//      print(style.customStyle['--my-color']);
    });
  }
}
