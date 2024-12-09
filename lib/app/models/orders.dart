import 'package:vania/vania.dart';

class Order extends Model {
  Order() {
    super.table('orders');
  }

  int? orderNum;
  DateTime? orderDate;
  String? custId;

  @override
  Map<String, dynamic> toMap() {
    return {
      'order_num': orderNum,
      'order_date': orderDate?.toIso8601String(),
      'cust_id': custId,
    };
  }

  Order fromMap(Map<String, dynamic> map) {
    return Order()
      ..orderNum = map['order_num']
      ..orderDate = DateTime.tryParse(map['order_date'] ?? '')
      ..custId = map['cust_id'];
  }

  /// Cari data berdasarkan ID
  Future<Order?> find(int id) async {
    final result = await query().where('order_num', '=', id).first();

    if (result == null) {
      return null;
    }

    return fromMap(result);
  }

  /// Simpan atau perbarui data ke database
  Future<void> save() async {
    if (orderNum != null) {
      // Jika `orderNum` ada, maka data akan diperbarui
      await query().where('order_num', '=', orderNum).update(toMap());
    } else {
      // Jika `orderNum` tidak ada, data baru akan ditambahkan
      final insertedId = await query().insert(toMap());
      orderNum = insertedId; // Simpan ID yang baru di-generate
      print("Inserted Order Num: $insertedId");
    }
  }

  /// Hapus data berdasarkan ID
  Future<void> delete() async {
    if (orderNum == null) {
      throw Exception("Order number tidak ditemukan. Tidak dapat menghapus data.");
    }

    // Menghapus data berdasarkan ID
    await query().where('order_num', '=', orderNum).delete();
  }
}
