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
  static const String correctPin = '2580';

  String enteredPin = '';
  String? errorMessage;
  bool isAuthenticating = false;

  void _addDigit(String digit) {
    if (isAuthenticating) return;

    if (enteredPin.length < 4) {
      setState(() {
        errorMessage = null;
        enteredPin += digit;
      });

      if (enteredPin.length == 4) {
        _authenticate();
      }
    }
  }

  void _deleteDigit() {
    if (isAuthenticating || enteredPin.isEmpty) return;

    setState(() {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      errorMessage = null;
    });
  }

  Future<void> _authenticate() async {
    setState(() {
      isAuthenticating = true;
    });

    // Small delay to simulate authentication processing.
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    if (enteredPin == correctPin) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CardVaultHome()),
      );
    } else {
      setState(() {
        enteredPin = '';
        errorMessage = 'Incorrect PIN. Please try again.';
        isAuthenticating = false;
      });
    }
  }

  Widget _pinDot(int index) {
    final bool filled = index < enteredPin.length;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 18,
      height: 18,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? const Color(0xFF0B5D4D) : Colors.transparent,
        border: Border.all(color: const Color(0xFF0B5D4D), width: 2),
      ),
    );
  }

  Widget _numberButton(String number) {
    return SizedBox(
      width: 72,
      height: 72,
      child: ElevatedButton(
        onPressed: () => _addDigit(number),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF073B32),
          shape: const CircleBorder(),
        ),
        child: Text(
          number,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Vault icon
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B5D4D),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 7),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'CardVault',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF073B32),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Your cards. Your vault. Your control.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 36),

                const Text(
                  'Enter your PIN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  'Unlock your CardVault',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 24),

                // PIN dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_pinDot(0), _pinDot(1), _pinDot(2), _pinDot(3)],
                ),

                const SizedBox(height: 12),

                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else
                  const SizedBox(height: 19),

                const SizedBox(height: 18),

                // Number pad
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _numberButton('1'),
                    const SizedBox(width: 18),
                    _numberButton('2'),
                    const SizedBox(width: 18),
                    _numberButton('3'),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _numberButton('4'),
                    const SizedBox(width: 18),
                    _numberButton('5'),
                    const SizedBox(width: 18),
                    _numberButton('6'),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _numberButton('7'),
                    const SizedBox(width: 18),
                    _numberButton('8'),
                    const SizedBox(width: 18),
                    _numberButton('9'),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 72, height: 72),
                    const SizedBox(width: 18),
                    _numberButton('0'),
                    const SizedBox(width: 18),
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: IconButton(
                        onPressed: _deleteDigit,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        icon: const Icon(
                          Icons.backspace_outlined,
                          color: Color(0xFF073B32),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                if (isAuthenticating)
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Color(0xFF0B5D4D),
                    ),
                  )
                else
                  Text(
                    'Secure PIN authentication',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CARDVAULT HOME
// ============================================================

class CardVaultHome extends StatefulWidget {
  const CardVaultHome({super.key});

  @override
  State<CardVaultHome> createState() => _CardVaultHomeState();
}

class _CardVaultHomeState extends State<CardVaultHome> {
  int selectedIndex = 0;

  final List<String> pageTitles = [
    'CardVault',
    'My Cards',
    'Activity',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5D4D),
        foregroundColor: Colors.white,
        title: Text(
          pageTitles[selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
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

      body: _buildCurrentPage(),

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

  Widget _buildCurrentPage() {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();

      case 1:
        return const CardsScreen();

      case 2:
        return const ActivityScreen();

      case 3:
        return const ProfileScreen();

      default:
        return const HomeScreen();
    }
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

          _buildCard(
            cardType: 'CREDIT CARD',
            cardNumber: '••••  ••••  ••••  4582',
            holder: 'DEEP RAJPUT',
            expiry: '09/29',
          ),

          const SizedBox(height: 16),

          _buildCard(
            cardType: 'DEBIT CARD',
            cardNumber: '••••  ••••  ••••  7291',
            holder: 'DEEP RAJPUT',
            expiry: '11/28',
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
    );
  }

  Widget _buildCard({
    required String cardType,
    required String cardNumber,
    required String holder,
    required String expiry,
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
        boxShadow: const [
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

// ============================================================
// CARDS SCREEN
// ============================================================

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool creditCardFrozen = false;
  bool debitCardFrozen = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manage Your Cards',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            'View and manage your debit and credit cards',
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 24),

          _buildManagedCard(
            cardType: 'CREDIT CARD',
            cardNumber: '••••  ••••  ••••  4582',
            holder: 'DEEP RAJPUT',
            expiry: '09/29',
            available: '₹82,450',
            frozen: creditCardFrozen,
            onFreezeChanged: (value) {
              setState(() {
                creditCardFrozen = value;
              });
            },
          ),

          const SizedBox(height: 24),

          _buildManagedCard(
            cardType: 'DEBIT CARD',
            cardNumber: '••••  ••••  ••••  7291',
            holder: 'DEEP RAJPUT',
            expiry: '11/28',
            available: '₹45,230',
            frozen: debitCardFrozen,
            onFreezeChanged: (value) {
              setState(() {
                debitCardFrozen = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildManagedCard({
    required String cardType,
    required String cardNumber,
    required String holder,
    required String expiry,
    required String available,
    required bool frozen,
    required ValueChanged<bool> onFreezeChanged,
  }) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 210,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: frozen
                  ? [Colors.grey.shade700, Colors.grey.shade900]
                  : const [Color(0xFF0B5D4D), Color(0xFF073B32)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
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
        ),

        const SizedBox(height: 10),

        Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFF0B5D4D),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Available Credit',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        available,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Switch(value: frozen, onChanged: onFreezeChanged),
                    Text(
                      frozen ? 'Frozen' : 'Active',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: frozen ? Colors.red : const Color(0xFF0B5D4D),
                      ),
                    ),
                  ],
                ),
              ],
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

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            'Your recent card activity',
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 24),

          _activityItem(
            icon: Icons.shopping_bag_outlined,
            title: 'Amazon',
            date: 'Today',
            amount: '- ₹1,299',
          ),

          _activityItem(
            icon: Icons.fastfood_outlined,
            title: 'Swiggy',
            date: 'Yesterday',
            amount: '- ₹450',
          ),

          _activityItem(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Salary',
            date: '20 Sep',
            amount: '+ ₹82,000',
            positive: true,
          ),

          _activityItem(
            icon: Icons.local_gas_station_outlined,
            title: 'Fuel Station',
            date: '18 Sep',
            amount: '- ₹2,000',
          ),

          _activityItem(
            icon: Icons.movie_outlined,
            title: 'BookMyShow',
            date: '17 Sep',
            amount: '- ₹650',
          ),
        ],
      ),
    );
  }

  Widget _activityItem({
    required IconData icon,
    required String title,
    required String date,
    required String amount,
    bool positive = false,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),

          const CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFFE6F2EF),
            child: Icon(Icons.person, size: 48, color: Color(0xFF0B5D4D)),
          ),

          const SizedBox(height: 14),

          const Text(
            'Deep Rajput',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Text('CardVault User', style: TextStyle(color: Colors.grey.shade600)),

          const SizedBox(height: 30),

          _profileOption(
            icon: Icons.person_outline,
            title: 'Personal Information',
          ),

          _profileOption(icon: Icons.security_outlined, title: 'Security'),

          _profileOption(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
          ),

          _profileOption(icon: Icons.settings_outlined, title: 'Settings'),

          _profileOption(icon: Icons.help_outline, title: 'Help & Support'),
        ],
      ),
    );
  }

  Widget _profileOption({required IconData icon, required String title}) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE6F2EF),
          child: Icon(icon, color: const Color(0xFF0B5D4D)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
