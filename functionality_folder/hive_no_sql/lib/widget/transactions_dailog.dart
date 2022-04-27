import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_no_sql/model/transcation.dart';
import 'package:image_picker/image_picker.dart';

class TransactionDialog extends StatefulWidget {
  final Transaction? transaction;
  final Function(String name, double amount, bool isExpense, Uint8List somename)
      onClickedDone;

  const TransactionDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  Uint8List? memoryImage;
  bool isExpense = true;

  bool onpressedbutton = false;
  File? imageFilePath;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;

      nameController.text = transaction.name;
      amountController.text = transaction.amount.toString();
      isExpense = transaction.isExpense;
      memoryImage = transaction.billImage;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
   
    super.dispose();
  }

  Image() {
    return Column(
      children: [
        Container(
            child: ElevatedButton(
          onPressed: () async {
            final img =
                await ImagePicker().getImage(source: ImageSource.gallery);
            Uint8List a = await img!.readAsBytes();

            setState(() {
              // memoryImage = bytes;
              imageFilePath = File(img.path);
              memoryImage = a;
            });
            print(memoryImage.toString());
          },
          child: const Text("ADD IMAGE"),
        )),
        memoryImage != null
            ? Container(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: MemoryImage(memoryImage!),
                      radius: 90,
                    ),
                    // Container(
                    //   width: 150,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         fit: BoxFit.cover,
                    //         image: MemoryImage(memoryImage!, scale: 0.5)),
                    //   ),
                    // ),
                  ],
                ),
              )
            : const Text('NO IMAGES')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              buildName(),
              const SizedBox(height: 6),
              buildAmount(),
              const SizedBox(height: 5),
              buildRadioButtons(),
              const SizedBox(height: 5),
              Image()
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildAmount() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Amount',
        ),
        keyboardType: TextInputType.number,
        validator: (amount) => amount != null && double.tryParse(amount) == null
            ? 'Enter a valid number'
            : null,
        controller: amountController,
      );

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: const Text('Expense'),
            value: true,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
          ),
          RadioListTile<bool>(
            title: const Text('Income'),
            value: false,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
          ),
        ],
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final amount = double.tryParse(amountController.text) ?? 0;
          final billImage = memoryImage;
          widget.onClickedDone(
            name,
            amount,
            isExpense,
            billImage!,
          );

          Navigator.of(context).pop();
        }
      },
    );
  }
}
