import 'package:vania/vania.dart';
import '../../models/customers.dart';

class CustomerController extends Controller {
  /// Mendapatkan semua data customer
  Future<Response> getAllCustomers(Request request) async {
    try {
      final customers = await Customer().query().get();

      return Response.json({
        "message": "Berhasil mendapatkan semua data customers",
        "data": customers,
      }, 200);
    } catch (e) {
      return Response.json({
        "message": "Gagal mendapatkan data customers",
        "error": e.toString(),
      }, 500);
    }
  }



  /// Membuat data customer baru
Future<Response> createCustomer(Request request) async {
  try {
    // Validasi input
    request.validate({
      'cust_id': 'required',
      'cust_name': 'required',
      'cust_address': 'required',
      'cust_city': 'required',
    }, {
      'cust_id.required': 'Customer ID is required',
      'cust_name.required': 'Customer name is required',
      'cust_address.required': 'Customer address is required',
      'cust_city.required': 'Customer city is required',
    });

    // Simpan data ke database
    await Customer().query().insert({
      'cust_id': request.input('cust_id'),
      'cust_name': request.input('cust_name'),
      'cust_address': request.input('cust_address'),
      'cust_city': request.input('cust_city'),
      'cust_state': request.input('cust_state') ?? '',
      'cust_zip': request.input('cust_zip') ?? '',
      'cust_country': request.input('cust_country') ?? '',
      'cust_telp': request.input('cust_telp') ?? '',
    });

    // Return response sukses
    return Response.json({'message': 'Customer created successfully'}, 201);
  } catch (e) {
    // Tangani error
    return Response.json(
      {'message': 'Failed to create customer', 'error': e.toString()},
      500,
    );
  }
}

/// Get a customer by ID
Future<Response> getCustomerById(Request request, String id) async {
  try {
    // Cari customer berdasarkan ID
    final customers = await Customer().query().where('cust_id', '=', id).first();

    // Jika data tidak ditemukan
    if (customers == null) {
      return Response.json(
        {'message': 'Customer not found'},
        404,
      );
    }

    // Return data customer jika ditemukan
    return Response.json({
      'message': 'Customer found',
      'data': customers,
    }, 200);
  } catch (e) {
    // Tangani error
    return Response.json(
      {'message': 'Failed to retrieve customer', 'error': e.toString()},
      500,
    );
  }
}

Future<Response> updateCustomer(Request request, String id) async {
  try {
    final input = await request.input();

    // Ambil data customer dari database
    final customerMap = await Customer().query().where('cust_id', '=', id).first();

    if (customerMap == null) {
      return Response.json({
        "message": "Customer tidak ditemukan",
      }, 404);
    }

    // Buat instance model dari hasil query
    final customer = Customer().fromMap(customerMap);

    // Perbarui data hanya jika ada input baru
    customer.custName = input['cust_name'] ?? customer.custName;
    customer.custAddress = input['cust_address'] ?? customer.custAddress;
    customer.custCity = input['cust_city'] ?? customer.custCity;
    customer.custState = input['cust_state'] ?? customer.custState;
    customer.custZip = input['cust_zip'] ?? customer.custZip;
    customer.custCountry = input['cust_country'] ?? customer.custCountry;
    customer.custTelp = input['cust_telp'] ?? customer.custTelp;

    // Simpan perubahan ke database
    await customer.save();

    return Response.json({
      "message": "Customer berhasil diperbarui",
      "data": customer.toMap(),
    }, 200);
  } catch (e) {
    return Response.json({
      "message": "Gagal memperbarui customer",
      "error": e.toString(),
    }, 500);
  }
}


Future<Response> deleteCustomer(Request request, String id) async {
  try {
    // Cari data customer berdasarkan cust_id
    final customer = await Customer().query().where('cust_id', '=', id).first();

    if (customer == null) {
      return Response.json({
        "message": "Customer tidak ditemukan",
      }, 404);
    }

    // Hapus customer dari database
    await Customer().query().where('cust_id', '=', id).delete();

    return Response.json({
      "message": "Customer berhasil dihapus",
    }, 200);
  } catch (e) {
    return Response.json({
      "message": "Gagal menghapus customer",
      "error": e.toString(),
    }, 500);
  }
}



}
