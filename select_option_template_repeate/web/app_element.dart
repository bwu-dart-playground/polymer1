@HtmlImport('app_element.html')
library select_option_template_repeate.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();
  @property
  List<Map>  countries = <Map>[
    {'name': 'Austria', 'isoCode': '123'},
    {'name': 'Germany', 'isoCode': '345'},
    {'name': 'Italy', 'isoCode': '456'},
  ];
}

