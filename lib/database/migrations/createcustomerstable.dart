import 'package:vania/vania.dart';

class CreateCustomersTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTable('customers', () {
      char('cust_id', length: 5);
      primary('cust_id');
      char('cust_name', length: 50);
      char('cust_address', length: 50);
      char('cust_city', length: 20);
      char('cust_state', length: 5);
      char('cust_zip', length: 7);
      char('cust_country', length: 25);
      char('cust_telp', length: 15);
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('customers');
  }
}

