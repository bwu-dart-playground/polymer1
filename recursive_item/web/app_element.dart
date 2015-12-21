@HtmlImport('app_element.html')
library recursive_item.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'recursive_item.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property
  RecursiveItem item;
  /// Constructor used to create instance of MainApp.

  void ready(){
    set('item', _buildModel());
  }

RecursiveModel _buildModel(){
  RecursiveModel model = new RecursiveModel();
  model.children.add( new RecursiveModel());
  model.other = new Other("root");
  model.children[0].other = new Other("child");
  return model;
}
}
