@HtmlImport('app_element.html')
library iron_dropdown.app_element;

import 'dart:html' as dom;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_dropdown.dart';
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/iron_flex_layout.dart';

/// [IronDropdown] [PaperItem]
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @property var yearsList = <int>[ 1, 2, 3, 4];
  //@observable int year = 0;

//  @Property(notify: true, observer: 'inputHandler')
  @property var age = new Age();

  @eventHandler
  void openDropdown([_, __]) {
    ($['years-dropdown'] as IronDropdown).open();;
//    (dd as IronDropdown).positionTarget = $['dropdown-button'];
  }

  @eventHandler
  dom.Element getElement(String id) {
    print('getElement $id');
    return $[id];
  }

  @eventHandler
  void inputHandler([_,__]) {
    print('inputHandler ${$['birthday'].value}, age.birthday: ${age.birthday}');
    if (age.birthday != '') {
      DateTime now = new DateTime.now();
      DateTime birthday = DateTime.parse(age.birthday.replaceAll(r'-', ''));

      //Duration dayz = ( birthday.difference( new DateTime.now() ) ).inDays;
      Duration duration = now.difference(birthday);

      // calculate years since birth
      int days = duration.inDays;
      set('age.years', days ~/ 365);
//      age.years = days ~/ 365;

//      // attempting to set the PaperItem label to the calculated age
//      var yearsPprItm = $[ 'years-ppr-itm' ] as PaperItem;
//
//      // neither of the following resets the PaperItem label to the age variable
//      yearsPprItm.setAttribute('label', age.years.toString());
//      //year = age.years.toString();
    }
  }
}

class Age extends JsProxy {
  int years = 0;
  String birthday = '2015-01-01';
}
