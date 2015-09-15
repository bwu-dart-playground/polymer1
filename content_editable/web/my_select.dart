@HtmlImport('my_select.html')
library content_editable.my_select;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'dart:html' as dom;
import 'package:polymer/polymer.dart';

@PolymerRegister('my-select')
class MySelect extends PolymerElement {
  @Property(notify: true, observer: 'textChanged') String text = "bla";

  MySelect.created() : super.created();

  @eventHandler
  void textChanged(newValue, _) {
    print('currentIndexChange: ${newValue}');
  }

  dom.DivElement _editable;
  @override
  attached() {
    _editable = $['editable'];
  }

  @eventHandler
  inputHandler(e, [_]) {
    set('text', _editable.innerHtml);
    print(text);
  }

  @eventHandler
  blurHandler(e, [_]) {
    print('x');
  }
}
