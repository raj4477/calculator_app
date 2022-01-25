import 'package:flutter/material.dart';

class model {
  final String name;
  model({this.name});
}

List<model> Items = [
  /// List of items to be searched
  model(name: "Name"),
  model(name: "XYZ"),
  model(name: "Demo"),
  model(name: "GDSC"),
  model(name: "Unknown"),
  model(name: "Upper Moons"),
  model(name: "Tanjiro"),
  model(name: "Kivan"),
  model(name: "India"),
  model(name: "USA"),
];

List<model> filteredItem = [];   /// List of item to be filtered after searching

  //  void main() {
  //   runApp(SearchBoxPage());
  // }

class SearchBoxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Search Box",
      home: HomePages(),
    );
  }
}

String searchText = "";
bool found = true;

class HomePages extends StatefulWidget {
  // const HomePages({ }) ;

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final textController = new TextEditingController();
  _HomePagesState();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItem = Items;
    textController.addListener(() {
      if (textController.text.isEmpty) {
        setState(() {
          searchText = "";
          found = true;
          filteredItem = Items;
        });
      } else {
        setState(() {
          searchText = textController.text;
        });
        searchFunc();

        /// Function for checking the items in List
      }
    });
  }

  void searchFunc() {
    List<model> tempList = [];
    if (!searchText.isEmpty) {
      for (int i = 0; i < Items.length; i++) {
        if (Items[i].name.toLowerCase().contains(searchText.toLowerCase())) {
          tempList.add(Items[i]);
        }
      }
      setState(() {
        found = true;
        filteredItem = tempList;
      });
    }
    if (filteredItem.isEmpty) {
      setState(() {
        found = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // color: Colors.amber,
                width: size.width,
                height: size.height * 0.1,
                alignment: Alignment.center,
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.black,),
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(width: 2)),
                  ),
                ),
              ),
            ),
            // Container(
            //   height: size.height * 0.1,
            //   width: size.width * 0.8,
            //   color: Colors.blueAccent,
            //   alignment: Alignment.center,
            //   child: Text(searchText),
            // ),
            Expanded(
              // height: size.height * 0.72,
              // width: size.width,
              child: found
                  ? ListView.builder(
                      itemCount: filteredItem.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          width: size.width * 0.9,
                          height: size.height * 0.0888,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Color(0xff9379FF),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Text(
                              filteredItem[index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      })
                  : Container(
                      height: size.height * 0.72,
                      width: size.width,
                      alignment: Alignment.center,
                      child: Text("Not Available",style: TextStyle(color: Colors.black,fontSize: 23),),
                    ),
            )
          ],
        ),
      ),
    );
  }
}


// onChanged: (value) {
//   if (!searchText.isEmpty) {
//     for (var item in filteredItem) {
//       if (item.name.toLowerCase().contains(value)) {
//         tempList.add(model(name: item.name));
//       }
//     }
//     setState(() {
//       filteredItem.clear();
//       print(filteredItem.length);
//       filteredItem = tempList;
//       print(filteredItem.length);
//     });
//   }
// },