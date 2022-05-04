import 'package:flutter/material.dart';

//Color(0xFF21BFBD),
Color primaryColor = Color(0xFF21BFBD);
Color REDcolor = Color(0xFFC72C2C);
Color SecondryColor = Color(0xfff6f6f6);
Color fb_btnColor = Color(0xff3b5998);
Color text_Color = Color(0xff808080);
const errorColor = Colors.red;
const greyColor = Colors.grey;
Color white_Color = Color(0xffFFFFFF);
Color interchatbg_color = Color(0xfffcdbd0);
//Colors.grey[400]

const String imgpath = 'assets/images';
//height
sizeheight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//width
sizeWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

List from = [
  "Clifton - Shahrah e Faisal",
  "Safoora - Gulistan e Jauhar",
  "Buffer Zone - North Nazimabad",
  "Clifton - Dow - IBA City Campus Bahadurabad",
  "Habib University - Gulistan e Jauhar",
  "Gulshan e Hadeed Phase 2 - Malir"
];

List to = [
  "Malir Cantt",
  "Shahrah e Faisal - MT Khan Road",
  "Shahrah e Faisal - DHA",
  "University Road - Gulistan e Jauhar",
  "DHA - Gizri",
  "Shahrah e Faisal - DHA - Gizri"
];

List pickup1 = [
  "Outside Sky Tower - Clifton",
  "Outside Dolmen Mall Clifton -- 2",
  "Abdullah Shah Ghazi Bus Stop_2",
  "Outside SZABIST",
  "Outside Emerald Tower",
  "Opposite PSO House",
  "Opposite Frere Hall",
  "Opposite FTC",
];
List pickup2 = [
  "Opposite Saima PreSidency",
  "Opposite Commander CNG Pump",
  "Outside Dar e Arqam School - Architect Society Jauhar",
  "Outside Habib University Gate 1",
  "Opposite Chae Conference - Pehlwan Goth Road",
  "Outside 3D Wall Paper Shop",
  "Outside PAF Hospital",
  "Outside Karsaz Bus Stop",
  "Outside Karachi Foods",
  "Opposite UBL Bank - PIDC"
];
List pickup3 = [
  "Outside Nagan Chowrangi",
  "Outside Erum Shopping Center - Buffer Zone",
  "Outside Serena Mobile Market",
  "Outside Golden Garden (Nazimabad)",
  "Opposite Faiz House",
  "Opposite Ginsoy (North Nazimabad Branch)",
  "Outside Hyderi Bus Stop",
  "Outside Pizza Hut Nazimabad",
  "Outside Imtiaz Supermarket - Nazimabad",
  "Outside Anwar Tyre Shop",
  "Opposite Essa Nagri Bus Stop (Gulshan)"
];
List pickup4 = [
  "Outside Dolmen Mall (Clifton)",
  "Outside IVS",
  "Outside Ziauddin Hospital Clifton",
  "Outside UBL Boat Basin (14 Seater)",
  "Outside SZABIST",
  "Outside Emerald Tower",
  "Outside HBL Tower",
  "Outside State Life Building",
  "Opposite Movenpick",
  "Opposite Saima Trade Tower",
  "Opposite Dow Medical College - Mission Road",
  "Outside Bahadurabad Market",
  "Opposite Urdu University BUs Road",
  "Outside Sir Syed University"
];
List pickup5 = [
  "Outside Habib University Gate 1",
  "Outside Arabian Food Stall",
  "Opposite Faculty of Pharmacy (Karachi University)",
  "Opposite Maskan Gate Karachi University",
  "Opposite UIT",
  "Nipa Chowrangi",
  "Opposite Sir Syed University",
  "Urdu University Stop",
  "Outside Bait ul Mukarram",
  "Outside PSO Pump - Time Medico",
  "Opposite Agha Khan University Hospital",
  "Outside FWBL Bank",
  "Outside Babies World",
  "Opposite Sunset Club"
];

List dropoff1 = [
  "Outside Emerald Tower",
  "Opposite PSO House",
  "Opposite Frere Hall",
  "Opposite Mehran Hotel_2",
  "Opposite Regent Plaza",
  "Opposite Bank Al Habib Building",
  "Outside Al Tijarah_2",
  "Opposite Awami Markaz Bus Stop",
];
List dropoff2 = [
  "Outside PAF Hospital",
  "Outside Karsaz Bus Stop",
  "Outside Awami Markaz Bus Stop",
  "Opposite House of Habib - Shahrah e Faisal",
  "Outside Karachi Foods",
  "Opposite PSO Petrol Pump - Shahrah e Faisal",
  "Outside Aisha Bawani College",
  "Outside Mehran Hotel",
  "Opposite UBL Bank - PIDC",
  "Outside Khalid Autos (MT Khan Road)",
  "Outside Bahria Complex"
];
List dropoff3 = [
  "Outside TRG Tower",
  "Outside National Medical Center",
  "Outside Suzuki Defence Motors",
  "Opposite Axact IT Company",
  "Outside Suffa University Gate (DHA phase 7)",
  "Outside PSO Petrol Pump Khayaban e Ittehad",
  "Outside Master Juice - Bukhari Commercial",
  "Opposite Chunkey Monkey"
];
List dropoff4 = [
  "Opposite Seven Day Hospital (M A Jinnah)",
  "Outside Islamia Science College (Jamshed Road)",
  "Outside Bahadurabad Market",
  "Opposite Urdu University Bus Stop",
  "Outside Sir Syed University",
  "Outside UIT (Usman Institute of technology)",
  "Outside Faculty of Pharmacy (Karachi University)",
  "Opposite Al Jadeed Super Market",
  "Outside Kamran Chowrangi Bus Stop",
  "Outside Askari Bank (Jauhar Road)"
];
List dropoff5 = [
  "Opposite Iqra University (Main Campus Qayyumabad)",
  "Outside Centre Point",
  "Outside Viral Edge (DHA Phase 2 Ext)",
  "Outside Hobnob - Khayaban e Jami",
  "Opposite Sunset Club",
  "Opposite DHACSS Phase 4 Campus (Commercial Avenue)",
  "Outside Shell Petrol Pump Gizri Road"
];
