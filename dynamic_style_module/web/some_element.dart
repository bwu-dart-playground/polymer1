@HtmlImport('some_element.html')
library dynamic_style_module.web.some_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

/// []
@PolymerRegister('some-element')
class SomeElement extends PolymerElement {
  SomeElement.created() : super.created();

  @Property(observer: 'themeChanged') String theme;

//  @override
//  attached() => themeChanged(null);

  @reflectable
  void themeChanged(String newValue, String oldValue) {
    final root = new PolymerDom(this.root);
    root
        .querySelectorAll('[theme]')
        .forEach((dom.Element e) => root.removeChild(e));
    root.insertBefore(
        new dom.Element.tag('style', 'custom-style')
          ..attributes['theme'] = newValue
          ..attributes['include'] =
              newValue == null ? 'default-theme' : newValue,
        $['placeholder']);
    PolymerDom.flush();
    updateStyles();
  }
}
