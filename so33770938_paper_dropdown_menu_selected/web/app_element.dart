@HtmlImport('app_element.html')
library so33770938_paper_dropdown_menu_selected.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_item.dart';

/// [PaperDropdownMenu], [PaperMenu], [PaperItem]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property var selectedItem;

  @property var selectedItemLabel;

  @Property(computed: 'getSelectedItemValue(selectedItem)')
  String selectedItemValue;

  @reflectable
  String getSelectedItemValue(dom.Element selectedItem) {
    DomRepeatModel model =
        ($['ddmtr'] as DomRepeat).modelForElement(selectedItem);
    return suffixes[model.index];
  }

  @property
  List<String> suffixes = <String>['I', 'II', 'III', 'Junior', 'Senior'];
}
