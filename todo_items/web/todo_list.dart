@HtmlImport('todo_list.html')
library app.todo.todo_list;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('todo-list')
class TodoList extends PolymerElement {
  TodoList.created() : super.created();

  @property
  List<String> items;
}
