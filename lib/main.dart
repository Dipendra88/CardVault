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
      home: const PinAuthenticationScreen(),
    );
  }
}

// ============================================================
// PIN AUTHENTICATION
// ============================================================

class PinAuthenticationScreen extends StatefulWidget {
  const PinAuthenticationScreen({super.key});

  @override
  State<PinAuthenticationScreen> createState() =>
      _PinAuthenticationScreenState();
}

class _PinAuthenticationScreenState extends State<PinAuthenticationScreen> {
  final String correctPin = '2580';

  String enteredPin = '';
  String? errorMessage;

  void _addDigit(String digit) {
    if (enteredPin.length >= 4) return;

    setState(() {
      errorMessage = null;
      enteredPin += digit;
    });

    if (enteredPin.length == 4) {
      Future.delayed(const Duration(milliseconds: 400), _authenticate);
    }
  }

  void _deleteDigit() {
    if (enteredPin.isEmpty) return;

    setState(() {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      errorMessage = null;
    });
  }

  void _authenticate() {
    if (!mounted) return;

    if (enteredPin == correctPin) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CardVaultHome()),
      );
    } else {
      setState(() {
        enteredPin = '';
        errorMessage = 'Incorrect PIN. Please try again.';
      });
    }
  }

  Widget _pinDot(int index) {
    final filled = index < enteredPin.length;

    return Container(
      width: 16,
      height: 16,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? const Color(0xFF0B5D4D) : Colors.grey.shade300,
      ),
    );
  }

  Widget _numberButton(String value) {
    return SizedBox(
      width: 75,
      height: 75,
      child: ElevatedButton(
        onPressed: () => _addDigit(value),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          shape: const CircleBorder(),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B5D4D),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'CardVault',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Unlock your CardVault',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Enter your PIN',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) => _pinDot(index)),
                  ),

                  const SizedBox(height: 12),

                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  const SizedBox(height: 28),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _numberButton('1'),
                          _numberButton('2'),
                          _numberButton('3'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _numberButton('4'),
                          _numberButton('5'),
                          _numberButton('6'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _numberButton('7'),
                          _numberButton('8'),
                          _numberButton('9'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 75),
                          _numberButton('0'),
                          SizedBox(
                            width: 75,
                            height: 75,
                            child: IconButton(
                              onPressed: _deleteDigit,
                              icon: const Icon(
                                Icons.backspace_outlined,
                                size: 27,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME + BOTTOM NAVIGATION
// ============================================================

class CardVaultHome extends StatefulWidget {
  const CardVaultHome({super.key});

  @override
  State<CardVaultHome> createState() => _CardVaultHomeState();
}

class _CardVaultHomeState extends State<CardVaultHome> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    CardsScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
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
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CardVault',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
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
              'Here is your financial overview',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    title: 'Available Credit',
                    amount: '₹82,450',
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _summaryCard(
                    title: 'Debit Balance',
                    amount: '₹45,230',
                    icon: Icons.account_balance_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const Text(
              'My Cards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 14),

            _homeCard(
              cardType: 'CREDIT',
              number: '•••• •••• •••• 4582',
              expiry: '09/29',
              available: '₹82,450',
              gradient: const [Color(0xFF0B5D4D), Color(0xFF083F35)],
            ),

            const SizedBox(height: 16),

            _homeCard(
              cardType: 'DEBIT',
              number: '•••• •••• •••• 7291',
              expiry: '11/28',
              available: '₹45,230',
              gradient: const [Color(0xFF243B53), Color(0xFF102A43)],
            ),

            const SizedBox(height: 28),

            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _transactionTile(context, transaction: transactions[0]),
            _transactionTile(context, transaction: transactions[1]),
            _transactionTile(context, transaction: transactions[2]),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String amount,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0B5D4D)),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 5),
          Text(
            amount,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _homeCard({
    required String cardType,
    required String number,
    required String expiry,
    required String available,
    required List<Color> gradient,
  }) {
    return Container(
      height: 190,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardType,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'DEEP RAJPUT',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(expiry, style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Available $available',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _transactionTile(
    BuildContext context, {
    required Transaction transaction,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  TransactionDetailsScreen(transaction: transaction),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: transaction.isIncome
              ? Colors.green.shade100
              : Colors.grey.shade200,
          child: Icon(
            transaction.icon,
            color: transaction.isIncome
                ? Colors.green.shade700
                : Colors.black87,
          ),
        ),
        title: Text(
          transaction.merchant,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(transaction.category),
        trailing: Text(
          transaction.formattedAmount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transaction.isIncome
                ? Colors.green.shade700
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CARDS SCREEN
// ============================================================

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool creditFrozen = false;
  bool debitFrozen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cards',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _cardSection(
            type: 'Credit Card',
            number: '•••• •••• •••• 4582',
            expiry: '09/29',
            balance: '₹82,450',
            frozen: creditFrozen,
            gradient: const [Color(0xFF0B5D4D), Color(0xFF083F35)],
            onChanged: (value) {
              setState(() {
                creditFrozen = value;
              });
            },
          ),
          const SizedBox(height: 20),
          _cardSection(
            type: 'Debit Card',
            number: '•••• •••• •••• 7291',
            expiry: '11/28',
            balance: '₹45,230',
            frozen: debitFrozen,
            gradient: const [Color(0xFF243B53), Color(0xFF102A43)],
            onChanged: (value) {
              setState(() {
                debitFrozen = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _cardSection({
    required String type,
    required String number,
    required String expiry,
    required String balance,
    required bool frozen,
    required List<Color> gradient,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      children: [
        Container(
          height: 210,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    type.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (frozen) const Icon(Icons.lock, color: Colors.white),
                ],
              ),
              const Spacer(),
              Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'DEEP RAJPUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(expiry, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Card(
          elevation: 0,
          child: SwitchListTile(
            title: Text(
              frozen ? 'Card Frozen' : 'Card Active',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              frozen
                  ? 'Transactions are temporarily disabled'
                  : 'Card is ready for transactions',
            ),
            value: frozen,
            onChanged: onChanged,
            secondary: Icon(
              frozen ? Icons.lock_outline : Icons.lock_open_outlined,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// ACTIVITY SCREEN
// ============================================================

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';

  List<Transaction> get filteredTransactions {
    return transactions.where((transaction) {
      final matchesSearch =
          transaction.merchant.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          transaction.category.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      final matchesCategory =
          selectedCategory == 'All' || transaction.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Shopping', 'Food', 'Income', 'Bills'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 55,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
             separatorBuilder: (_, _) =>
    const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];

                return ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: filteredTransactions.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 50, color: Colors.grey),
                        SizedBox(height: 12),
                        Text(
                          'No transactions found',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];

                      return _activityTransactionTile(transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _activityTransactionTile(Transaction transaction) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  TransactionDetailsScreen(transaction: transaction),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: transaction.isIncome
              ? Colors.green.shade100
              : Colors.grey.shade200,
          child: Icon(
            transaction.icon,
            color: transaction.isIncome
                ? Colors.green.shade700
                : Colors.black87,
          ),
        ),
        title: Text(
          transaction.merchant,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${transaction.category} • ${transaction.date}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: transaction.isIncome
                    ? Colors.green.shade700
                    : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              transaction.status,
              style: TextStyle(fontSize: 11, color: Colors.green.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TRANSACTION DETAILS
// ============================================================

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            CircleAvatar(
              radius: 38,
              backgroundColor: transaction.isIncome
                  ? Colors.green.shade100
                  : Colors.grey.shade200,
              child: Icon(
                transaction.icon,
                size: 38,
                color: transaction.isIncome
                    ? Colors.green.shade700
                    : Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              transaction.merchant,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: transaction.isIncome
                    ? Colors.green.shade700
                    : Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                transaction.status,
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 0,
              child: Column(
                children: [
                  _detailRow('Date', transaction.date),
                  _detailRow('Time', transaction.time),
                  _detailRow('Category', transaction.category),
                  _detailRow('Payment Method', transaction.paymentMethod),
                  _detailRow('Card', transaction.cardNumber),
                  _detailRow('Reference ID', transaction.referenceId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title, style: TextStyle(color: Colors.grey.shade600)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFF0B5D4D),
            child: Text(
              'DR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 14),

          const Center(
            child: Text(
              'Deep Rajput',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          Center(
            child: Text(
              'CardVault Customer',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Personal Information'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: const Text('Security'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications_none),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TRANSACTION MODEL
// ============================================================

class Transaction {
  final String merchant;
  final String category;
  final double amount;
  final bool isIncome;
  final String date;
  final String time;
  final String status;
  final String paymentMethod;
  final String cardNumber;
  final String referenceId;
  final IconData icon;

  const Transaction({
    required this.merchant,
    required this.category,
    required this.amount,
    required this.isIncome,
    required this.date,
    required this.time,
    required this.status,
    required this.paymentMethod,
    required this.cardNumber,
    required this.referenceId,
    required this.icon,
  });

  String get formattedAmount {
    final prefix = isIncome ? '+' : '-';
    return '$prefix ₹${amount.toStringAsFixed(0)}';
  }
}

// ============================================================
// TRANSACTION DATA
// ============================================================

const List<Transaction> transactions = [
  Transaction(
    merchant: 'Amazon',
    category: 'Shopping',
    amount: 2499,
    isIncome: false,
    date: '24 Sep 2026',
    time: '10:42 AM',
    status: 'Completed',
    paymentMethod: 'Credit Card',
    cardNumber: '•••• 4582',
    referenceId: 'CV-AMZ-45821',
    icon: Icons.shopping_bag_outlined,
  ),
  Transaction(
    merchant: 'Swiggy',
    category: 'Food',
    amount: 540,
    isIncome: false,
    date: '23 Sep 2026',
    time: '08:15 PM',
    status: 'Completed',
    paymentMethod: 'Debit Card',
    cardNumber: '•••• 7291',
    referenceId: 'CV-SWG-72912',
    icon: Icons.restaurant_outlined,
  ),
  Transaction(
    merchant: 'Salary',
    category: 'Income',
    amount: 82000,
    isIncome: true,
    date: '22 Sep 2026',
    time: '09:30 AM',
    status: 'Credited',
    paymentMethod: 'Bank Transfer',
    cardNumber: 'Account **** 2048',
    referenceId: 'CV-SAL-82001',
    icon: Icons.account_balance_outlined,
  ),
  Transaction(
    merchant: 'Electricity Bill',
    category: 'Bills',
    amount: 1850,
    isIncome: false,
    date: '20 Sep 2026',
    time: '06:25 PM',
    status: 'Completed',
    paymentMethod: 'Debit Card',
    cardNumber: '•••• 7291',
    referenceId: 'CV-EB-18502',
    icon: Icons.bolt_outlined,
  ),
  Transaction(
    merchant: 'Flipkart',
    category: 'Shopping',
    amount: 3299,
    isIncome: false,
    date: '18 Sep 2026',
    time: '04:12 PM',
    status: 'Completed',
    paymentMethod: 'Credit Card',
    cardNumber: '•••• 4582',
    referenceId: 'CV-FLK-32993',
    icon: Icons.shopping_cart_outlined,
  ),
];
