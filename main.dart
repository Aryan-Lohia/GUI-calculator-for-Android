import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() {
  runApp(MaterialApp(
      home: MyHome(),
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
                fixedSize: MaterialStateProperty.all(Size(100, 100)))),
      )));
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String expression = "";

  void textEditor(String a) {
    String lastindex = "";
    if (expression.length != 0) lastindex = expression[expression.length - 1];
    if (a == "C") {
      setState(() {
        expression = "";
      });
    }
    else if (a == "B") {
      setState(() {
        expression = expression.substring(0, expression.length - 1);
      });
    }
    else if ((a == "+" || a == "-" || a == "*" || a == "/" || a == "%") &&
        (lastindex == "+" ||
            lastindex == "-" ||
            lastindex == "*" ||
            lastindex == "/" ||
            lastindex == "%")) {

      if (a != lastindex)
        setState(() {
          expression = expression.substring(0, expression.length - 1) + a;
        });
    }
    else if (a == "()") {
      int o = 0, c = 0;
      for (int i = 0; i < expression.length; i++) {
        if (expression[i] == "(")
          o++;
        else if (expression[i] == ")") c++;
      }

      if (o == c && (num.tryParse(lastindex) != null || lastindex == ")"))
        setState(() {
          expression += "*(";
        });
      else if (o == c && ( lastindex == "."))
        setState(() {
          expression += "0*(";
        });
      else if (o > c && (num.tryParse(lastindex) != null || lastindex == ")")) {
        setState(() {
          expression += ")";
        });
      }
      else if (o > c && lastindex == ".") {
        setState(() {
          expression += "0)";
        });
      }
      else {
        setState(() {
          expression += "(";
        });
      }
    }
    else if (a==".") {
      int f = 0;
      for (int i = expression.length - 1; i >= 0; i--)
        if (expression[i] == "+" || expression[i] == "-" ||
            expression[i] == "*" || expression[i] == "/" ||
            expression[i] == "%" ) {
          break;
        }
        else if (expression[i] == ".") {
          f = 1;
          break;
        }
        if (f==0)
          {if(lastindex=="("||lastindex == "+" || lastindex == "-" || lastindex == "*" || lastindex == "/" || lastindex == "%"||expression.isEmpty)a="0.";
            setState(() {
            expression += a;});
    }


        
      }
     else {
      if (a=="3.14" )
        {if (expression.isNotEmpty && !(lastindex == "+" ||
          lastindex == "-" ||
          lastindex == "*" ||
          lastindex == "/" ||
          lastindex == "%"||lastindex=="("))a="";
          else if(lastindex==")") a="*$a";}
      if (lastindex == ")" && num.tryParse(a) != null) a = "*" + a;
      if ((expression.isEmpty||lastindex=="(") &&
          (a == "+" || a == "-" || a == "*" || a == "/" || a == "%")) a = "";
      if(lastindex=="."&&(a == "+" || a == "-" || a == "*" || a == "/" || a == "%"))
        a="0"+a;
      setState(() {
        expression += a;
      });
    }
  }
  void answer()
  {
    dynamic p;
    try{
      p=expression.interpret().toString();

    }
    finally{
      setState(() {
        expression = p;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.fromLTRB(20, 100, 10, 10),
              color: Colors.cyan,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  "$expression",
                  style: TextStyle(fontSize: 30),
                  softWrap: true,
                ),
              ),
            ),
            Container(
              color: Colors.cyan,
              child: Row(children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 5),
                  child: IconButton(
                    icon: Icon(Icons.backspace,size: 35,),
                    onPressed: () => textEditor("B"),
                  ),
                ),
              ]),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("C", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("C")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                    child: Center(
                        child: Text("()", style: TextStyle(fontSize: 30))),
                    onPressed: () => textEditor("()"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                    child: Center(
                        child: Text("%", style: TextStyle(fontSize: 30))),
                    onPressed: () => textEditor("%"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                    child: Center(
                        child: Text("+", style: TextStyle(fontSize: 30))),
                    onPressed: () => textEditor("+"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("7", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("7")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                    child: Center(
                        child: Text("8", style: TextStyle(fontSize: 30))),
                    onPressed: () => textEditor("8"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("9", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("9")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                    child: Center(
                        child: Text("/", style: TextStyle(fontSize: 30))),
                    onPressed: () => textEditor("/"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("4", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("4")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("5", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("5")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("6", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("6")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("*", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("*")),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("1", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("1")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("2", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("2")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                          fixedSize: MaterialStateProperty.all(Size(100, 100))),
                      child: Center(
                          child: Text("3", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("3")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("-", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("-")),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("pi", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("3.14")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("0", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor("0")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text(".", style: TextStyle(fontSize: 30))),
                      onPressed: () => textEditor(".")),
                ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                      child: Center(
                          child: Text("=", style: TextStyle(fontSize: 30))),
                      onPressed: answer),
                ),
              ],
            ),
          ],
        ));
  }
}
