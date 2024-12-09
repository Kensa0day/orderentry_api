import 'package:vania/vania.dart';

class OrderItem extends Model {
  OrderItem() {
    super.table('orderitems');
  }

  String? orderItem;
  String? orderNum;
  String? prodId;
  int? quantity;
  int? size;

  @override
  Map<String, dynamic> toMap() {
    return {
      'order_item': orderItem,
      'order_num': orderNum,
      'prod_id': prodId,
      'quantity': quantity,
      'size': size,
    };
  }

  OrderItem fromMap(Map<String, dynamic> map) {
    return OrderItem()
      ..orderItem = map['order_item']
      ..orderNum = map['order_num']
      ..prodId = map['prod_id']
      ..quantity = map['quantity']
      ..size = map['size'];
  }

  /// Mendapatkan data berdasarkan ID
  Future<OrderItem?> find(String id) async {
    final result = await query().where('order_item', '=', id).first();

    if (result == null) {
      return null;
    }

    // Mapping data dari database ke model
    return OrderItem().fromMap(result);
  }

  /// Simpan atau perbarui data ke database
  Future<void> save() async {
    if (orderItem != null) {
      // Jika `orderItem` ada, maka data akan diperbarui
      await query().where('order_item', '=', orderItem).update(toMap());
    } else {
      // Jika `orderItem` tidak ada, data baru akan ditambahkan
      final insertedId = await query().insert(toMap());
      orderItem = insertedId.toString(); // Simpan ID yang baru di-generate
      print("Inserted ID: $insertedId");
    }
  }

  /// Hapus data berdasarkan ID
  Future<void> delete() async {
    if (orderItem == null) {
      throw Exception("ID order item tidak ditemukan. Tidak dapat menghapus data.");
    }

    // Menghapus data berdasarkan ID
    await query().where('order_item', '=', orderItem).delete();
  }
}
