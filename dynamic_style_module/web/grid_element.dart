@HtmlImport('grid_element.html')
library dynamic_style_module.web.grid_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

/// []
@PolymerRegister('grid-element')
class GridElement extends PolymerElement {
  static int _uniqueIdCounter = 0;

  GridElement.created() : super.created();

  @Property(reflectToAttribute: true) String gridUniqueId =
      'grid${_uniqueIdCounter++}';

  @Property(observer: 'themeChanged') String theme;

  @Property(observer: 'rebuildGrid') List columnConfig;

  @Property(observer: 'rebuildGrid') List<List> data;

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

  @reflectable
  void rebuildGrid([_, __]) {
    try {
      final container = new PolymerDom($['container']);
      for (final child in container.children.toList()) {
        container.removeChild(child);
      }
      final gridHtml = new dom.DivElement()..classes.add('grid');
      container.append(gridHtml);
      PolymerDom.flush();
      updateCellPositionRules();

      final gridTop = gridHtml.contentEdge.top;
      final int rowHeight = 19;

      int rowNum = 0;

      if (data != null && columnConfig != null) {
        int rowTop = gridTop + rowNum * rowHeight;
        final headerRowHtml = new dom.DivElement()..classes.add('header-row');
        int colNum = 0;
        for (final colConfig in columnConfig) {
          final colHtml = new dom.DivElement()
            ..text = colConfig.name
            ..classes.addAll(<String>['cell', 'l$colNum', 'r$colNum']
              ..addAll(colConfig.headerRowCssClasses as List<String>));
          headerRowHtml.append(colHtml);
          colNum++;
        }
        gridHtml.append(headerRowHtml);

        for (final row in data) {
          rowNum++;
          rowTop = gridTop + rowNum * rowHeight;

          final rowHtml = new dom.DivElement()
            ..classes.addAll(['row', rowNum % 2 == 0 ? 'even' : 'odd'])
            ..style.top = '${rowTop}px';

          colNum = 0;
          for (final colConfig in columnConfig) {
            final colHtml = new dom.DivElement()
              ..text = row[colNum]?.toString() ?? ''
              ..classes.addAll(<String>['cell', 'l$colNum', 'r$colNum']
                ..addAll(colConfig.cssClasses as List<String>));
            rowHtml.append(colHtml);
            colNum++;
          }
          gridHtml.append(rowHtml);
        }
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void updateCellPositionRules() {
    final oldStyle = $$('style#$gridUniqueId');
    if (oldStyle != null) {
      new PolymerDom(root).removeChild(oldStyle);
    }


    int colNum = 0;
    int gridLeft = 0;
    int ruleNum = 0;
    final rules = <String>[];
    for (final colConfig in columnConfig) {
        rules.add('.l$colNum { left: ${gridLeft}px; width: ${colConfig.width}px; }');
      gridLeft += colConfig.width + 11;
      colNum++;
    }

    final style = new dom.StyleElement()..id = gridUniqueId;
    style.text = rules.join('\n');
    new PolymerDom(root).append(style);
//    root.append(style);
    PolymerDom.flush();
//    final dom.CssStyleSheet stylesheet = style.sheet;
    updateStyles();

  }
}
