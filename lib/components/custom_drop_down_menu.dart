import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatelessWidget {
  final List<String> _list;
  final String _title;
  // ignore: prefer_typing_uninitialized_variables
  final _selectedOption;
  final ValueChanged _onChange;
  final FormFieldValidator? _validator;

  const CustomDropDownMenu(this._list, this._title, this._selectedOption,
      this._onChange, this._validator,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration.collapsed(hintText: ''),
        hint: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            _title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        isExpanded: true,
        iconSize: 40,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        items: _list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                value,
              ),
            ),
          );
        }).toList(),
        onChanged: _onChange,
        value: _selectedOption,
        validator: _validator,
      ),
    ));
  }
}
