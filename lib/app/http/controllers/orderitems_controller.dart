import 'package:vania/vania.dart';
import '../../models/orderitems.dart';

class OrderItemsController extends Controller {
  /// Mendapatkan semua data order items
  Future<Response> getAllOrderItems(Request request) async {
    try {
      final orderItems = await OrderItem().query().get();

      return Response.json({
        "message": "Berhasil mendapatkan semua data order items",
        "data": orderItems,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan data order items",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Mendapatkan data order item berdasarkan ID
  Future<Response> getOrderItemById(Request request, int id) async {
    try {
      final orderItem = await OrderItem().query().where('order_item', '=', id).first();

      if (orderItem == null) {
        return Response.json({
          "message": "Order item dengan ID: $id tidak ditemukan",
        }, 404);
      }

      return Response.json({
        "message": "Berhasil mendapatkan data order item",
        "data": orderItem,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan order item dengan ID: $id",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Membuat order item baru
  Future<Response> createOrderItem(Request request) async {
    try {
      // Validasi input
      request.validate({
        'order_item': 'required',
        'order_num': 'required',
        'prod_id': 'required',
        'quantity': 'required|integer',
        'size': 'integer',
      }, {
        'order_item.required': 'Order item ID is required',
        'order_num.required': 'Order number is required',
        'prod_id.required': 'Product ID is required',
        'quantity.required': 'Quantity is required',
        'quantity.integer': 'Quantity must be an integer',
      });

      // Simpan data ke database
      await OrderItem().query().insert({
        'order_item': request.input('order_item'),
        'order_num': request.input('order_num'),
        'prod_id': request.input('prod_id'),
        'quantity': request.input('quantity'),
        'size': request.input('size') ?? 0,
      });

      return Response.json({'message': 'Order item created successfully'}, 201);
    } catch (e) {
      return Response.json(
        {'message': 'Failed to create order item', 'error': e.toString()},
        500,
      );
    }
  }

  Future<Response> updateOrderItem(Request request, int id) async {
  try {
    final input = await request.input();

    // Query data langsung sebagai map
    final orderItem = await OrderItem().query().where('order_item', '=', id).first();

    if (orderItem == null) {
      return Response.json({
        "message": "Order item tidak ditemukan",
      }, 404);
    }

    // Update data langsung menggunakan map
    await OrderItem().query().where('order_item', '=', id).update({
      'order_num': input['order_num'] ?? orderItem['order_num'],
      'prod_id': input['prod_id'] ?? orderItem['prod_id'],
      'quantity': input['quantity'] ?? orderItem['quantity'],
      'size': input['size'] ?? orderItem['size'],
    });

    return Response.json({
      "message": "Order item berhasil diperbarui",
    }, 200);
  } catch (e) {
    return Response.json({
      "message": "Gagal memperbarui order item",
      "error": e.toString(),
    }, 500);
  }
}


  /// Menghapus data order item berdasarkan ID
  Future<Response> deleteOrderItem(Request request, int id) async {
    try {
      final orderItem = await OrderItem().query().where('order_item', '=', id).first();

      if (orderItem == null) {
        return Response.json({
          "message": "Order item tidak ditemukan",
        }, 404);
      }

      await OrderItem().query().where('order_item', '=', id).delete();

      return Response.json({
        "message": "Order item berhasil dihapus",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal menghapus order item",
        "error": e.toString(),
      }, 500);
    }
  }
}
