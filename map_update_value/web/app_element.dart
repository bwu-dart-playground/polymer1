@HtmlImport('app_element.html')
library map_update_value.web.app_element;

import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer/polymer.dart';
// import 'package:polymer_elements/paper_icon_button.dart';

/// []
@PolymerRegister('app-element')
class AppElement extends PolymerElement {
  AppElement.created() : super.created();

  @reflectable
  void tapHandler([_, __]) {
    print('x');
    set('doc.data.oe.oe_lines.#0.ordered_quantity', 100);
    set('data.address.street', 'other street');
  }

  @property
  Map data = {
    'name': 'Günter',
    'address': {
      'street': 'my street'
    }
  };

  @property
  Map doc = {
      "request": {
          "version": "1.0",
          "now": "2011-22-23 12:51:45"
      },
      "data": {
          "resp": {
              "user_id": 10517
          },
          "oe": {
              "cust_po_number": null,
              "customer_id": 11191,
              "ship_to_site_id": 24785,
              "bill_to_site_id": 25019,
              "salesrep_id": 100001258,
              "order_type_id": 1702,
              "order_category_code": "RETURN",
              "price_list_id": 33786,
              "payment_term_id": 1111,
              "tax_code": "VAT17",
              "oe_lines": [
                  {
                      "line_type_id": 1700,
                      "line_category_code": "RETURN",
                      "return_reason_code": "31",
                      "inventory_item_id": 43184,
                      "order_quantity_uom": "EA",
                      "ordered_quantity": 2.0000000000,
                      "location_id": null,
                      "subinventory": "HGZW#54",
                      "locator_id": 314873,
                      "lots": [
  	                    {
  	                        "lot_number": "test_rma_lot_1",
  	                        "lot_quantity": 1.0,
  	                        "expiration_date": null,
  	                        "attribute2": "xxx",
                              "attribute7": "xxx"
  	                    },
  	                    {
                              "lot_number": "test_rma_lot_2",
                              "lot_quantity": 1.0,
                              "expiration_date": null,
                              "attribute2": "xxx",
                              "attribute7": "xxx"
                          }
  	                ]
                  },
                  {
                      "line_type_id": 1700,
                      "line_category_code": "RETURN",
                      "return_reason_code": "31",
                      "inventory_item_id": 43184,
                      "order_quantity_uom": "EA",
                      "ordered_quantity": 2.0000000000,
                      "location_id": null,
                      "subinventory": "HGZW#54",
                      "locator_id": 314873,
                      "lots": [
                          {
                              "lot_number": "test_rma_lot_1",
                              "lot_quantity": 1.0,
                              "expiration_date": null,
                              "attribute2": "xxx",
                              "attribute7": "xxx"
                          },
                          {
                              "lot_number": "test_rma_lot_2",
                              "lot_quantity": 1.0,
                              "expiration_date": null,
                              "attribute2": "xxx",
                              "attribute7": "xxx"
                          }
                      ]
                  }
              ]
          }
      }
  };
}
