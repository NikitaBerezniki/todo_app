import 'package:flutter/material.dart';

import 'add_group_provider.dart';


class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({Key? key}) : super(key: key);

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _model = AddGroupModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавление группы',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: AddGroupProvider(model: _model, child: const _AddGroupForm()),
    );
  }
}

class _AddGroupForm extends StatelessWidget {
  const _AddGroupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AddGroupProvider.of(context)?.model;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (value) => model?.nameGroup = value,
            decoration: InputDecoration(hintText: 'Название группы', errorText: model?.errorText),
            autofocus: true,
            
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                model?.saveGroup(context);
              },
              child: const Text('Добавить группу',
                  style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
