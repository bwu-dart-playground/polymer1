@HtmlImport('error_tooltip.html')
library so33950951_style_validation_error.web.error_tooltip;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/iron_icon.dart';
import 'package:polymer_elements/iron_icons.dart';
import 'package:polymer_elements/paper_tooltip.dart';
import 'package:polymer_elements/paper_input_addon_behavior.dart';

/// [PaperInput], [IronIcon], [PaperTooltip], [PaperInputAddonBehavior]
@PolymerRegister('error-tooltip')
class ErrorTooltip extends PolymerElement with PaperInputAddonBehavior{
  ErrorTooltip.created() : super.created();

  // read-only property
  bool _invalid = true;
  @Property(reflectToAttribute: true)
  bool get invalid => _invalid;

  @override
  update(state) {
    _invalid = state['invalid'];
    notifyPath('invalid', _invalid);
  }
}
