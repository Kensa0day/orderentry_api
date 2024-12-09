import 'package:vania/vania.dart';
import '../../models/productnotes.dart';

class ProductNotesController extends Controller {
  /// Mendapatkan semua data product notes
  Future<Response> getAllProductNotes(Request request) async {
    try {
      final productNotes = await ProductNote().query().get();

      return Response.json({
        "message": "Berhasil mendapatkan semua data product notes",
        "data": productNotes,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan data product notes",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Mendapatkan data product note berdasarkan ID
  Future<Response> getProductNoteById(Request request, String id) async {
    try {
      final productNote = await ProductNote().query().where('note_id', '=', id).first();

      if (productNote == null) {
        return Response.json({
          "message": "Product note dengan ID: $id tidak ditemukan",
        }, 404);
      }

      return Response.json({
        "message": "Berhasil mendapatkan data product note",
        "data": productNote,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan product note dengan ID: $id",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Membuat product note baru
  Future<Response> createProductNote(Request request) async {
    try {
      // Validasi input
      request.validate({
        'note_id': 'required',
        'prod_id': 'required',
        'note_date': 'required|date',
        'note_text': 'required',
      }, {
        'note_id.required': 'Note ID is required',
        'prod_id.required': 'Product ID is required',
        'note_date.required': 'Note date is required',
        'note_date.date': 'Note date must be a valid date',
        'note_text.required': 'Note text is required',
      });

      // Simpan data ke database
      await ProductNote().query().insert({
        'note_id': request.input('note_id'),
        'prod_id': request.input('prod_id'),
        'note_date': request.input('note_date'),
        'note_text': request.input('note_text'),
      });

      return Response.json({'message': 'Product note created successfully'}, 201);
    } catch (e) {
      return Response.json(
        {'message': 'Failed to create product note', 'error': e.toString()},
        500,
      );
    }
  }

  /// Memperbarui product note berdasarkan ID
  Future<Response> updateProductNote(Request request, String id) async {
    try {
      final input = await request.input();

      // Query data langsung sebagai map
      final productNote = await ProductNote().query().where('note_id', '=', id).first();

      if (productNote == null) {
        return Response.json({
          "message": "Product note tidak ditemukan",
        }, 404);
      }

      // Update data langsung menggunakan map
      await ProductNote().query().where('note_id', '=', id).update({
        'prod_id': input['prod_id'] ?? productNote['prod_id'],
        'note_date': input['note_date'] ?? productNote['note_date'],
        'note_text': input['note_text'] ?? productNote['note_text'],
      });

      return Response.json({
        "message": "Product note berhasil diperbarui",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal memperbarui product note",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Menghapus data product note berdasarkan ID
  Future<Response> deleteProductNote(Request request, String id) async {
    try {
      final productNote = await ProductNote().query().where('note_id', '=', id).first();

      if (productNote == null) {
        return Response.json({
          "message": "Product note tidak ditemukan",
        }, 404);
      }

      await ProductNote().query().where('note_id', '=', id).delete();

      return Response.json({
        "message": "Product note berhasil dihapus",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal menghapus product note",
        "error": e.toString(),
      }, 500);
    }
  }
}
