@HtmlImport('div_editable.html')
library content_editable.div_editable;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'dart:html' as dom;

@PolymerRegister('div-editable', extendsTag: 'div')
class DivEditable extends dom.DivElement
    with PolymerMixin, PolymerBase, JsProxy {

  DivEditable.created() : super.created() {
    polymerCreated();
  }
}
