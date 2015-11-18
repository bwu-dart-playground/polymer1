//import 'dart:async' show StreamController, StreamSubscription;
import 'dart:html' as dom;
import 'package:polymer/polymer.dart';

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

  /// This object is passed as `detail` to the events fired on drop-target
  /// candidates.
  Object data;

  /// Called for dragged-over elements, to evaluate whether the element is a
  /// valid drop target and fire `bwu-drag-enter`, `bwu-drag-over`,
  /// `bwu-drag-leave` and `bwu-drag-drop`.
  DropTargetCheck dropTargetCheck;

  /// If `lockUserSelectOnElement` is not `null` the values `style.userSelect`
  /// value will be set to `none` on  `dragStart` and restored to the original
  /// value on `dragEnd` to prevent text selection during drag-n-drop.
  dom.Element lockUserSelectOnElement;
}

typedef void DragMoveCallback(int x, int y, dom.CustomEvent event);

typedef bool DropTargetCheck(dom.Element target);

typedef void DragEndCallback(dom.CustomEvent event);

abstract class DraggableBehavior implements PolymerBase {
  /// Elements below current drag position
  Set<dom.Element> _currentTargets = new Set<dom.Element>();

  DragOptions _dragOptions;

  /// The position of the dragSource element when dragging was started.
  int _clientX;
  int _clientY;

  /// Lock `user-select` of [_dragOptions.lockUserSelectOnElement] on trackStart
  /// and restore the original value on trackEnd.
  String _oldUserSelect;
  String _oldUserSelectPriority;

  /// Creates a [Map] from a track event to be passed as `detail` for events
  /// fired on drop targets.
  Map _detail(CustomEventWrapper e) => ({
        'clientX': e.detail['x'],
        'clientY': e.detail['y'],
        'data': _dragOptions.data,
      });

  void onBwuDragStart() {}
  void onBwuDragOver() {}
  void onBwuDragCancel() {}
  void onBwuDrop() {}

  @reflectable
  void trackEventHandler(dom.CustomEvent event, [_]) {
    dom.Element dragSource;
    dom.Element dragProxy;
    switch (event.detail['state']) {
      case 'start':
        dragSource = event.target;

        final dragSourceDimension =
            dragSource.getBoundingClientRect() as dom.Rectangle<int>;
        dragProxy = createDragProxy(event.target, stripMargins: true);
        dragProxy.style
          ..opacity = '0.75'
          ..border = 'dotted 2px darkgray';
        _updateDragProxy(dragProxy, dragSourceDimension);
        dom.document.body.append(dragProxy);

        startDrag(dragSourceDimension.left, dragSourceDimension.top,
            dragOptions: (new DragOptions()
              ..data = dragSource
              ..lockUserSelectOnElement = dom.document.body
              ..fireDragOverEvents = true
              ..onDragMove = ((int x, int y, dom.CustomEvent e) {
                _updateDragProxy(
                    dragProxy,
                    new dom.Rectangle<int>(x, y, dragSourceDimension.width,
                        dragSourceDimension.height));
              })
              ..onDragEnd = ((dom.CustomEvent e) {
                dragProxy.remove();
              })
              ..dropTargetCheck = ((dom.Element e) =>
                  e != this && e.attributes['my-drop-target'] == 'true')));
        break;
      case 'track':
        _onTrack(event);
        break;
      case 'end':
        _onTrackEnd(event);
        break;
    }
  }

  /// Starts a drag operation.
  void startDrag(int clientX, int clientY, {DragOptions dragOptions}) {
    this._dragOptions = dragOptions ?? new DragOptions();
    _clientX = clientX;
    _clientY = clientY;
    if (dragOptions.lockUserSelectOnElement != null) {
      _oldUserSelect = dragOptions.lockUserSelectOnElement.style.userSelect;
      _oldUserSelectPriority = dragOptions.lockUserSelectOnElement.style
          .getPropertyPriority('user-select');
      dragOptions.lockUserSelectOnElement.style.userSelect = 'none';
    }

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
      clone.style
        ..position = 'absolute'
        ..pointerEvents = 'none';
      return clone;
    }
    return null;
  }

  /// Process drag move.
  void _onTrack(dom.CustomEvent event) {
    final deltaX = event.detail['dx'] + _clientX;
    final deltaY = event.detail['dy'] + _clientY;

    if (_dragOptions.onDragMove != null) {
      _dragOptions.onDragMove(deltaX, deltaY, event);
    }

    if (_dragOptions.fireDragOverEvents) {
      // e.detail['hover']()` only returns one (the top most hovered element)
      // `elementsFromPoint` is supposed to return all elements below the
      // current pointer position even those covered by other elements.
      final dropTargets = [event.detail['hover']()]
          .where(
//          elementsFromPoint(event.detail['x'], event.detail['y']).where(
              (dom.Element t) => t != null &&
                  (_dragOptions == null || _dragOptions.dropTargetCheck(t)))
          .toList() as List<dom.Element>;

      final newTargets = new Set<dom.Element>.from(dropTargets);

      for (final target in _currentTargets) {
        if (!newTargets.contains(target)) {
          target.dispatchEvent(new dom.CustomEvent('bwu-drag-leave',
              detail: {'detail': _detail(event)}));
        }
      }

      for (final target in dropTargets) {
        if (!_currentTargets.contains(target)) {
          target.dispatchEvent(new dom.CustomEvent('bwu-drag-enter',
              detail: {'detail': _detail(event)}));
        }
        target.dispatchEvent(new dom.CustomEvent('bwu-drag-move',
            detail: {'detail': _detail(event)}));
      }

      _currentTargets = newTargets;
    }
  }

  /// Finish drag operation.
  void _onTrackEnd(dom.CustomEvent event) {
    if (_dragOptions.onDragEnd != null) {
      _dragOptions.onDragEnd(event);
    }

    if (_dragOptions.lockUserSelectOnElement != null) {
      _dragOptions.lockUserSelectOnElement.style.userSelect = _oldUserSelect;
      _dragOptions.lockUserSelectOnElement.style
          .setProperty('user-select', _oldUserSelect, _oldUserSelectPriority);
    }

    if (_dragOptions.fireDragOverEvents) {
      for (final target in _currentTargets) {
        target.dispatchEvent(new dom.CustomEvent('bwu-drag-drop',
            detail: {'detail': _detail(event)}));
      }
      _currentTargets = new Set<dom.Element>();
    }
  }

  void _updateDragProxy(dom.Element proxy, dom.Rectangle<int> bounds) {
    proxy.style
      ..top = '${bounds.top}px'
      ..left = '${bounds.left}px'
      ..width = '${bounds.width}px'
      ..height = '${bounds.height}px';
  }

  // returns a list of all elements under the cursor
  // source from https://gist.github.com/oslego/7265412
  // TODO(zoechi) disabling and enabling `pointer-events` seems to break
  // polymer-gestures (restore seems not to work properly)
  List<dom.Element> _elementsFromPoint(int x, int y) {
    final elements = <dom.Element>[];
    final previousPointerEvents = <Map>[];
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
