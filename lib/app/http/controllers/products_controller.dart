import 'package:vania/vania.dart';
import '../../models/products.dart';

class ProductsController extends Controller {
  /// Mendapatkan semua data produk
  Future<Response> getAllProducts(Request request) async {
    try {
      final products = await Products().query().get();

      return Response.json({
        "message": "Berhasil mendapatkan semua data produk",
        "data": products,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan data produk",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Mendapatkan data produk berdasarkan ID
  Future<Response> getProductById(Request request, String id) async {
    try {
      final product = await Products().query().where('prod_id', '=', id).first();

      if (product == null) {
        return Response.json({
          "message": "Produk dengan ID: $id tidak ditemukan",
        }, 404);
      }

      return Response.json({
        "message": "Berhasil mendapatkan data produk",
        "data": product,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan produk dengan ID: $id",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Membuat produk baru
  Future<Response> createProduct(Request request) async {
    try {
      // Validasi input
      request.validate({
        'prod_id': 'required',
        'vend_id': 'required',
        'prod_name': 'required',
        'prod_price': 'required|integer',
        'prod_desc': 'string',
      }, {
        'prod_id.required': 'Product ID is required',
        'vend_id.required': 'Vendor ID is required',
        'prod_name.required': 'Product name is required',
        'prod_price.required': 'Product price is required',
        'prod_price.integer': 'Product price must be an integer',
      });

      // Simpan data ke database
      await Products().query().insert({
        'prod_id': request.input('prod_id'),
        'vend_id': request.input('vend_id'),
        'prod_name': request.input('prod_name'),
        'prod_price': request.input('prod_price'),
        'prod_desc': request.input('prod_desc') ?? '',
      });

      return Response.json({'message': 'Produk berhasil dibuat'}, 201);
    } catch (e) {
      return Response.json(
        {'message': 'Gagal membuat produk', 'error': e.toString()},
        500,
      );
    }
  }

  /// Memperbarui data produk berdasarkan ID
  Future<Response> updateProduct(Request request, String id) async {
    try {
      final input = await request.input();

      final product = await Products().query().where('prod_id', '=', id).first();

      if (product == null) {
        return Response.json({
          "message": "Produk tidak ditemukan",
        }, 404);
      }

      await Products().query().where('prod_id', '=', id).update({
        'vend_id': input['vend_id'] ?? product['vend_id'],
        'prod_name': input['prod_name'] ?? product['prod_name'],
        'prod_price': input['prod_price'] ?? product['prod_price'],
        'prod_desc': input['prod_desc'] ?? product['prod_desc'],
      });

      return Response.json({
        "message": "Produk berhasil diperbarui",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal memperbarui produk",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Menghapus produk berdasarkan ID
  Future<Response> deleteProduct(Request request, String id) async {
    try {
      final product = await Products().query().where('prod_id', '=', id).first();

      if (product == null) {
        return Response.json({
          "message": "Produk tidak ditemukan",
        }, 404);
      }

      await Products().query().where('prod_id', '=', id).delete();

      return Response.json({
        "message": "Produk berhasil dihapus",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal menghapus produk",
        "error": e.toString(),
      }, 500);
    }
  }
}
