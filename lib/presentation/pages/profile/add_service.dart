import 'package:desk/const/type_models.dart';
import 'package:desk/model/type_model.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddService extends StatefulWidget {
  const AddService({
    super.key,
    required this.action,
  });

  final Function(String, String, int, TypeEnum) action;

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  TypeModel _selectedType = typeModels[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Desk"),
        centerTitle: true,
      ),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              cursorColor: Colors.black,
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Введите название услуги",
                icon: Icon(Icons.design_services_outlined),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              cursorColor: Colors.black,
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Введите описание услуги",
                icon: Icon(Icons.description_outlined),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              cursorColor: Colors.black,
              controller: _costController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                labelText: "Введите стоимость услуги",
                icon: Icon(Icons.account_balance_wallet_outlined),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextButton.icon(
                      style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                              BorderSide(color: Colors.black))),
                      label: const Text("Выбрать тип услуги"),
                      onPressed: () {
                        DropDownState<TypeModel>(
                          dropDown: DropDown<TypeModel>(
                            data: <SelectedListItem<TypeModel>>[
                              for (var type in typeModels)
                                SelectedListItem<TypeModel>(data: type),
                            ],
                            onSelected: (selectedItems) {
                              _selectedType = selectedItems.first.data;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.black,
                                  content: Text(
                                    textAlign: TextAlign.center,
                                    _selectedType.toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ).showModal(context);
                      },
                      icon: const Icon(Icons.filter_alt)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextButton.icon(
                      style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                              BorderSide(color: Colors.black))),
                      onPressed: () {
                        final name = _nameController.text;
                        final description = _descriptionController.text;
                        final cost = int.parse(_costController.text);
                        final type = _selectedType.type;

                        widget.action(
                          name,
                          description,
                          cost,
                          type,
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.done_outline_outlined),
                      label: const Text("Создать")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
