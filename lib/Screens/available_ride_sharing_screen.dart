import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelapp/Utils/constants.dart';

class AvailableRidePage extends StatefulWidget {
  const AvailableRidePage({Key? key}) : super(key: key);

  @override
  _AvailableRidePageState createState() => _AvailableRidePageState();
}

class _AvailableRidePageState extends State<AvailableRidePage> {
  TextEditingController _controller = new TextEditingController();
  late List<dynamic> _locationList;
  List searchresult = [];

  @override
  void initState() {
    super.initState();

    values();
  }

  void values() {
    _locationList = [];

    _locationList.add(" Malir Cantt > M.T Khan Road");
    _locationList.add("Buffer Zone > Clifton");
    _locationList.add("Malir Cantt >Clifton");
    _locationList.add("4k Bus Stop > Clifton");
    _locationList.add("Buffer Zone > M.T Khan Road");
    _locationList.add("Malir Cantt > Clifton");
    _locationList.add("FB Area > M.T Khan Road");
    _locationList.add("North Karachi >Clifton");
    _locationList.add("North Karachi > M.T Khan Road");
    _locationList.add("North Nazimabad > Orangi Town");
    _locationList.add("Paf Kiet Main Campus > City Campus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Rides"),
        backgroundColor: primaryColor,
      ),
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              width: sizeWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  style: new TextStyle(
                    color: Colors.black,
                  ),
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(14, 14.0, 0, 14.0),
                    suffixIcon: new Icon(Icons.search, color: Colors.grey),
                    // prefixIcon: new Icon(Icons.search, color: Colors.grey),
                    hintText: "Select Location",
                    hintStyle: new TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: greyColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: greyColor)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: errorColor)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: errorColor)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                  onChanged: onSearchTextChanged,
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(color: greyColor),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.car_rental, color: primaryColor, size: 30),
                  SizedBox(width: 5.0),
                  Text(
                    "AVAILABLE RIDES",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
            new Flexible(
                child: searchresult.length != 0 || _controller.text.isNotEmpty
                    ? new ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: greyColor),
                        shrinkWrap: true,
                        itemCount: searchresult.length,
                        itemBuilder: (BuildContext context, int index) {
                          String listData = searchresult[index];
                          return InkWell(
                              // onTap: () => Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             IncludeSomeDetailsPage())),
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              listData.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ));
                        },
                      )
                    : new ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: greyColor),
                        shrinkWrap: true,
                        itemCount: _locationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          String listData = _locationList[index];
                          return InkWell(
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             IncludeSomeDetailsPage())),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: new Text(listData.toString(),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchresult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (int i = 0; i < _locationList.length; i++) {
      String data = _locationList[i];
      if (data.toLowerCase().contains(text.toLowerCase())) {
        searchresult.add(data);
      }
      setState(() {});
    }
  }
}
