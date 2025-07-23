import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final double amount;
  final String currency;
  final ValueChanged<double> onChanged;

  const CurrencyCard({
    required this.amount,
    required this.currency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount to Convert',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              border: InputBorder.none,
              prefix: Text(
                '$currency ',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFFED5B2D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onChanged: (value) => onChanged(double.tryParse(value) ?? 0),
          ),
        ],
      ),
    );
  }
}