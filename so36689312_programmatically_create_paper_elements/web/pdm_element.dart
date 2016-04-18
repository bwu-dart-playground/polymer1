@HtmlImport('pdm_element.html')
library pdm;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

/// elements
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_listbox.dart';

///
@PolymerRegister('pdm-element')
class PdmElement extends PolymerElement {
  PdmElement.created() : super.created();

  List<PaperItem> _makePapersElements() {
    List<PaperItem> _items = new List<PaperItem>();

    for (var i = 0; i < 13; i++) {
      PaperItem item = new PaperItem();
      item.text = '$i';

      _items.add(item);
    }

    return _items;
  }

  @override
  void attached() {
    List<PaperItem> items = _makePapersElements();

    PaperDropdownMenu dropMenu = new PaperDropdownMenu();
    PaperListbox listBox = new PaperListbox();
    listBox.classes.add("dropdown-content");

    PolymerDom listboxDom = new PolymerDom(listBox);
    for(var item in items) {
      listboxDom.append(item);
    }

    new PolymerDom(dropMenu)..append(listBox);
    new PolymerDom($['example']).append(dropMenu);

  }
}
