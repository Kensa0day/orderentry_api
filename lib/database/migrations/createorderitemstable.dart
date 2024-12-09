import 'package:vania/vania.dart';

class CreateOrderItemsTable extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('orderitems', () {
      integer('order_item');
      primary('order_item');
      integer('order_num');
      char('prod_id', length: 10);
      integer('quantity');
      integer('size');

      // Foreign key ke products
      foreign('prod_id', 'products', 'prod_id', 
        constrained: true, onDelete: 'CASCADE');

      // Foreign key ke orders
      foreign('order_num', 'orders', 'order_num', 
        constrained: true, onDelete: 'CASCADE');

      
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitems');
  }
}


