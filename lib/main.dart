import 'package:flutter/material.dart';
import 'widgets/currency_card.dart';
import 'widgets/dropdown_field.dart';
import 'widgets/swap_button.dart';
import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZainoFX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Color(0xFFF5F7FA),
        fontFamily: 'Inter',
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  double amount = 1;
  String fromCurrency = 'USD';
  String toCurrency = 'PKR';
  double convertedAmount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Delay added to allow first frame to render before heavy async work
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _convertCurrency();
    });
  }

  Future<void> _convertCurrency() async {
    setState(() => isLoading = true);
    try {
      final rate = await ApiService.getExchangeRate(
        from: fromCurrency,
        to: toCurrency,
      );
      setState(() {
        convertedAmount = amount * rate;
      });
    } catch (e) {
      // You can show a SnackBar or alert here
      debugPrint("Error fetching rate: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _swapCurrencies() {
    setState(() {
      final temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
    _convertCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            CurrencyCard(
              amount: amount,
              currency: fromCurrency,
              onChanged: (value) {
                setState(() => amount = value);
                _convertCurrency();
              },
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CurrencyDropdown(
                    value: fromCurrency,
                    onChanged: (newCurrency) {
                      setState(() => fromCurrency = newCurrency);
                      _convertCurrency();
                    },
                  ),
                ),
                SwapButton(onPressed: _swapCurrencies),
                Expanded(
                  child: CurrencyDropdown(
                    value: toCurrency,
                    onChanged: (newCurrency) {
                      setState(() => toCurrency = newCurrency);
                      _convertCurrency();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'ZainoFX',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFFED5B2D),
    );
  }

  Widget _buildResultCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFED5B2D).withOpacity(0.8),
            Color(0xFFE80B0B),
          ],
          stops: [0.3, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            '${amount.toStringAsFixed(2)} $fromCurrency =',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '${convertedAmount.toStringAsFixed(2)} $toCurrency',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
