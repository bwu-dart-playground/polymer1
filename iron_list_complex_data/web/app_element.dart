@HtmlImport('app_element.html')
library iron_list_complex_data.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_list.dart';

/// [IronList],
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
//  AppElement.created() : super.created();

  @property
  List<ItemText> listitem;

  @property
  int nrelements = 10;

  @property ItemText selectedItem;

  // Constructor used to create instance of MainApp.
  AppElement.created() : super.created(){
    List<ItemText> l = [];

    for (int i = 0; i < nrelements; ++i){
      l.add(new ItemText('Name ' + i.toString()));
    }

    listitem = l;
    print('created : ${$['id_list'].selectionEnabled}');
    this.notifyPath('listitem', listitem);
  }

//  @reflectable
//  void tap_event(dom.CustomEvent event, [_]) {
  @Observe('selectedItem')
  void selectedItemChanged(ItemText newValue) {
    IronList e = $['id_list'];
    ItemText objText = convertToDart(e.selectedItem);
    if (objText != null){
      print('Contains : ${listitem.contains(objText)}');
      print('The short text : ${objText.shorttext}');
    }
  }
}

class ItemText extends JsProxy {
  @reflectable
  String shorttext;
  ItemText(this.shorttext);
}
