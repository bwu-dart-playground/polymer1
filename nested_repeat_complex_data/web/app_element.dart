@HtmlImport('app_element.html')
library nested_repeat_complex_data.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/iron_icons.dart';

/// [PaperFab], [PaperMaterial], [PaperInput]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property
  List<Produto> produtos = new List();

  void ready() {
    Produto p = new Produto()..descricao = 'teste';
    add('produtos', p);

    Produto p2 = new Produto()..descricao = 'teste 2';
    add('produtos', p2);

    Produto p3 = new Produto()..descricao = 'teste3';
    add('produtos', p3);
    add('produtos.2.componentes', p);
    add('produtos.2.componentes', p2);
  }

  @reflectable
  void adicionarProduto(e, d) {
    //...
    print(e);
  }

  @Listen('change')
  void handleChange(dom.Event event, [_]) {
    final ids = _findIds(event.target);
    print(ids);
    _notifyProdutoChange(produtos, 'produtos', ids.last, 'descricao',
        (event.target as dom.InputElement).value);
  }

  /// [produtos] the value assigned to the property and on recursive calls
  /// passes [Produto.componentes]
  /// [basePath] starts with `produtos` (the property name) and on recursive
  /// calls passes the current (deeper) path
  /// [itemId] the [Produto.id] of the changed item
  /// [property] the name of the field of the changed item. Currently
  /// `descricao` is hardcoded. For more flexibility this would need for example
  /// an attribute on the `<paper-input>` to acquire it in [handleChange] and
  /// pass it to [_notifyProdutoChange].
  /// [newValue] the updated property value
  void _notifyProdutoChange(List<Produto> produtos, String basePath, int itemId,
      String property, newValue,
      [level = 1]) {
    for (int i = 0; i < produtos.length; i++) {
      if (produtos[i].id == itemId) {
        final path = '${basePath}.${i}.${property}';
        print(path);
        notifyPath(path, newValue);
      }
      if (produtos[i].componentes != null &&
          produtos[i].componentes.isNotEmpty &&
          level > 0) {
        _notifyProdutoChange(
            produtos[i].componentes,
            '${basePath}.${i}.componentes',
            itemId,
            property,
            newValue,
            level - 1);
      }
    }
  }

  List<int> _findIds(dom.Element element) {
    var current = element;
    while (current != null && !current.dataset.containsKey('id')) {
      current = current.parent;
    }
    if (current != null) {
      if (current.classes.contains('inner')) {
        return [
          _findIds(current.parent).first,
          int.parse(current.dataset['id'])
        ];
      } else if (current.classes.contains('outer')) {
        return [int.parse(current.dataset['id'])];
      }
    }
    throw 'Found element with attribute "data-id" but it doesn\'t have a class "inner" or "outer" set.';
  }
}

class Produto extends JsProxy {
  static int _id = 0;
  @reflectable
  final id = _id++;

  @reflectable
  String descricao;
  @reflectable
  List<Produto> componentes;
  Produto() {
    componentes = new List();
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(other) {
    return other is Produto && other.id == id;
  }
}
