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
    // for gesture events see https://www.polymer-project.org/1.0/docs/devguide/events.html#gestures
//    print(event.detail);
    trackEventHandler(event, _);
  }
}
