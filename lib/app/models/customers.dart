import 'package:vania/vania.dart';

class Customer extends Model {
  Customer() {
    super.table('customers');
  }

  String? custId;
  String? custName;
  String? custAddress;
  String? custCity;
  String? custState;
  String? custZip;
  String? custCountry;
  String? custTelp;

  @override
  Map<String, dynamic> toMap() {
    return {
      'cust_id': custId,
      'cust_name': custName,
      'cust_address': custAddress,
      'cust_city': custCity,
      'cust_state': custState,
      'cust_zip': custZip,
      'cust_country': custCountry,
      'cust_telp': custTelp,
    };
  }

  Customer fromMap(Map<String, dynamic> map) {
    return Customer()
      ..custId = map['cust_id']
      ..custName = map['cust_name']
      ..custAddress = map['cust_address']
      ..custCity = map['cust_city']
      ..custState = map['cust_state']
      ..custZip = map['cust_zip']
      ..custCountry = map['cust_country']
      ..custTelp = map['cust_telp'];
  }

  // Tambahkan metode find untuk mendapatkan data berdasarkan ID
  Future<Customer?> find(String id) async {
    final result = await query().where('cust_id', '=', id).first();

    if (result == null) {
      return null;
    }

    // Mapping data dari database ke model
    return Customer()
      ..custId = result['cust_id']
      ..custName = result['cust_name']
      ..custAddress = result['cust_address']
      ..custCity = result['cust_city']
      ..custState = result['cust_state']
      ..custZip = result['cust_zip']
      ..custCountry = result['cust_country']
      ..custTelp = result['cust_telp'];
  }

  /// Simpan atau perbarui data ke database
  Future<void> save() async {
    if (custId != null) {
      // Jika `custId` ada, maka data akan diperbarui
      await query().where('cust_id', '=', custId).update(toMap());
    } else {
      // Jika `custId` tidak ada, data baru akan ditambahkan
      final insertedId = await query().insert(toMap());
      custId = insertedId.toString(); // Simpan ID yang baru di-generate
      print("Inserted ID: $insertedId");
    }
  }

  /// Hapus data berdasarkan ID
  Future<void> delete() async {
    if (custId == null) {
      throw Exception("ID customer tidak ditemukan. Tidak dapat menghapus data.");
    }

    // Menghapus data berdasarkan ID
    await query().where('cust_id', '=', custId).delete();
  }
}


