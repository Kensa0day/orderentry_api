import 'package:vania/vania.dart';

class Products extends Model {
  Products() {
    super.table('products');
  }

  String? prodId;
  String? vendId;
  String? prodName;
  int? prodPrice;
  String? prodDesc;

  @override
  Map<String, dynamic> toMap() {
    return {
      'prod_id': prodId,
      'vend_id': vendId,
      'prod_name': prodName,
      'prod_price': prodPrice,
      'prod_desc': prodDesc,
    };
  }

  Products fromMap(Map<String, dynamic> map) {
    return Products()
      ..prodId = map['prod_id']
      ..vendId = map['vend_id']
      ..prodName = map['prod_name']
      ..prodPrice = map['prod_price']
      ..prodDesc = map['prod_desc'];
  }

  /// Mendapatkan data berdasarkan ID
  Future<Products?> find(String id) async {
    final result = await query().where('prod_id', '=', id).first();

    if (result == null) {
      return null;
    }

    // Mapping data dari database ke model
    return Products().fromMap(result);
  }

  /// Simpan atau perbarui data ke database
  Future<void> save() async {
    if (prodId != null) {
      // Jika `prodId` ada, maka data akan diperbarui
      await query().where('prod_id', '=', prodId).update(toMap());
    } else {
      // Jika `prodId` tidak ada, data baru akan ditambahkan
      final insertedId = await query().insert(toMap());
      prodId = insertedId.toString(); // Simpan ID yang baru di-generate
      print("Inserted ID: $insertedId");
    }
  }

  /// Hapus data berdasarkan ID
  Future<void> delete() async {
    if (prodId == null) {
      throw Exception("ID produk tidak ditemukan. Tidak dapat menghapus data.");
    }

    // Menghapus data berdasarkan ID
    await query().where('prod_id', '=', prodId).delete();
  }
}
