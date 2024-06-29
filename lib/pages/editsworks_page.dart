import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tz_flutter/models/workspace.dart';

class EditWorkspaceDialog extends StatefulWidget {
  final Workspace workspace;
  final void Function(String, Color) onSave;

  const EditWorkspaceDialog({
    required this.workspace,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  _EditWorkspaceDialogState createState() => _EditWorkspaceDialogState();
}

class _EditWorkspaceDialogState extends State<EditWorkspaceDialog> {
  late TextEditingController _nameController;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.workspace.name);
    _selectedColor = widget.workspace.color;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Workspace'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () async {
              final pickedColor = await showDialog<Color>(
                context: context,
                builder: (context) =>
                    ColorPickerDialog(currentColor: _selectedColor),
              );
              if (pickedColor != null) {
                setState(() {
                  _selectedColor = pickedColor;
                });
              }
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(_nameController.text, _selectedColor);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class ColorPickerDialog extends StatefulWidget {
  final Color currentColor;

  const ColorPickerDialog({
    required this.currentColor,
    Key? key,
  }) : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color _pickerColor;

  @override
  void initState() {
    super.initState();
    _pickerColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: _pickerColor,
          onColorChanged: (color) {
            setState(() {
              _pickerColor = color;
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_pickerColor);
          },
          child: const Text('Select'),
        ),
      ],
    );
  }
}
