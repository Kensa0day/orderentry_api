import 'package:vania/vania.dart';

class ProductNote extends Model {
  ProductNote() {
    super.table('productnotes');
  }

  String? noteId;
  String? prodId;
  DateTime? noteDate;
  String? noteText;

  @override
  Map<String, dynamic> toMap() {
    return {
      'note_id': noteId,
      'prod_id': prodId,
      'note_date': noteDate?.toIso8601String(),
      'note_text': noteText,
    };
  }

  ProductNote fromMap(Map<String, dynamic> map) {
    return ProductNote()
      ..noteId = map['note_id']
      ..prodId = map['prod_id']
      ..noteDate = map['note_date'] != null ? DateTime.parse(map['note_date']) : null
      ..noteText = map['note_text'];
  }

  /// Mendapatkan data berdasarkan ID
  Future<ProductNote?> find(String id) async {
    final result = await query().where('note_id', '=', id).first();

    if (result == null) {
      return null;
    }

    // Mapping data dari database ke model
    return ProductNote().fromMap(result);
  }

  /// Simpan atau perbarui data ke database
  Future<void> save() async {
    if (noteId != null) {
      // Jika noteId ada, maka data akan diperbarui
      await query().where('note_id', '=', noteId).update(toMap());
    } else {
      // Jika noteId tidak ada, data baru akan ditambahkan
      final insertedId = await query().insert(toMap());
      noteId = insertedId.toString(); // Simpan ID yang baru di-generate
      print("Inserted ID: $insertedId");
    }
  }

  /// Hapus data berdasarkan ID
  Future<void> delete() async {
    if (noteId == null) {
      throw Exception("ID product note tidak ditemukan. Tidak dapat menghapus data.");
    }

    // Menghapus data berdasarkan ID
    await query().where('note_id', '=', noteId).delete();
  }
}
