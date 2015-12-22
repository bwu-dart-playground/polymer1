@HtmlImport('app_element.html')
library input_number.web.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';

@PolymerRegister('app-element')
class AppElement extends PolymerElement with InputConverterBehavior {
  AppElement.created() : super.created();

  @property int intValue;

  int _intValue2;
  @property int get intValue2 => _intValue2;
  @reflectable set intValue2(value) => convertToInt(value, 'intValue2');

  @property Model model = new Model();
}

@behavior
abstract class InputConverterBehavior implements PolymerBase {
  @reflectable
  void convertToInt(dom.Event e, _) {
    final input = (e.target as dom.NumberInputElement);
    num value = input.valueAsNumber;
    int intValue =
        value == value.isInfinite || value.isNaN ? null : value.toInt();
    notifyPath(input.attributes['notify-path'], intValue);
  }

  void convertToInt2(value, String propertyPath) {
    int result;
    if (value == null) {
      result = null;
    } else if (value is String) {
      double doubleValue = double.parse(value, (_) => double.NAN);
      result =
          doubleValue == doubleValue.isNaN ? null : doubleValue.toInt();
    } else if (value is int) {
      result = value;
    } else if (value is double) {
      result =
          value == value.isInfinite || value.isNaN ? null : value.toInt();
    }
    set('intValue2', result);
  }
}

class Model extends JsProxy {
  @reflectable
  int quantity;
}
