// import 'package:flutter/material.dart';
// import 'package:public_api/public_api.dart';

// class CatDetailPage extends StatefulWidget {
//   const CatDetailPage({super.key, required this.title, required this.catModel});

//   final String title;
//   // final CatModel catModel;

//   @override
//   State<CatDetailPage> createState() => _CatDetailPageState();
// }

// class _CatDetailPageState extends State<CatDetailPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final catModelModel = widget.catModel;
//     final breed = catModelModel.breed;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,

//               children: [
//                 const SizedBox(height: 8),
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   width: 300,
//                   height: 300,

//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                     image: DecorationImage(
//                       image: NetworkImage(catModelModel.url),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 8),
//                 ListTile(
//                   title: Text(
//                     "Origin :",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   leading: Icon(Icons.location_on),
//                   trailing: Text(
//                     breed.origin,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ListTile(
//                   title: Text(
//                     "lifeSpan :",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   leading: Icon(Icons.timer),
//                   trailing: Text(
//                     breed.lifeSpan,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 ListTile(
//                   title: Text(
//                     "Temperament :",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   leading: Icon(Icons.favorite),
//                 ),
//                 Text(breed.temperament, maxLines: 3, style: TextStyle()),
//                 const SizedBox(height: 8),
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(breed.description),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
