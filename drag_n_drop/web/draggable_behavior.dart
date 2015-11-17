//import 'dart:async' show StreamController, StreamSubscription;
import 'dart:html' as dom;
import 'package:polymer/polymer.dart';

enum DragType { unknown }

class DragOptions {
  /// Called for track events with status == 'track' (while an element is dragged).
  /// The current pointer position (`x`, `y`) and the original track event are
  /// passed as arguments.
  DragMoveCallback onDragMove;

  /// Called for track events with status == 'end'. The original track event is
  /// passed as argument.
  DragEndCallback onDragEnd;

  /// Fire `bwu-drag-enter`, `bwu-drag-over`, `bwu-drag-leave`, and
  /// `bwu-drag-drop` events on valid drop-targets (dragged over elements where
  /// [dropTargetCheck] returns `true`).
  bool fireDragOverEvents = false;
  // TODO(zoechi) What is it used for?
  Object data;
  // TODO(zoechi) What is it used for?
  DragType dragType;

  /// Called for dragged-over elements, to evaluate whether the element is a
  /// valid drop target and fire `bwu-drag-enter`, `bwu-drag-over`,
  /// `bwu-drag-leave` and `bwu-drag-drop`.
  DropTargetCheck dropTargetCheck;
}

typedef void DragMoveCallback(int x, int y, dom.CustomEvent event);

typedef bool DropTargetCheck(dom.Element target);

typedef void DragEndCallback(dom.CustomEvent event);

abstract class DraggableBehavior implements PolymerBase {
  /// Elements below current drag position
  Set<dom.Element> _currentTargets = new Set<dom.Element>();

  DragOptions _dragOptions;

  int _startX;
  int _startY;
  int _clientX;
  int _clientY;

  Map _detail(CustomEventWrapper e) => ({
        'clientX': e.detail['x'],
        'clientY': e.detail['y'],
        // relatedTarget: element,
        'dragType': _dragOptions.dragType,
        'data': _dragOptions.data,
      });

  void _onTrack(dom.CustomEvent event) {
    final deltaX = event.detail['dx'] + _clientX;
    final deltaY = event.detail['dy'] + _clientY;

//    print('delta: X: ${deltaX}, Y: ${deltaY}');
    if (_dragOptions.onDragMove != null) {
      _dragOptions.onDragMove(deltaX, deltaY, event);
    }

    if (_dragOptions.fireDragOverEvents) {
      print('hover: ${[event.detail['hover']()]}');
      // TODO(zoechi) try to figure out where and if `elementsFromPoint` has
      // advantages over `e.detail['hover']()`
      final dropTargets = [event.detail['hover']()].where(
//          elementsFromPoint(event.detail['x'], event.detail['y']).where(
              (dom.Element t) => t != null && (_dragOptions == null ||
                  _dragOptions.dropTargetCheck(t)));

      final newTargets = new Set<dom.Element>.from(dropTargets);

      for (final target in _currentTargets) {
        if (!newTargets.contains(target)) {
          target.dispatchEvent(new dom.CustomEvent('bwu-drag-leave',
              detail: {'detail': _detail(event)}));
        }
      }

      for (final target in dropTargets) {
        if (!_currentTargets.contains(target)) {
//          target.attributes.forEach(print);

          target.dispatchEvent(new dom.CustomEvent('bwu-drag-enter',
              detail: {'detail': _detail(event)}));
        }
        target.dispatchEvent(new dom.CustomEvent('bwu-drag-move',
            detail: {'detail': _detail(event)}));
      }

      _currentTargets = newTargets;
    }
  }

  void _onTrackEnd(dom.CustomEvent event) {
    if (_dragOptions.onDragEnd != null) {
      _dragOptions.onDragEnd(event);
    }

    if (_dragOptions.fireDragOverEvents) {
      for (final target in _currentTargets) {
        target.dispatchEvent(new dom.CustomEvent('bwu-drag-drop',
            detail: {'detail': _detail(event)}));
      }
      _currentTargets = new Set<dom.Element>();
    }
  }

  int x = 0;
  void _updateDragProxy(dom.Element proxy, dom.Rectangle<int> bounds) {
//    print('updateDragProxy(${bounds.top}, ${bounds.left}, ${bounds.height}, ${bounds.width})');
    proxy.style
      ..top = '${bounds.top}px'
      ..left = '${bounds.left}px'
      ..width = '${bounds.width}px'
      ..height = '${bounds.height}px';
  }

  @reflectable
  void trackEventHandler(dom.CustomEvent event, [_]) {
    dom.Element dragProxy;
    dom.Element dragOriginal;
    String oldUserSelect;
//    print(event.detail['state']);
    switch (event.detail['state']) {
      case 'start':
        oldUserSelect = dom.document.body.style.getPropertyValue('user-select');
        dom.document.body.style.userSelect = 'none';
        dragOriginal = event.target;
        final originalDimension =
            dragOriginal.getBoundingClientRect() as dom.Rectangle<int>;
        dragProxy = createDragProxy(event.target, stripMargins: true);
        dragProxy.style
          ..opacity = '0.75'
          ..border = 'dotted 2px darkgray';

        _updateDragProxy(dragProxy, originalDimension);
        dom.document.body.append(dragProxy);
        startDrag(event.detail['x'], event.detail['y'], originalDimension.left,
            originalDimension.top,
            dragOptions: (new DragOptions()
              ..fireDragOverEvents = true
              ..onDragMove = ((int x, int y, dom.CustomEvent e) {
//                print('dragMove');
                final bounds = dragOriginal.getBoundingClientRect();
                _updateDragProxy(dragProxy,
                    new dom.Rectangle<int>(x, y, bounds.width, bounds.height));
              })
              ..onDragEnd = ((dom.CustomEvent e) {
//                print('dragEnd');
                dragProxy.remove();
              })
              ..dropTargetCheck = ((dom.Element e) => e != this && e.attributes['my-drop-target'] == 'true')));
        break;
      case 'track':
        _onTrack(event);
        set('message',
            'Tracking in progress... ${event.detail['x']},  ${event.detail['y']}');
        break;
      case 'end':
        dom.document.body.style.userSelect = oldUserSelect;
        _onTrackEnd(event);
        set('message', 'Tracking ended!');
        break;
    }
  }

  /// Starts a mouse drag operation.
  ///
  /// Given an initial client position at (clientX, clientY) and an
  /// initial drag position (startX, startY), onMove is called with new
  /// drag position.
  void startDrag(int startX, int startY, int clientX, int clientY,
      {DragOptions dragOptions}) {
    this._dragOptions = dragOptions;
    _startX = startX;
    _startY = startY;
    _clientX = clientX;
    _clientY = clientY;
//    print('startDrag: startX: ${_startX}, startY: ${_startY}, clientX: ${_clientX}, clientY: ${_clientY}');
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
          .where((String key) => element.attributes[key] != null)) {
        clone.attributes[attr] = element.attributes[attr];
      }
      clone.attributes.remove('id');
      // TODO(zoechi) figure out how to do that in Dart
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

  // returns a list of all elements under the cursor
  // source from https://gist.github.com/oslego/7265412
  // TODO(zoechi) disabling and enabling `pointer-events` seems to break
  // polymer-gestures
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
