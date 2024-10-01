import 'package:assignment/users/orderrecieptpage.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;

  const OrderListPage({Key? key, required this.orderItems}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  // function for calculate total price
  void _calculateTotalPrice() {
    setState(() {
      totalPrice = widget.orderItems.fold(0, (sum, item) {
        return sum + (item['price'] * item['quantity']);
      });
    });
  }

//function to update item quantity
  void _updateItemQuantity(int index, int newQuantity) {
    setState(() {
      widget.orderItems[index]['quantity'] = newQuantity;
      _calculateTotalPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '${widget.orderItems.length} Items',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.orderItems.length,
              itemBuilder: (context, index) {
                final item = widget.orderItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            // image
                            child: const Icon(Icons.image, size: 40),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (item['quantity'] > 1) {
                                          _updateItemQuantity(
                                              index, item['quantity'] - 1);
                                        }
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    // call item quantity function
                                    Text('${item['quantity']}'),
                                    IconButton(
                                      onPressed: () {
                                        _updateItemQuantity(
                                            index, item['quantity'] + 1);
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                //calling price and item quantity and calculating
                                '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // logic for adding notes
                                    },
                                    icon: const Icon(Icons.note_add),
                                  ),
                                  const Text('Add a Note'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //function to call the total price
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'All the prices are inclusive of VAT.',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  //calling orderplaceddialog
                  onPressed: () {
                    _showOrderPlacedDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Order Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// function to show orderplaced message
  void _showOrderPlacedDialog(BuildContext context) {
    String estimatedTime = "Estimated Time: 20 - 30 mins";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Placed!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Your order has been placed successfully.'),
              const SizedBox(height: 8),
              Text(estimatedTime),
            ],
          ),
          actions: [
            TextButton(
              //function to route orderreceiptpage
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderReceiptPage(
                      orderItems: widget.orderItems,
                      totalPrice: totalPrice,
                    ),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
