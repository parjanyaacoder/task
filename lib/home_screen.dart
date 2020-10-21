import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graph_app/image_input.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Function submit(File savedImage,BuildContext context) {

    UserInput ui = UserInput(nameController.text, emailController.text, descController.text,savedImage.path);
    this.callApi(ui);
   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BugScreen()));
   print(ui);
  }

  Future<void> callApi(UserInput ui) async
  {
    print(ui);
     final String url = "https://testing-api-screen.herokuapp.com/api/bug/";
     final response = await http.post(url,body: {
       'name':ui.name,
       'email':ui.email,
       'description':ui.description,
     //  'image':ui.image,
     });
     print("hello");
     print(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: nameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                controller: descController,
              ),
              SizedBox(
                height: 10,
              ),
              ImageInput(onSelectImage: submit,),

            ],
          ),
        ),
      ),
    );
  }
}

class BugScreen extends StatefulWidget {
  @override
  _BugScreenState createState() => _BugScreenState();
}



class _BugScreenState extends State<BugScreen> {


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<UserInputs>(context).fetchData();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserInputs>(context).list;
    return Scaffold(
      body:   Container(child: data != null ?
          Consumer<UserInputs>(
           builder: (context,_,ch) => Container(
             child: ListView.builder(itemBuilder: (context,index) => ListTile(
                title: Text(data[index].name),
                subtitle: Text(data[index].email),
              )

                ,itemCount: data.length ,),
           ),
          ) : Text('No data')
        ),
    );
  }
}


class UserInput {
  final String name;
  final String email;
  final String description;
  String image;

  UserInput(this.name, this.email, this.description,this.image);
}

class UserInputs with ChangeNotifier {


  List<UserInput> _list = [];

  List<UserInput> get list {
    return [..._list];



  }

  Future<void> fetchData() async {
    final String url = "https://testing-api-screen.herokuapp.com/api/bug/";
    final response = await http.get(url);

    final List<UserInput> loadedInfo = [];

      final extractedData = json.decode(response.body);

      extractedData.forEach((value) {
        loadedInfo.add(UserInput(value['name'], value['email'], value['description'], value['image']));
      });



   _list = loadedInfo;

   notifyListeners();
   return;
  }



}