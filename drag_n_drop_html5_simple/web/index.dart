library _template.web;

import 'dart:html' as dom;
import 'dart:convert' show JSON;

main() async {
  dom.Element drag = dom.querySelector('.draggable');
  drag.onDragStart.listen((event) {
    final startPos = (event.target as dom.Element).getBoundingClientRect();
    final data = JSON.encode({
      'id': (event.target as dom.Element).id,
      'x': event.client.x - startPos.left,
      'y': event.client.y - startPos.top
    });
    event.dataTransfer.setData('text', data);
  });

  dom.Element dropTarget = dom.querySelector('#dropzone');
  dropTarget.onDragOver.listen((event) {
    event.preventDefault();
    dropTarget.classes.add('droptarget');
  });

  dropTarget.onDragLeave.listen((event) {
    dropTarget.classes.remove('droptarget');
  });

  dropTarget.onDrop.listen((event) {
    event.preventDefault();
    final data = JSON.decode(event.dataTransfer.getData('text'));
    final drag = dom.document.getElementById(data['id']);
    event.target.append(drag);
    drag.style
      ..position = 'absolute'
      ..left = '${event.offset.x - data['x']}px'
      ..top = '${event.offset.y - data['y']}px';
    dropTarget.classes.remove('droptarget');
  });
}
