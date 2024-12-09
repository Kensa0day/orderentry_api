import 'package:vania/vania.dart';
import 'package:order_entry/app/http/controllers/customers_controller.dart';
import 'package:order_entry/app/http/controllers/orders_controller.dart';
import 'package:order_entry/app/http/controllers/orderitems_controller.dart';
import 'package:order_entry/app/http/controllers/products_controller.dart';
import 'package:order_entry/app/http/controllers/productnotes_controller.dart';
import 'package:order_entry/app/http/controllers/vendors_controller.dart';

class ApiRoute implements Route {
  @override
  void register() {

    // Router.basePrefix('api');
    /// CRUD Routes for Customer
    final customerController = CustomerController();

    // Read all customers
    Router.get("/customers", customerController.getAllCustomers);

    // Read customer by ID
    Router.get("/customers/{id}", customerController.getCustomerById);

    // Create customer
    Router.post("/customers", customerController.createCustomer);

    // Update customer by ID
    Router.put("/customers/{id}", customerController.updateCustomer);

    // Delete customer by ID
    Router.delete("/customers/{id}", customerController.deleteCustomer);

    final orderController = OrderController();

    // Get all orders
    Router.get("/orders", orderController.getAllOrders);

    // Get order by ID
    Router.get("/orders/{id}", orderController.getOrderById);

    // Create new order
    Router.post("/orders", orderController.createOrder);

    // Update order by ID
    Router.put("/orders/{id}", orderController.updateOrder);

    // Delete order by ID
    Router.delete("/orders/{id}", orderController.deleteOrder);

    final orderItemController = OrderItemsController();

    // Get all order items
    Router.get("/order-items", orderItemController.getAllOrderItems);

    // Get order item by ID
    Router.get("/order-items/{id}", orderItemController.getOrderItemById);

    // Create new order item
    Router.post("/order-items", orderItemController.createOrderItem);

    // Update order item by ID
    Router.put("/order-items/{id}", orderItemController.updateOrderItem);

    // Delete order item by ID
    Router.delete("/order-items/{id}", orderItemController.deleteOrderItem);

    final productsController = ProductsController();

    // Get all products
    Router.get("/products", productsController.getAllProducts);

    // Get product by ID
    Router.get("/products/{id}", productsController.getProductById);

    // Create new product
    Router.post("/products", productsController.createProduct);

    // Update product by ID
    Router.put("/products/{id}", productsController.updateProduct);

    // Delete product by ID
    Router.delete("/products/{id}", productsController.deleteProduct);

    final productNoteController = ProductNotesController();

    // Get all product notes
    Router.get("/product-notes", productNoteController.getAllProductNotes);

    // Get product note by ID
    Router.get("/product-notes/{id}", productNoteController.getProductNoteById);

    // Create new product note
    Router.post("/product-notes", productNoteController.createProductNote);

    // Update product note by ID
    Router.put("/product-notes/{id}", productNoteController.updateProductNote);

    // Delete product note by ID
    Router.delete("/product-notes/{id}", productNoteController.deleteProductNote);

    final vendorController = VendorsController();

    // Get all vendors
    Router.get("/vendors", vendorController.getAllVendors);

    // Get vendor by ID
    Router.get("/vendors/{id}", vendorController.getVendorById);

    // Create new vendor
    Router.post("/vendors", vendorController.createVendor);

    // Update vendor by ID
    Router.put("/vendors/{id}", vendorController.updateVendor);

    // Delete vendor by ID
    Router.delete("/vendors/{id}", vendorController.deleteVendor);





  }
}

    // /// Base RoutePrefix
    // Router.basePrefix('api');

    // // Existing routes
    // Router.get("/home", homeController.index);

    // Router.get("/hello-world", () {
    //   return Response.html('Hello World');
    // }).middleware([HomeMiddleware()]);

    // Router.get('wrong-request',
    //         () => Response.json({'message': 'Hi wrong request'}))
    //     .middleware([ErrorResponseMiddleware()]);

    // Router.get("/user", () {
    //   return Response.json(Auth().user());
    // }).middleware([AuthenticateMiddleware()]);
