@HtmlImport('app_element.html')
library conditional_style.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_media_query.dart';
import 'package:polymer_elements/paper_button.dart';

/// [IronMediaQuery], [PaperButton]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @Property(observer: 'isWideChanged') bool isWide = false;

  @reflectable
  void isWideChanged([_, __]) {
    customStyle['--current-theme'] =
        isWide ? 'var(--wide-theme)' : 'var(--narrow-theme)';
    async(() => Polymer.updateStyles());
  }
}
