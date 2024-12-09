import 'dart:ffi';

import 'package:vania/vania.dart';
import '../../models/orders.dart';

class OrderController extends Controller {
  /// Mendapatkan semua data orders
  Future<Response> getAllOrders(Request request) async {
    try {
      final orders = await Order().query().get();

      return Response.json({
        "message": "Berhasil mendapatkan semua data orders",
        "data": orders,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan data orders",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Mendapatkan data order berdasarkan ID
  Future<Response> getOrderById(Request request, int id) async {
    try {
      final order = await Order().query().where('order_num', '=', id).first();

      if (order == null) {
        return Response.json({
          "message": "Order dengan ID: $id tidak ditemukan",
        }, 404);
      }

      return Response.json({
        "message": "Berhasil mendapatkan data order",
        "data": order,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan order dengan ID: $id",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Membuat data order baru
  Future<Response> createOrder(Request request) async {
    try {
      request.validate({
        'order_num': 'required',
        'order_date': 'required|date',
        'cust_id': 'required',
      });

      await Order().query().insert({
        'order_num': request.input('order_num'),
        'order_date': request.input('order_date'),
        'cust_id': request.input('cust_id'),
      });

      return Response.json({
        "message": "Order berhasil dibuat",
      }, 201);
    } catch (e) {
      return Response.json({
        "message": "Gagal membuat order",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Memperbarui data order
  Future<Response> updateOrder(Request request, int id) async {
    try {
      final input = await request.input();
      final order = await Order().query().where('order_num', '=', id).first();

      if (order == null) {
        return Response.json({
          "message": "Order dengan ID: $id tidak ditemukan",
        }, 404);
      }

      await Order().query().where('order_num', '=', id).update({
        'order_date': input['order_date'] ?? order['order_date'],
        'cust_id': input['cust_id'] ?? order['cust_id'],
      });

      return Response.json({
        "message": "Order berhasil diperbarui",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal memperbarui order",
        "error": e.toString(),
      }, 500);
    }
  }

  /// Menghapus data order
  Future<Response> deleteOrder(Request request, int id) async {
    try {
      final order = await Order().query().where('order_num', '=', id).first();

      if (order == null) {
        return Response.json({
          "message": "Order dengan ID: $id tidak ditemukan",
        }, 404);
      }

      await Order().query().where('order_num', '=', id).delete();

      return Response.json({
        "message": "Order berhasil dihapus",
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal menghapus order",
        "error": e.toString(),
      }, 500);
    }
  }
}
