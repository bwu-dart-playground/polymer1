@HtmlImport('app_element.html')
library _template.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@jsProxyReflectable
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @reflectable
  clickHandler(_,__) {
    print(r'$["shadow1"]');
    print('  ${$["shadow1"].id}');
    print('dom.querySelectorAll(\'div\')');
    dom.querySelectorAll('div').forEach((e) => print('  ${e.id}'));
    print('querySelectorAll(\'div\')');
    querySelectorAll('div').forEach((e) => print('  ${e.id}'));
    print('Polymer.dom(this).querySelectorAll(\'div\')');
    Polymer.dom(this).querySelectorAll('div').forEach((e) => print('  ${e.id}'));
    print('Polymer.dom(this.root).querySelectorAll(\'div\')');
    Polymer.dom(this.root).querySelectorAll('div').forEach((e) => print('  ${e.id}'));
    var e = $$('div');
    print('\$\$(\'div\')');
    print('  ${e.id}');
  }
}
