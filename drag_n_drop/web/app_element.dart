@HtmlImport('app_element.html')
library drag_n_drop.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'drag_me.dart';

/// [DragMe]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property String message;
}
