@HtmlImport('app_element.html')
library font_size_imperatively.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/paper_header_panel.dart';
import 'package:polymer_elements/paper_toolbar.dart';
import 'package:polymer_elements/paper_tabs.dart';
import 'package:polymer_elements/paper_tab.dart';

/// [PaperButton], [PaperHeaderPanel], [PaperToolbar], [PaperTabs], [PaperTab]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @reflectable
  void handleBigger(var event, var x) {
    customStyle['--my-theme-font-size'] = '250%';
    Polymer.updateStyles();
  }
}
