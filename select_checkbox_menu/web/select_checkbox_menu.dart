@HtmlImport('select_checkbox_menu.html')
library select_checkbox_menu.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/paper_material.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_menu.dart';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_elements/iron_dropdown.dart';

/// [IronIcon], [PaperButton], [PaperInput], [PaperItem], [PaperMenu], [PaperMaterial], [PaperCheckbox], [IronDropdown]
@PolymerRegister('select-checkbox-menu')
class SelectCheckboxMenu extends PolymerElement {
  SelectCheckboxMenu.created() : super.created();

  @property
  String filterValue;

  @reflectable
  Function filter(_) {
    if (filterValue == null || filterValue.isEmpty) {
      return null;
    }
    return filterFunction;
  }

  @reflectable
  bool filterFunction(dynamic item) {
    return item != null &&
        label(item).toLowerCase().contains(filterValue.toLowerCase());
  }

  @property
  List items;

  @property
  String labelAttr = 'label';

  @reflectable
  String label(dynamic item) => '${item[labelAttr]}';

  @reflectable
  void open([_, __]) {
    ($['dropdown'] as IronDropdown).open();
  }
}
