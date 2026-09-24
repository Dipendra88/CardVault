import 'package:flutter/material.dart';

void main() {
  runApp(const CardVaultApp());
}

class CardVaultApp extends StatelessWidget {
  const CardVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CardVault',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B5D4D)),
        scaffoldBackgroundColor: const Color(0xFFF5F7F6),
        fontFamily: 'Arial',
      ),
      home: const CardVaultHome(),
    );
  }
}

class CardVaultHome extends StatefulWidget {
  const CardVaultHome({super.key});

  @override
  State<CardVaultHome> createState() => _CardVaultHomeState();
}

class _CardVaultHomeState extends State<CardVaultHome> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5D4D),
        foregroundColor: Colors.white,
        title: const Text(
          'CardVault',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color(0xFF0B5D4D)),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back, Deep 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              'Manage your cards securely',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 24),

            const Text(
              'My Cards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 14),

            // Credit Card
            _buildCard(
              cardType: 'CREDIT CARD',
              cardNumber: '••••  ••••  ••••  4582',
              holder: 'DEEP RAJPUT',
              expiry: '09/29',
              available: '₹82,450',
            ),

            const SizedBox(height: 16),

            // Debit Card
            _buildCard(
              cardType: 'DEBIT CARD',
              cardNumber: '••••  ••••  ••••  7291',
              holder: 'DEEP RAJPUT',
              expiry: '11/28',
              available: '₹45,230',
            ),

            const SizedBox(height: 28),

            const Text(
              'Available Credit',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 5),

            const Text(
              '₹82,450',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 28),

            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _transaction(
              icon: Icons.shopping_bag_outlined,
              title: 'Amazon',
              date: 'Today',
              amount: '- ₹1,299',
            ),

            _transaction(
              icon: Icons.fastfood_outlined,
              title: 'Swiggy',
              date: 'Yesterday',
              amount: '- ₹450',
            ),

            _transaction(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Salary',
              date: '20 Sep',
              amount: '+ ₹82,000',
              positive: true,
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(Icons.credit_card),
            label: 'Cards',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String cardType,
    required String cardNumber,
    required String holder,
    required String expiry,
    required String available,
  }) {
    return Container(
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF0B5D4D), Color(0xFF073B32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardType,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'VISA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          const Spacer(),

          const Icon(Icons.contactless, color: Colors.white70, size: 28),

          const SizedBox(height: 8),

          Text(
            cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              letterSpacing: 1.5,
            ),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CARD HOLDER',
                    style: TextStyle(color: Colors.white54, fontSize: 8),
                  ),
                  Text(
                    holder,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'EXPIRES',
                    style: TextStyle(color: Colors.white54, fontSize: 8),
                  ),
                  Text(
                    expiry,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _transaction({
    required IconData icon,
    required String title,
    required String date,
    required String amount,
    bool positive = false,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE6F2EF),
          child: Icon(icon, color: const Color(0xFF0B5D4D)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: positive ? Colors.green : Colors.black87,
          ),
        ),
      ),
    );
  }
}
