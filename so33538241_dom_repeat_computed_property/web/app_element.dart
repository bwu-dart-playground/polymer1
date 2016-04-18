@HtmlImport('app_element.html')
library so.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_button.dart';

class Item extends JsProxy{
    @reflectable
    String a="aaa aaa";
    @reflectable
    String b="bbb bbb";
    Item(this.a, this.b);
}

/// [PaperInput], [PaperButton]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property
  List<Item> computedItems;

  @property
  List<Item> items = [];

  @Observe('items.*')
  void computeItems([_, __]) {
    set('computedItems', items);
  }

  @property int itemsChangeIndicator = 0;

  @property
  String inp = '';

  @reflectable
  List<Item> getItems(_) {
      return items;
  }

  @reflectable
  void tapHandler(dom.Event ev, Map details) {
    add("items", new Item(inp, 'aa'));
    set("inp", "");
  }
}
