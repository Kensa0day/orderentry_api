import 'package:vania/vania.dart';

class Vendor extends Model {
  Vendor() {
    super.table('vendors');
  }

  String? vendId;
  String? vendName;
  String? vendAddress;
  String? vendCity;
  String? vendState;
  String? vendZip;
  String? vendCountry;

  @override
  Map<String, dynamic> toMap() {
    return {
      'vend_id': vendId,
      'vend_name': vendName,
      'vend_address': vendAddress,
      'vend_kota': vendCity,
      'vend_state': vendState,
      'vend_zip': vendZip,
      'vend_country': vendCountry,
    };
  }
}
