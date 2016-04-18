@HtmlImport('drag_me.html')
library drag_n_drop.web.drag_me;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'draggable_behavior.dart';

/// []
@PolymerRegister('drag-me')
class DragMe extends PolymerElement with DraggableBehavior {
  DragMe.created() : super.created();

  @Property(notify: true) String message;

  @override
  void onBwuDragStart() {
//    print('dragStart');
    super.onBwuDragStart();
    style.visibility = 'hidden';
  }

  @override
  bool onBwuDragOver(dom.CustomEvent event, dom.Element element) {
//    print('dragOver');
    return super.onBwuDragOver(event, element);
  }

  @override
  void onBwuDragEnd(dom.CustomEvent event, dom.Element dropTarget) {
//    print('dragEnd');
    super.onBwuDragEnd(event, dropTarget);
    if(dropTarget != null) {
      new PolymerDom(dropTarget).append(this);
    }
    style.visibility = 'visible';
  }

  @override
  void onBwuDragMove(int x, int y, dom.CustomEvent e) {
//    print('dragMove');
    super.onBwuDragMove(x, y, e);
  }
}
