@HtmlImport('modal_dialog.html')
library content_element.modal_dialog;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
import 'package:bootjack/bootjack.dart';

@PolymerRegister('modal-dialog')
class ModalDialog extends PolymerElement {

  Modal modal;

  ModalDialog.created() : super.created();

  @override
  attached() {
    super.attached();
    Modal.use();
    Transition.use();
    modal = Modal.wire($['modal']);
  }

  @eventHandler
  void show([_, __]){
    modal.show();
  }
}
