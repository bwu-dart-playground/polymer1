@HtmlImport('drag_me.html')
library drag_n_drop.web.drag_me;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'draggable_behavior.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('drag-me')
class DragMe extends PolymerElement with DraggableBehavior {
  DragMe.created() : super.created();

  @Property(notify: true) String message;

  @reflectable
  void handleTrack(dom.CustomEvent event, [_]) {
    dragHandler(event, _);
//    print(event.detail['state']);
//    switch (event.detail['state']) {
//      case 'start':
////        set('message', 'Tracking started!');
//        startDrag(
//            event.detail['x'],
//            event.detail['y'],
//            (event.target as dom.Element).clientLeft,
//            (event.target as dom.Element).clientTop,
//            dragOptions: (new DragOptions()
//              ..onDragMove = ((x, y, detail) => print('dragMove'))
//              ..onDragEvents = (() => print('dragEvents'))
//              ..onDragEnd = (() => print('dragEnd'))
//              ..dropTargetCheck = ((e) => e != this)));
//        break;
//      case 'track':
////        set('message',
////            'Tracking in progress... ${event.detail['x']},  ${event.detail['y']}');
////        break;
//      case 'end':
////        set('message', 'Tracking ended!');
////        break;
//    }
  }
}
