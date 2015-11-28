library paper_drawer_panel.app_element;

import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_drawer_panel.dart' show PaperDrawerPanel;

import 'package:polymer_elements/paper_drawer_panel.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/paper_icon_button.dart';

/// [AppElement] [PaperDrawerPanel] [PaperHeaderPanel] [PaperToolbar] [IronIcon]
/// [PaperIconButton]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @reflectable
  void toggleDrawer() {
    ($['drawerPanel'] as PaperDrawerPanel).togglePanel();
  }
}
