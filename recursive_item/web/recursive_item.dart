@HtmlImport('recursive_item.html')
library recursive_item.web.recursive_item;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('recursive-item')
class RecursiveItem extends PolymerElement {
  RecursiveItem.created() : super.created();

  @property
  RecursiveModel item;

  @reflectable
  bool computeHasChildren(RecursiveModel item) {
    return item.children.isNotEmpty;
  }

  @reflectable
  void arrayItem(change, index) {
    return change['base'][index];
  }

  @reflectable
  String computeName(RecursiveModel item) {
    return item.other.name;
  }
}

class RecursiveModel extends JsProxy {
  @reflectable
  List<RecursiveModel> children = <RecursiveModel>[];
  @reflectable
  Other other;
}

class Other extends JsProxy {
  @reflectable
  String name;

  Other(this.name);
}
