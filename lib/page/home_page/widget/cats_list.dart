// import 'package:flutter/material.dart';
// import 'package:public_api/public_api.dart';

// import 'package:test_3_35_7/page/cat_detail_page.dart';

// class CatsList extends StatelessWidget {
//   const CatsList({
//     super.key,
//     required this.cats,
//     required this.controller,
//     this.hasReachedMax = false,
//   });
//   final ScrollController controller;
//   final bool hasReachedMax;

//   final List<CatModel> cats;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       controller: controller,
//       itemCount: hasReachedMax ? cats.length : cats.length + 1,
//       itemBuilder: (context, index) {
//         if (index >= cats.length) {
//           return const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }
//         final catModel = cats[index];
//         final breed = catModel.breed;
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     CatDetailPage(title: breed.name, catModel: catModel),
//               ),
//             );
//           },
//           child: Card(
//             margin: const EdgeInsets.all(8.0),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.network(
//                     catModel.url,
//                     width: double.infinity,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 8),

//                   Text(
//                     breed.name,
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   const SizedBox(height: 4),
//                   Text("Origin: ${breed.origin}"),
//                   const SizedBox(height: 4),
//                   Text("Life Span: ${breed.lifeSpan} years"),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
