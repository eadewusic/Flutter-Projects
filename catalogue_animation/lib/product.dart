class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({required this.name, required this.imageUrl, required this.price});
}

List<Product> products = [
  Product(
      name: 'Phone',
      imageUrl: 'https://via.placeholder.com/150',
      price: 699.99),
  Product(
      name: 'Laptop',
      imageUrl: 'https://via.placeholder.com/150',
      price: 1299.99),
  Product(
      name: 'Headphones',
      imageUrl: 'https://via.placeholder.com/150',
      price: 199.99),
  Product(
      name: 'Watch',
      imageUrl: 'https://via.placeholder.com/150',
      price: 299.99),
];
