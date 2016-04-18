@HtmlImport('app_element.html')
library paper_toast_events.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_toast.dart';

/// [PaperToast]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @reflectable
  void eventHandler([dom.CustomEvent e, _]) {
    print(e.type);
  }

//  void attached() {
//    ($$('paper-toast')as PaperToast).show();
//  }
}
