import 'dart:io';
import 'package:vania/vania.dart';
import '../../config/database.dart'; // Sesuaikan path file database config
import 'createcustomerstable.dart';
import 'createorderstable.dart';
import 'createorderitemstable.dart';
import 'createvendorstable.dart';
import 'createproductstable.dart';
import 'createproductnotestable.dart';
<<<<<<< HEAD
import 'createUser.dart';
import 'createAccessToken.dart';
=======
>>>>>>> 8ce20af5e0bbb0a7f48809ae3cd4fd7bd11f199b

void main(List<String> args) async {
  print('=============================');
  print('       STARTING MIGRATION    ');
  print('=============================');

  final migrator = Migrate();
  await migrator.run(args);

  print('=============================');
  print('       MIGRATION DONE        ');
  print('=============================');

  exit(0);
}

class Migrate {
  /// Jalankan migrasi berdasarkan argumen
  Future<void> run(List<String> args) async {
    await _setupConnection();

    if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
      print('Dropping existing tables...');
      await dropTables();
      print('Tables dropped successfully.');
    }

    print('Registering migrations...');
    await registry();
    print('Migrations completed successfully.');

    await _closeConnection();
  }

  /// Mendaftarkan migrasi
  Future<void> registry() async {
  try {
<<<<<<< HEAD

    await CreateUserTable().up();
    print('Table "user" migrated.');

    await CreatePersonalAccessTokensTable().up();
    print('Table "access token" migrated.');

=======
>>>>>>> 8ce20af5e0bbb0a7f48809ae3cd4fd7bd11f199b
    await CreateCustomersTable().up();
    print('Table "customers" migrated.');

    await CreateVendorsTable().up();
    print('Table "vendors" migrated.');

    await CreateProductsTable().up();
    print('Table "products" migrated.');

    await CreateOrdersTable().up();
    print('Table "orders" migrated.');

    await CreateOrderItemsTable().up();
    print('Table "order_items" migrated.');

    await CreateProductNotesTable().up();
    print('Table "product_notes" migrated.');
<<<<<<< HEAD

  

=======
>>>>>>> 8ce20af5e0bbb0a7f48809ae3cd4fd7bd11f199b
  } catch (e) {
    print('Error during migration: $e');
  }
}


  /// Menjatuhkan tabel jika diperlukan
  Future<void> dropTables() async {
  try {
    await CreateProductNotesTable().down();
    print('Table "product_notes" dropped.');

    await CreateOrderItemsTable().down();
    print('Table "order_items" dropped.');

    await CreateOrdersTable().down();
    print('Table "orders" dropped.');

    await CreateProductsTable().down();
    print('Table "products" dropped.');

    await CreateVendorsTable().down();
    print('Table "vendors" dropped.');

    await CreateCustomersTable().down();
    print('Table "customers" dropped.');
<<<<<<< HEAD

    await CreateUserTable().down();
    print('Table "user" migrated.');

    await CreatePersonalAccessTokensTable().down();
    print('Table "access token" migrated.');
=======
>>>>>>> 8ce20af5e0bbb0a7f48809ae3cd4fd7bd11f199b
  } catch (e) {
    print('Error during dropping tables: $e');
  }
}


  /// Setup koneksi ke database
  Future<void> _setupConnection() async {
    try {
      print('Setting up database connection...');
      await MigrationConnection().setup(databaseConfig);
      print('Database connection established.');
    } catch (e) {
      print('Error setting up connection: $e');
      rethrow;
    }
  }

  /// Menutup koneksi ke database
  Future<void> _closeConnection() async {
    try {
      print('Closing database connection...');
      await MigrationConnection().closeConnection();
      print('Database connection closed.');
    } catch (e) {
      print('Error closing connection: $e');
    }
  }
}
