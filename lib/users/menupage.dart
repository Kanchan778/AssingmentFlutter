import 'package:assignment/users/orderdetailspage.dart'; //imported orderdetailspage to call navigate it
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int itemCount = 0;
  List<Map<String, dynamic>> orderItems = [];
// function to count quantity
  void addItemToOrder(String itemName, double itemPrice) {
    setState(() {
      itemCount++;
      orderItems.add({
        'name': itemName,
        'price': itemPrice,
        'quantity': 1, // Default quantity set to 1
      });
    });
  }
// function to vieworder 
  void viewOrder() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderListPage(orderItems: orderItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt),
            onPressed: () {
              // logic for reciept press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.language, color: Colors.white),
                    SizedBox(width: 8),
                    Text('EN', style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // function to call waiter functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Call Waiter',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          // Categories section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton(context, 'Appetizers'),
                  _buildCategoryButton(context, 'Entree'),
                  _buildCategoryButton(context, 'Sides'),
                  _buildCategoryButton(context, 'Desserts'),
                ],
              ),
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Scrollable list of food items
          Expanded(
            child: ListView(
              children: [
                _buildFoodItem(
                  context,
                  'Fried Hot Chicken',
                  'Savory stir-fried noodles tossed with tender chicken, crisp vegetables.',
                  'assets/chicken.jpg',
                  18.22,
                ),
                _buildFoodItem(
                  context,
                  'Oatmeal Breakfast',
                  'Savory stir-fried noodles tossed with tender chicken, crisp vegetables.',
                  'assets/oatmeal.jpg',
                  16.22,
                ),
                // if needed add more items.
              ],
            ),
          ),
          // Footer with view order button
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.green[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$itemCount Item${itemCount > 1 ? 's' : ''} Selected'),
                ElevatedButton(
                  onPressed: itemCount > 0 ? viewOrder : null,
                  child: const Text('View Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // function to category filtering
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
        ),
        child: Text(category),
      ),
    );
  }

  Widget _buildFoodItem(
      BuildContext context, String title, String description, String imageUrl, double price) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            Image.asset(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(description),
                  const SizedBox(height: 4),
                  Text('\$$price', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: () {
                addItemToOrder(title, price);
              },
            ),
          ],
        ),
      ),
    );
  }
}
