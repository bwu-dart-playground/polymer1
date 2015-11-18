@HtmlImport('drag_me.html')
library drag_n_drop.web.drag_me;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'draggable_behavior.dart';

/// []
@PolymerRegister('drag-me')
class DragMe extends PolymerElement with DraggableBehavior {
  DragMe.created() : super.created();

  @Property(notify: true) String message;

  void onBwuDragStart() {
    print('dragStart');
  }
  void onBwuDragOver() {
    print('dragOver');
  }
  void onBwuDragCancel() {
    print('dragCancel');
  }
  void onBwuDrop() {
    print('drop');
  }
}
