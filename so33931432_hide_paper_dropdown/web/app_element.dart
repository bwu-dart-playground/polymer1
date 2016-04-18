@HtmlImport('app_element.html')
library so33931432_hide_paper_dropdown.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_item.dart';

/// [PaperDropdownMenu], [PaperItem], [PaperMenu]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property
  List<String> countries = ['Austria', 'Belgium', 'Czech Republic', 'United States of America'];
  @property
  bool hideState;

  @Property(observer: 'toggleStateOnUSASelection')
  String countrySelectedItemLabel = '';

  @reflectable
  void toggleStateOnUSASelection(String label, [_]) {
    switch (countrySelectedItemLabel) {
      case 'United States of America':
        set('hideState', false);
        break;
      default:
        set('hideState', true);
    }
  }

  void ready() {
    set('hideState', true);
  }
}
