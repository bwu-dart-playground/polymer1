import 'dart:async' show StreamController, StreamSubscription;
import 'dart:html' as dom;
import 'package:polymer/polymer.dart';

enum DragType { unknown }

class DragOptions {
  DragMoveCallback onDragMove;
  Function onDragEnd;
  Function onDragEvents;
  bool fireDragEvents = false;
  Object data;
  DragType dragType;
  DropTargetCheck dropTargetCheck;
}

typedef void DragMoveCallback(int x, int y, dom.Event detail);
typedef bool DropTargetCheck(dom.Element target);

abstract class DraggableBehavior implements PolymerBase {
  Set<dom.Element> currentTargets = new Set();

  DragOptions opts = new DragOptions();
  DragOptions get _dragOptions => opts;
  set _dragOptions(DragOptions options) {
    opts = options ?? new DragOptions();
  }

  int _startX;
  int _startY;
  int _clientX;
  int _clientY;

  Map _detail(CustomEventWrapper e) => ({
        'clientX': e.client.x,
        'clientY': e.client.y,
        // relatedTarget: element,
        'dragType': opts.dragType,
        'data': opts.data,
      });

//  StreamSubscription _mouseMoveSubscription;
//  StreamSubscription _mouseUpSubscription;
//  StreamSubscription _contextMenuSubscription;

  void _onMouseMove(dom.CustomEvent e) {
    final deltaX = (e.detail['sourceEvent'] as dom.MouseEvent).client.x -
        _clientX +
        _startX;
    final deltaY = (e.detail['sourceEvent'] as dom.MouseEvent).client.y -
        _clientY +
        _startY;

    if (opts.onDragMove != null) {
      opts.onDragMove(deltaX, deltaY, e);
    }

    if (opts.fireDragEvents) {
      var dropTargets = elementsFromPoint(
          (e.detail['sourceEvent'] as dom.MouseEvent).client.x,
          (e.detail['sourceEvent'] as dom.MouseEvent).client.y).where(
          (t) => opts.dropTargetCheck != null || opts.dropTargetCheck(t));

      final newTargets = new Set.from(dropTargets);

      for (final target in currentTargets) {
        if (!newTargets.contains(target)) {
          target.dispatchEvent(new dom.CustomEvent('designer-drag-leave',
              detail: {'detail': _detail(e)}));
        }
      }

      for (final target in dropTargets) {
        if (!currentTargets.contains(target)) {
          target.dispatchEvent(new dom.CustomEvent('designer-drag-enter',
              detail: {'detail': _detail(e)}));
        }
        target.dispatchEvent(new dom.CustomEvent('designer-drag-move',
            detail: {'detail': _detail(e)}));
      }

      currentTargets = newTargets;
    }
  }

  void _onMouseUp(dom.CustomEvent e) {
//    _mouseMoveSubscription.cancel();
//    _mouseMoveSubscription = null;
//    _mouseUpSubscription.cancel();
//    _mouseUpSubscription = null;
//    _contextMenuSubscription.cancel();
//    _contextMenuSubscription = null;

    if (opts.onDragEnd != null) {
      opts.onDragEnd(e);
    }

    if (opts.fireDragEvents) {
      for (final target in currentTargets) {
        target.dispatchEvent(new dom.CustomEvent('designer-drag-drop',
            detail: {'detail': _detail(e)}));
      }
      currentTargets = null;
    }
  }

  void _onMouseOver(dom.MouseEvent e) {}

  void _updateDragProxy(dom.Element proxy, dom.Rectangle<int> bounds) {
//        var style = this.$.proxy.style;
    proxy.style
//      ..display = 'block'
      ..top = '${bounds.top}px'
      ..left = '${bounds.left}px'
      ..width = '${bounds.width}px'
      ..height = '${bounds.height}px';
    print(
        'proxy: top: ${bounds.top}, left: ${bounds.left}, width: ${bounds.width}, height: ${bounds.height}');
  }

  @reflectable
  dragHandler(dom.CustomEvent event, [_]) {
    dom.Element dragProxy;
    print(event.detail['state']);
    switch (event.detail['state']) {
      case 'start':
        dragProxy = createDragProxy(event.target, stripMargins: true);
        _updateDragProxy(
            dragProxy, (event.target as dom.Element).getBoundingClientRect());
        dom.document.body.append(dragProxy);
        startDrag(
            event.detail['x'],
            event.detail['y'],
            (event.target as dom.Element).clientLeft,
            (event.target as dom.Element).clientTop,
            dragOptions: (new DragOptions()
              ..fireDragEvents = true
              ..onDragMove = ((x, y, detail) {
                print('dragMove');
                _updateDragProxy(
                    dragProxy,
                    new dom.Rectangle<int>(
                        x,
                        y,
                        (this as dom.Element).offsetWidth,
                        (this as dom.Element).offsetHeight));
              })
              ..onDragEvents = (() => print('dragEvents'))
              ..onDragEnd = (() {
                print('dragEnd');
                dragProxy.remove();
              })
              ..dropTargetCheck = ((e) => e != this)));
        break;
      case 'track':
        _onMouseMove(event);
        set('message',
            'Tracking in progress... ${event.detail['x']},  ${event.detail['y']}');
        break;
      case 'end':
        _onMouseUp(event);
        set('message', 'Tracking ended!');
        break;
    }
  }

  /**
     * Starts a mouse drag operation.
     *
     * Given an initial client position at (clientX, clientY) and an
     * initial drag position (startX, startY), onMove is called with new
     * drag position.
     */
  void startDrag(int startX, int startY, int clientX, int clientY,
      {DragOptions dragOptions}) {
    this._dragOptions = dragOptions;
    _startX = startX;
    _startY = startY;
    _clientX = clientX;
    _clientY = clientY;

//      let onDragMove = opts.onDragMove;
//      let onDragEnd = opts.onDragEnd;
//      let fireDragEvents = opts.fireDragEvents || false;
//      let data = opts.data;

    // Because receivers can mutate events, we create a new detail for each
    // event we fire. This is important for dragging where a receiver might
    // send data back via the event.

//      if(_mouseMoveSubscription != null) {
//        _mouseMoveSubscription.cancel();
//        _mouseMoveSubscription = null;
//      }
//      if(_mouseUpSubscription != null) {
//        _mouseUpSubscription.cancel();
//        _mouseUpSubscription = null;
//      }
//      if(_contextMenuSubscription != null) {
//        _contextMenuSubscription.cancel();
//        _contextMenuSubscription = null;
//      }
//
//      _mouseMoveSubscription = dom.window.on['mousemove'].listen(_onMouseMove);
//      _mouseUpSubscription = dom.window.on['mouseup'].listen(_onMouseUp);
//      // Note document instead of window:
//      // http://www.quirksmode.org/dom/events/contextmenu.html
//      _contextMenuSubscription = dom.document.on['contextmenu'].listen(_onMouseUp);
  }

  /// Deep clones a node, only copying visible nodes and inlining all computed
  /// styles.
  dom.Node createDragProxy(dom.Node node, {bool stripMargins: false}) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      return node.clone(true);
    } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
      final element = node as dom.Element;
      final style = element.getComputedStyle();
      if (style.display == 'none') {
        return null;
      }
      dom.Element clone;
      if (style.display == 'inline') {
        clone = element.ownerDocument.createElement('span');
      } else {
        clone = element.ownerDocument.createElement('div');
      }
      for (final attr in element.attributes.keys
          .where((key) => element.attributes[key] != null)) {
        clone.attributes[attr] = element.attributes[attr];
      }
      // TODO(zoechi) figure out how to do that in Dart
//      final properties = style.lengthcss.getStyleProperties(style);
//      final styleText = Object.keys(properties)
      for (int i = 0; i < style.length; i++) {
        final propertyName = style.item(i);

        if (!(stripMargins && propertyName.startsWith('margin'))) {
          clone.style
              .setProperty(propertyName, style.getPropertyValue(propertyName));
        }
      }
      clone.style
        ..display = 'block'
        ..position = 'absolute';
//        .join('; ');
//      clone.attributes['style'] = styleText;
      for (int i = 0; i < node.childNodes.length; i++) {
        final child = createDragProxy(node.childNodes[i]);
        if (child != null) {
          clone.append(child);
        }
      }
      clone.style.position = 'absolute';
      return clone;
    }
    return null;
  }

  //
  // returns a list of all elements under the cursor
  // source from https://gist.github.com/oslego/7265412
  //
  List<dom.Element> elementsFromPoint(int x, int y) {
    final List<dom.Element> elements = [];
    final List<Map> previousPointerEvents = [];
    dom.Element current;

    current = dom.document.elementFromPoint(x, y);
    // get all elements via elementFromPoint, and remove them from hit-testing in order
    while (elements.indexOf(current) == -1 && current != null) {
      // push the element and its current style
      elements.add(current);
      previousPointerEvents.add({
        'value': current.style.getPropertyValue('pointer-events'),
        'priority': current.style.getPropertyPriority('pointer-events')
      });

      // add "pointer-events: none", to get to the underlying element
      current.style.setProperty('pointer-events', 'none', 'important');
      current = dom.document.elementFromPoint(x, y);
    }

    // restore the previous pointer-events values
    for (int i = 0; i < previousPointerEvents.length - 1; i++) {
      Map d = previousPointerEvents[i];
      elements[i]
          .style
          .setProperty('pointer-events', d['value'] ?? '', d['priority']);
    }

    // return our results
    return elements;
  }
}
