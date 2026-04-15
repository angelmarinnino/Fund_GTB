import 'package:flutter/material.dart';
import 'package:fondos_app/data/models/items_dropdown_model.dart';

class DropdownItem extends StatefulWidget {
  const DropdownItem({
    super.key,
    this.dropColor,
    this.textStyle,
    this.initValue,
    this.onChanged,
    this.validator,
    this.borderRadius,
    this.iconDropColor,
    required this.items,
  });

  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final ItemsDropdownModel? initValue;
  final List<ItemsDropdownModel> items;
  final Color? dropColor, iconDropColor;
  final String? Function(dynamic)? validator;
  final void Function(ItemsDropdownModel?)? onChanged;

  @override
  State<DropdownItem> createState() => DropdownItemState();
}

class DropdownItemState extends State<DropdownItem> {
  ItemsDropdownModel? selectedValue;

  @override
  void initState() {
    super.initState();
    _setInitValue();
  }

  void _setInitValue() {
    if (widget.initValue != null) {
      setState(() => selectedValue = widget.initValue);
    } else {
      setState(() => selectedValue = widget.items.first);
    }
  }

  OutlineInputBorder get _border => OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromARGB(255, 37, 19, 140),
      width: 1,
    ),
    borderRadius: widget.borderRadius ?? BorderRadius.circular(30),
  );

  List<DropdownMenuItem<ItemsDropdownModel>> get dropdownItems => widget.items
      .map((item) => DropdownMenuItem(value: item, child: _text(item.label)))
      .toList();

  Widget _text(String label) => Text(
    label,
    style: const TextStyle(
      fontSize: 15,
      color: Colors.black,
    ).merge(widget.textStyle),
  );
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ItemsDropdownModel>(
      decoration: InputDecoration(
        enabledBorder: _border,
        border: _border,
        filled: false,
        fillColor: widget.dropColor ?? Colors.white,
      ),
      isExpanded: true,
      iconEnabledColor: widget.iconDropColor ?? Colors.white,
      validator: widget.validator,
      dropdownColor: widget.dropColor ?? Colors.white,
      value: selectedValue,
      style: const TextStyle(),
      onChanged: (ItemsDropdownModel? value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onChanged?.call(value);
      },
      items: dropdownItems,
    );
  }
}
