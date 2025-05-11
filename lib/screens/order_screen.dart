import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Active'), Tab(text: 'History')],
          ),
        ),
        body: TabBarView(
          children: [_buildOrderList(true), _buildOrderList(false)],
        ),
      ),
    );
  }

  Widget _buildOrderList(bool isActive) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #${1000 + index}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Chip(
                      label: Text(
                        isActive ? 'In Progress' : 'Completed',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: isActive ? Colors.blue : Colors.green,
                    ),
                  ],
                ),
                const Divider(),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  title: Text('Service Provider Name'),
                  subtitle: Text('Service Type'),
                ),
                if (isActive)
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Track Progress'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
