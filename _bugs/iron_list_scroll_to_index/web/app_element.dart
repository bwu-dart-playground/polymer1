@HtmlImport('app_element.html')
library iron_list_scroll_to_index.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_list.dart';
import 'package:polymer_elements/paper_button.dart';

// See http://stackoverflow.com/questions/33743340/how-to-scroll-to-the-last-element-of-iron-list-dart-polymer-1-0
/// [IronList], [PaperButton]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property
  List<String> items = [];

  @reflectable
  void onAdd([_, __]) {
    var fst = items.length;
    var lst = new List.generate(30, (x) => (fst + x).toString());
    addAll("items", lst);
    ($['list'] as IronList).scrollToIndex(items.length - 1);
  }
}
