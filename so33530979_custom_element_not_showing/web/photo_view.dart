@HtmlImport('photo_view.html')
library photon.photo_view;

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

@PolymerRegister('photo-view')
class PhotoView extends PolymerElement {
  PhotoView.created() : super.created();

  @Property(notify: true)
  String url;
}
