@HtmlImport('foo_element.html')
library iron_list.foo_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart' hide Foo;
import 'foo.dart';

@PolymerRegister('foo-element')
class FooElement extends PolymerElement {

  FooElement.created() : super.created();

  @property
  Foo foo;
}
