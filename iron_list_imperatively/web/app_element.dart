@HtmlImport('app_element.html')
library iron_list_imperatively.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_list.dart';
import 'foo.dart';
import 'foo_element.dart';

/// [IronList], [FooElement]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @Property(observer: 'selectedChanged')
  Foo selected;

  @property
  List<Foo> _data = <Foo>[new Foo('alpha'), new Foo('beta'), new Foo('gamma')];

  @reflectable
  selectedChanged([oldVal, newVal]) {
    print(newVal);
  }

  final _nodeValidator = new dom.NodeValidatorBuilder()
    ..allowElement('DIV', attributes: ['class', 'id'])
    ..allowElement('TEMPLATE')
    ..allowCustomElement('IRON-LIST')
    ..allowCustomElement('FOO-ELEMENT', attributes: ['foo'])
    ..allowCustomElement('ARRAY-SELECTOR', attributes: ['class', 'id']);
  @override
  void attached() {
    final IronList list = (new dom.Element.html(
        '''
<iron-list>
  <template>
    <foo-element foo="{{item}}"></foo-element>
  </template>
</iron-list>
''',
        validator: _nodeValidator) as IronList)..set('items', _data);
    (Polymer.dom($['placeholder']) as PolymerDom).append(list);
//    (Polymer.dom($['placeholder']) as PolymerDom).querySelectorAll('iron-list')
    list
      ..selectionEnabled = true
      ..on['selected-item-changed'].listen((e) {
        print(e);
      });
  }

  @reflectable
  void activateHandler(dom.CustomEvent e, [_]) {
    print((e.detail.data as Foo).name);
  }
}
