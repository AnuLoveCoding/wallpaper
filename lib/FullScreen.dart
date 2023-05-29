import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FullScreen extends StatefulWidget {
  String imagee;
  FullScreen({required this.imagee});

  @override
  State<FullScreen> createState() => _FullScreenState();
}
class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Mode'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fullscreen(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemBuilder: (context, i){
                  return Column(
                    children: [
                      Image.network(widget.imagee,fit: BoxFit.cover,width: double.infinity,),
                    ],
                  );
                }
            );
          }else if(snapshot.hasError){
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }

  Future<List<dynamic>> fullscreen() async {
      final response = await http.get(Uri.parse(''));
      if(response.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Load Successfull')));
        return jsonDecode(response.body);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CircularProgressIndicator()));
        throw Exception("Failde load data");
      }
  }
}



