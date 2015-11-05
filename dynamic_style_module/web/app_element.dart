@HtmlImport('app_element.html')
library dynamic_style_module.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'my_theme.dart';
import 'default_theme.dart';
import 'grid_element.dart';
import 'column_config.dart';

/// [defaultThemeSilence], [myThemeSilence], [GridElement]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property String theme = 'default-theme';
  @reflectable
  void changeThemeHandler([_, __]) {
    set('theme', theme == 'default-theme' ? 'my-theme' : 'default-theme');
  }

  @property List<ColumnConfig> columnConfig = [
    new ColumnConfig()
      ..name = 'Title'
      ..width = 100
      ..cssClasses = ['title']
      ..headerRowCssClasses = ['header', 'first', 'title'],
    new ColumnConfig()
      ..name = 'Year'
      ..width = 60
      ..cssClasses = ['year']
      ..headerRowCssClasses = ['header', 'year', 'align-right'],
  ];

  @property List<List> data = [
    ['The Dark Knight', 2008],
    ['Groundhog Day', 1993],
    ['Spectre', 2015]
  ];
}
