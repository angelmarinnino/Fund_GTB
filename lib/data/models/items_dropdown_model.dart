class ItemsDropdownModel {
  const ItemsDropdownModel({required this.label, required this.value});

  final String label;
  final dynamic value;

  ItemsDropdownModel copyWith({String? label, dynamic value}) {
    return ItemsDropdownModel(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }
}
