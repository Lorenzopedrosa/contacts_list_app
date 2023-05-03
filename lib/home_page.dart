import 'package:contacts_app/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController horarioController = TextEditingController();
  TextEditingController dataController = TextEditingController();


  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Agendamento Atual Odontologia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Número',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(13),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              maxLength: 3,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Idade',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: horarioController,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Horario',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
             const SizedBox(height: 10),
            TextField(
              controller: dataController,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Data da Consulta',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      String age = ageController.text.trim();
                      String horario = horarioController.text.trim();
                      String data = dataController.text.trim();

                      if (name.isNotEmpty && contact.isNotEmpty && age.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          ageController.text = '';
                          horarioController.text = '';
                          dataController.text = '';
                          contacts.add(Contact(name: name, contact: contact, age: age, horario: horario, data: data));
                        });
                      }
                      //
                    },
                    child: const Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String age = ageController.text.trim();
                      String contact = contactController.text.trim();
                      String horario = horarioController.text.trim();
                      String data = dataController.text.trim();

                      if (name.isNotEmpty && contact.isNotEmpty && age.isNotEmpty && horario.isNotEmpty && data.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          ageController.text = '';
                          horarioController.text = '';
                          dataController.text = '';

                          contacts[selectedIndex].name = name;
                          contacts[selectedIndex].contact = contact;
                          contacts[selectedIndex].age = age;
                          contacts[selectedIndex].horario = horario;
                          contacts[selectedIndex].data = data;
                          selectedIndex = -5;
                        });
                      }
                      //
                    },
                    child: const Text('Atualizar')),
              ],
            ),
            const SizedBox(height: 10),
            contacts.isEmpty
                ? const Text(
                    'Nenhum agendamento ainda...',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              contacts[index].age,
            ),
            Text(
              contacts[index].horario,
            ),
            Text(
              contacts[index].data,
            ),
            
            Text(contacts[index].contact),
          ],           
          
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    ageController.text = contacts[index].age;
                    horarioController.text = contacts[index].horario;
                    dataController.text = contacts[index].data;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      contacts.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
