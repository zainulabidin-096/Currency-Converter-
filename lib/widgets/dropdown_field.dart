import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CurrencyDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const CurrencyDropdown({
    required this.value,
    required this.onChanged,
  });

  final List<String> currencies = const [
    'USD', 'EUR', 'PKR', 'INR', 'GBP',
    'JPY', 'AUD', 'CAD', 'CNY', 'AED'
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
        value: value,
        items: currencies.map((String currency) {
      return DropdownMenuItem<String>(
        value: currency,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            currency,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      );
    }).toList(),
    onChanged: (newValue) => onChanged(newValue!),
    buttonStyleData: ButtonStyleData(
    height: 50,
    width: double.infinity,
    padding: const EdgeInsets.only(left: 16, right: 8),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: const [
    BoxShadow(
    color: Color(0x0D000000), // Equivalent to Colors.black.withOpacity(0.05)
    blurRadius: 8,
    offset: Offset(0, 4),
    ),
    ],
    ),
    ),
    dropdownStyleData: DropdownStyleData(
    maxHeight: 200,
    width: 160,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: const [
    BoxShadow(
    color: Color(0x1A000000), // Equivalent to Colors.black.withOpacity(0.1)
    blurRadius: 12,
    offset: Offset(0, 6),
    ),
    ],
    ),
    offset: const Offset(0, -8),
    scrollbarTheme: ScrollbarThemeData(
    radius: const Radius.circular(4),
    thickness: MaterialStateProperty.all(6),
    thumbVisibility: MaterialStateProperty.all(true),
    thumbColor: MaterialStateProperty.all(Colors.grey[300]),
    ),
    ),
    iconStyleData: const IconStyleData(
    icon: Icon(Icons.arrow_drop_down_rounded),
    iconSize: 24,
    iconEnabledColor: Color(0xFFED5B2D),
    ),
    menuItemStyleData: MenuItemStyleData(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    ),// Fixed hover color
    ),
    );
  }
}