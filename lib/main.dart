import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        fontFamily: 'DS-Digital',
      ),
      home: const MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>{
  
  int value = 0;
  int storage = 0;
  String quedOp = "";
  bool isOpQued = false; 

  void operation(String op){
    switch(op){
      case 'ce':
        setState(() {
          value = 0;
          storage = 0;
          quedOp = "";
        });
      case 'del':
        setState(() {
          value = value ~/ 10;
        });
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '0':
      if(isOpQued){
        setState(() {
          value=int.parse(op);
          isOpQued = false;
        });
      }else{
      setState(() {
        if(value<0){
        value = value * 10 - int.parse(op);}
        else{
          value = value * 10 + int.parse(op);
        }
      });}

      case '+':
      case '-':
      case '*':
      case '/':
      if(isOpQued){
        quedOp = op;
      }else{
        setState(() {
          storage = performOp(quedOp);
          // value = 0;
          quedOp = op;
          isOpQued = true;
        });}

      case '=':
      setState(() {
        value = performOp(quedOp);
        storage = 0;
        quedOp = "";
      });
        
    }
  }

  int performOp(String op){
    switch(op){
      case '+':
      return storage + value;
      case '-':
      return storage - value;
      case '*':
      return storage * value;
      case '/':
      if (value != 0){
        return storage ~/ value;
      }else{
        return 0;
      }
      case "":
      return value;
      default :
      return value;
    }
  }


  @override
  Widget build(BuildContext context){
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Color.fromRGBO(140, 150, 140, 1),
                child: Align(
                  alignment: Alignment.centerRight,
                child: Text(
                  value.toString(), 
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color.fromRGBO(140, 150, 140, 1),
                  ),),
                            ),
              ),),

            Expanded(
              child: Row(children: [
                  Expanded(child: MyElevatedButton(child: const MyText('CE'), onPressed: ()=> operation('ce'),)),
                  Expanded(child: MyElevatedButton(child: const MyText('Del'), onPressed: ()=> operation('del'),)),
                  MyElevatedButton(child: const MyText('+'), onPressed: ()=> operation('+'),),
              ],),
            ),

            Expanded(
              child: Row(children:[
                MyElevatedButton(child: const MyText('7'), onPressed : ()=> operation('7')), 
                MyElevatedButton(child: const MyText('8'), onPressed : ()=> operation('8')),
                MyElevatedButton(child: const MyText('9'), onPressed : ()=> operation('9')),
                MyElevatedButton(child: const MyText('-'), onPressed : ()=> operation('-')),
              ]),
            ),

            Expanded(
              child: Row(children:[
                MyElevatedButton(child: const MyText('4'), onPressed : ()=> operation('4')), 
                MyElevatedButton(child: const MyText('5'), onPressed : ()=> operation('5')),
                MyElevatedButton(child: const MyText('6'), onPressed : ()=> operation('6')),
                MyElevatedButton(child: const MyText('*'), onPressed : ()=> operation('*')),
              ]),
            ),

            Expanded(
              child: Row(children:[
                MyElevatedButton(child: const MyText('1'), onPressed : ()=> operation('1')), 
                MyElevatedButton(child: const MyText('2'), onPressed : ()=> operation('2')),
                MyElevatedButton(child: const MyText('3'), onPressed : ()=> operation('3')),
                MyElevatedButton(child: const MyText('/'), onPressed : ()=> operation('/')),
              ]),
            ),

            Expanded(
              child: Row(children:[
                Expanded(child: MyElevatedButton(child: const MyText('0'), onPressed : ()=> operation('0'))), 
                MyElevatedButton(child: const MyText('='), onPressed : ()=> operation('=')),
              ]),
            ),
          ],),
      );
  }
}


class MyText extends StatelessWidget{

  const MyText(this.text);
  final String text;

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}


class MyElevatedButton extends StatelessWidget{
  const MyElevatedButton({super.key, required this.onPressed, required this.child});
  final Widget child;
  final VoidCallback onPressed ;

  final myStyle = const ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 224, 223, 217)),
    backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(185, 19, 19, 19)),
    shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
      side: BorderSide(color: Color.fromARGB(255, 189, 181, 178), width: 10.0)
    ))
  );

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    double buttonWidth = size.width / 4;
    double buttonHeight = size.height / 6;
    
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
      style: myStyle,
      onPressed: onPressed,
      child: child,
      ),
    );

  }
}

