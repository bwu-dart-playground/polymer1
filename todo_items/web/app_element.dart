@HtmlImport('app_element.html')
library _template.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';
import 'todo_list.dart';

/// [ToDoList]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property List<String> todoItems = [
      'One',
      'Two',
    ];
}
