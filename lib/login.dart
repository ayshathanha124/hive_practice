import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Loginpage extends StatefulWidget {
  const new({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController usernameController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  final box =Hive.box('loginBox');
  String savedUsername = '';
  @override
  void initState(){
    super.initState();
    savedUsername =box.get('username',defaultValue: '');
    usernameController.text =savedUsername;
    passwordController.text = box.get('password',defaultValue: '');
  }
  void savedData()  async{
    String username = usernameController.text.trim();
    String password = passwordController.text;

    if(username.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("please enter the field"),
        ),
      );
      return;
    }
    await box.put('username', username);
    await box.put('password', password);

    setState(() {
      username =username;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("data saved successfullyyy")),
    );
    
    void dispose(){
      usernameController.dispose();
      passwordController.dispose();
      super.dispose();
    }
    
      }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "UserName",
                  border: OutlineInputBorder(
                  )
                ),
              ),
              SizedBox(height: 20,),
               TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder(
                  )
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: savedData, child: Text("Submit",style: TextStyle(fontSize: 20),),),
                                SizedBox(height: 30),

                  // Display saved data
                  Text(
                    "Saved Data",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),

                  if (savedUsername.isNotEmpty)
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(savedUsername),
                        subtitle: Text('Password: Saved (hidden)'),
                      ),
                    )
                  else
                    Text("No data saved yet"),


            ],
          ),
        ),
      ),
      ),
    );
  }
}