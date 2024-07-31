import 'package:first_projecti/model/todo.dart';
import 'package:first_projecti/todo-item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seed: 0, surface: Colors.deepPurple),
        // Assuming you meant to use Material3 style
        // useMaterial3: true,
      ),
      home: MyHomePage(title: 'TODO APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ToDo> todoslist = ToDo.todoList(); // Initialize todoslist here
  final todoController=TextEditingController();
  List<ToDo> foundToDo=[];

  TextEditingController textEditingController = TextEditingController();

  void initState(){
    foundToDo=todoslist;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage("assets/images/b.png"),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 50),
                        child: Text(
                          "All ToDos",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todo in foundToDo.reversed   ) ToDoItem(todo: todo,onTodoChange:handleTo,onDelete:
                      ondeleteID,)
                      ,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    // Add your widgets here if needed
                    child: TextField(
                      controller:todoController ,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a new todo item",
                      ),
                    ),),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20,right: 20),
                  child: ElevatedButton(
                    onPressed: (){
                      addNew(todoController.text);
                    },
                    child: Text('+',style: TextStyle(
                        fontSize: 40,color: Colors.white
                    ),),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(60,60),
                        elevation: 10,
                        backgroundColor: Colors.blue
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleTo(ToDo todo){
    setState(() {
      todo.isDone=!todo.isDone;
    });



  }
  void ondeleteID(String id){
    setState(() {
      todoslist.removeWhere((item) => item.id==id);
    });
  }

  void addNew(String toDo){
    setState(() {
      todoslist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo) ) ;
    });
    todoController.clear();

  }

  void runFilter(String word){
    List<ToDo> results=[];
    if (word.isEmpty) {
      results = todoslist; // Show all todos when search bar is empty
    } else {
      results = todoslist
          .where((item) =>
          item.todoText!.toLowerCase().contains(word.toLowerCase()))
          .toList();
    }

    setState(() {
      foundToDo = results; // Update foundToDo with the filtered or unfiltered list
    });
  }


  Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}