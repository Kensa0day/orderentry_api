import 'package:vania/vania.dart';


// DatabaseConfig databaseConfig = DatabaseConfig(
//   driver: MysqlDriver(),
//   host: env<String>('DB_HOST'),
//   port: env<int>('DB_PORT'),
//   database: env<String>('DB_DATABASE'),
//   username: env<String>('DB_USERNAME'),
//   password: env<String>('DB_PASSWORD'),
//   sslmode: env<bool>('DB_SSLMODE',false),
// );

DatabaseConfig databaseConfig = DatabaseConfig(
  driver: MysqlDriver(),
  host: 'localhost',
  port: 3306,
  database: 'vania_order_entry',
  username: 'vania',
  password: '@Candraihsan123',
  sslmode: false,
);


