import 'package:flutter/material.dart';

class MultiSelectDialogItem<T> {
  const MultiSelectDialogItem(this.value, this.label);

  final T value;
  final String label;
}

class CustomMultiSelectDialog<T> extends StatefulWidget {
  final List<MultiSelectDialogItem<T>> items;
  final Set<T> initialSelectedValues;

  final String title;

  const CustomMultiSelectDialog(
      {Key? key,
      required this.items,
      this.initialSelectedValues = const {},
      required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomMultiSelectDialogState<T>();
}

class _CustomMultiSelectDialogState<T>
    extends State<CustomMultiSelectDialog<T>> {
  final _selectedValues = <T>{};

  @override
  void initState() {
    super.initState();
    if (widget.initialSelectedValues.isNotEmpty) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(T itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      contentPadding: const EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: const EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: const Text('OK'),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<T> item) {
    final bool checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) =>
          _onItemCheckedChange(item.value, checked ?? false),
    );
  }
}
