import 'package:vania/vania.dart';
import '../../models/vendors.dart';

class VendorsController extends Controller {
  /// Mendapatkan semua data vendors
  Future<Response> getAllVendors(Request request) async {
    try {
      final vendors = await Vendor().query().get();

      return Response.json({
        "message": "Berhasil mendapatkan semua data vendors",
        "data": vendors,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan data vendors",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Mendapatkan data vendor berdasarkan ID
  Future<Response> getVendorById(Request request, String id) async {
    try {
      final vendor = await Vendor().query().where('vend_id', '=', id).first();

      if (vendor == null) {
        return Response.json({
          "message": "Vendor dengan ID: $id tidak ditemukan",
        }, 404);
      }

      return Response.json({
        "message": "Berhasil mendapatkan data vendor",
        "data": vendor,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan vendor dengan ID: $id",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Membuat vendor baru
  Future<Response> createVendor(Request request) async {
    try {
      // Validasi input
      request.validate({
        'vend_id': 'required',
        'vend_name': 'required',
        'vend_address': 'required',
        'vend_kota': 'required',
        'vend_state': 'required',
        'vend_zip': 'required',
        'vend_country': 'required',
      }, {
        'vend_id.required': 'Vendor ID is required',
        'vend_name.required': 'Vendor name is required',
        'vend_address.required': 'Vendor address is required',
        'vend_kota.required': 'Vendor city is required',
        'vend_state.required': 'Vendor state is required',
        'vend_zip.required': 'Vendor zip code is required',
        'vend_country.required': 'Vendor country is required',
      });

      // Simpan data ke database
      await Vendor().query().insert({
        'vend_id': request.input('vend_id'),
        'vend_name': request.input('vend_name'),
        'vend_address': request.input('vend_address'),
        'vend_kota': request.input('vend_kota'),
        'vend_state': request.input('vend_state'),
        'vend_zip': request.input('vend_zip'),
        'vend_country': request.input('vend_country'),
      });

      return Response.json({'message': 'Vendor created successfully'}, 201);
    } catch (e) {
      return Response.json(
        {'message': 'Failed to create vendor', 'error': e.toString()},
        500,
      );
    }
  }

  /// Memperbarui data vendor berdasarkan ID
  Future<Response> updateVendor(Request request, String id) async {
    try {
      final input = await request.input();

      final vendor = await Vendor().query().where('vend_id', '=', id).first();

      if (vendor == null) {
        return Response.json({
          "message": "Vendor tidak ditemukan",
        }, 404);
      }

      await Vendor().query().where('vend_id', '=', id).update({
        'vend_name': input['vend_name'] ?? vendor['vend_name'],
        'vend_address': input['vend_address'] ?? vendor['vend_address'],
        'vend_kota': input['vend_kota'] ?? vendor['vend_kota'],
        'vend_state': input['vend_state'] ?? vendor['vend_state'],
        'vend_zip': input['vend_zip'] ?? vendor['vend_zip'],
        'vend_country': input['vend_country'] ?? vendor['vend_country'],
      });

      return Response.json({
        "message": "Vendor berhasil diperbarui",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal memperbarui vendor",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Menghapus data vendor berdasarkan ID
  Future<Response> deleteVendor(Request request, String id) async {
    try {
      final vendor = await Vendor().query().where('vend_id', '=', id).first();

      if (vendor == null) {
        return Response.json({
          "message": "Vendor tidak ditemukan",
        }, 404);
      }

      await Vendor().query().where('vend_id', '=', id).delete();

      return Response.json({
        "message": "Vendor berhasil dihapus",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal menghapus vendor",
        "error": e.toString(),
      }, 500);
    }
  }
}
