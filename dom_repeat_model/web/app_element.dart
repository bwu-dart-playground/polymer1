@HtmlImport('app_element.html')
library nested_repeat.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// [PaperInput]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property List<List<int>> items = [
    {
      "produto": "Prego",
      "unidade": "Unitário",
      "margem_contribuicao": 10.0,
      "preco_sugerido": 5.0,
    },
    {
      "produto": "Madeira",
      "unidade": "Unitário",
      "margem_contribuicao": 10.0,
      "preco_sugerido": 5.0,
    }
  ];

  @reflectable
  calcularPrecoSugeridoEvento(dom.Event event, [_]) {
    // First model
//    ($['firstRepeat'] as DomRepeat).modelForElement(event.target);
    print(new PolymerEvent(event).localTarget.dataset['index']);
    print(($['lista_produtos'] as DomRepeat).modelForElement(event.target).index);
  }
}
