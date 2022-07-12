import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   Future<dynamic> login() async {
     var url = Uri.parse('https://my-json-server.typicode.com/danilovitolo/fakeApi4Sys/login');
     var response = await http.get(url);




    if (response.statusCode == 200){
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('erro ao carregar dados do servidor');
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Postes"),
      ),

      body: FutureBuilder<dynamic>(
        future: login(),
        builder: (context, snapshot){

          if(snapshot.hasError) {
            return Center(
              child: Text('Erro ao Carregar Usuarios'),
            );
          }

        /*  if (snapshot.hasData){
            return ListView.builder(
              itemCount:snapshot.data!.length,
                itemBuilder: (context,index){
                  return ListTile(
                  title: Text(snapshot.data[index]),

                  );
                },);
          }
           */
          // em caso de eemora de retorno do servidor aparaecerar loading circular centralizado
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
