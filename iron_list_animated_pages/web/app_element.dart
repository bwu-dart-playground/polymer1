@HtmlImport('app_element.html')
library iron_list_animated_pages.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/neon_animated_pages.dart';
import 'package:polymer_elements/neon_animatable.dart';
import 'package:polymer_elements/neon_animatable_behavior.dart';
import 'package:polymer_elements/paper_button.dart';
import 'package:polymer_elements/iron_list.dart';

/// [NeonAnimatable], [PaperButton], [IronList]
@PolymerRegister('app-element')
class AppElement extends PolymerElement with NeonAnimatableBehavior {
  AppElement.created() : super.created();

  @Property(notify: true) List<Map> data;

  void attached() {
    set('data', [
      {'index': 0, 'name': "Liz Grimes"},
      {'index': 1, 'name': "Frazier Lara"},
      {'index': 2, 'name': "Dora Griffith"}
    ]);
  }

  @reflectable
  void onOK([_, __]) {
    ($['pages'] as NeonAnimatedPages).selected = "1";
  }
}
