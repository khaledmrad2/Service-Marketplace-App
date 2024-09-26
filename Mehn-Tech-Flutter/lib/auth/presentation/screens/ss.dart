import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../shared/component.dart';

List<country> countries = [
  country(id: 1, name: 'Damascus'),
  country(id: 2, name: 'Aleppo'),
  country(id: 3, name: 'Daraa'),
  country(id: 4, name: 'Deir ez-Zor'),
  country(id: 5, name: 'Hama'),
  country(id: 6, name: 'Al-Hasakah'),
  country(id: 7, name: 'Homs'),
  country(id: 8, name: 'Latakia'),
  country(id: 9, name: 'Quneitra'),
  country(id: 10, name: 'Ar-Raqqah'),
  country(id: 11, name: 'As-Suwayda'),
  country(id: 12, name: 'Tartus'),
  country(id: 13, name: 'Al-Nabek'),
];
List<DropdownMenuItem<country>> dropdownItems = countries.map((country item) {
  return DropdownMenuItem<country>(
    value: item,
    child: Text(
      item.name,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}).toList();

class khaled extends StatefulWidget {
  const khaled({super.key});

  @override
  State<khaled> createState() => _khaledState();
}

class _khaledState extends State<khaled> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  country? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        DropdownButtonHideUnderline(
          child: DropdownButton2<country>(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: dropdownItems,
            value: selectedValue,
            onChanged: (country? value) {
              setState(() {
                selectedValue = value;
              });
              print(value!.name);
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 160,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.redAccent,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.yellow,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.redAccent,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ),
    );
  }
}
