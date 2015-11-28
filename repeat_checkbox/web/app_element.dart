@HtmlImport('app_element.html')
library repeat_checkbox.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property List<Data> data = <Data>[
    new Data('first', true),
    new Data('second', false),
    new Data('third', true)
  ];

  @Observe('data.*')
  void checkedChange(Map changes) {
    print('path: ${changes['path']}');
    print(changes);
  }
}

class Data extends JsProxy {
  bool _checked;
  @reflectable
  bool get checked => _checked;
  @reflectable
  set checked(bool value) {
    print('checked: $value');
    _checked = value;
  }
  @reflectable String name;
  Data(this.name, this._checked);
}
