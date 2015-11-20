@HtmlImport('grid_element.html')
library dynamic_style_module.web.grid_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'column_config.dart';

/// []
@PolymerRegister('grid-element')
class GridElement extends PolymerElement {
  static int _uniqueIdCounter = 0;

  GridElement.created() : super.created();

  @Property(reflectToAttribute: true) String gridUniqueId =
      'grid${_uniqueIdCounter++}';

  @Property(observer: 'themeChanged') String theme;

  @property List<ColumnConfig> columnConfig;

  @property List<List> data;

  void ready() {
    print('ready: ${($['grid'] as dom.Element).offsetTop}');
  }

  @reflectable
  void printTop([_, __]) {
    print('ready: ${($['grid'] as dom.Element).offsetTop}');
    rebuildGrid();
  }

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
    rebuildGrid();
  }

  @Observe('columnConfig,data')
  void rebuildGrid([_, __]) {
    try {
      final grid = new PolymerDom($['grid']);
      for (final child in grid.children.toList()) {
        grid.removeChild(child);
      }
      PolymerDom.flush();
      if (data != null && columnConfig != null) {
        final gridTop = (grid.node as dom.Element).offsetTop;
        print(gridTop);
        updateCellPositionRules();

        final int rowHeight = 19;

        int rowNum = 0;

        int rowTop = gridTop + rowNum * rowHeight;
        final headerRowHtml = new dom.DivElement()
          ..classes.add('header-row')
          ..style.height = '${rowHeight}px';
        int colNum = 0;
        for (final colConfig in columnConfig) {
          final colHtml = new dom.DivElement()
            ..text = colConfig.name
            ..classes.addAll(<String>['cell', 'l$colNum', 'r$colNum']
              ..addAll(colConfig.headerRowCssClasses));
          headerRowHtml.append(colHtml);
          colNum++;
        }
        grid.append(headerRowHtml);

        for (final row in data) {
          rowNum++;
          rowTop = gridTop + rowNum * rowHeight;

          final rowHtml = new dom.DivElement()
            ..classes.addAll(['row', rowNum % 2 == 0 ? 'even' : 'odd'])
            ..style.top = '${rowTop}px'
            ..style.height = '${rowHeight}px';

          colNum = 0;
          for (final colConfig in columnConfig) {
            final colHtml = new dom.DivElement()
              ..text = (row[colNum] as Object)?.toString() ?? ''
              ..classes.addAll(<String>['cell', 'l$colNum', 'r$colNum']
                ..addAll(colConfig.cssClasses));
            rowHtml.append(colHtml);
            colNum++;
          }
          grid.append(rowHtml);
        }
      }
      PolymerDom.flush();
//      updateStyles();
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
    final rules = <String>[];
    for (final colConfig in columnConfig) {
      rules.add(
          '.l$colNum { left: ${gridLeft}px; width: ${colConfig.width}px; }');
      gridLeft += colConfig.width + 11;
      colNum++;
    }

    final style = new dom.StyleElement()..id = gridUniqueId;
    style.text = rules.join('\n');
    new PolymerDom(root).append(style);
    PolymerDom.flush();
    updateStyles();
  }
}
