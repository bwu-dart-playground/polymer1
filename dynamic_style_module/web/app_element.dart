@HtmlImport('app_element.html')
library dynamic_style_module.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'my_theme.dart';
import 'default_theme.dart';
import 'some_element.dart';

/// [defaultThemeSilence], [myThemeSilence], [SomeElement]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property String theme = 'default-theme';
  @reflectable
  void changeThemeHandler([_, __]) {
    set('theme', theme == 'default-theme' ? 'my-theme' : 'default-theme');
  }
}
