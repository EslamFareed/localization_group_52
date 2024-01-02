import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // getDataStream() {
  //   FirebaseFirestore.instance
  //       .collection('products')
  //       .snapshots()
  //       .listen((event) {
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data!.docs[index].data()["name"]),
                subtitle:
                    Text(snapshot.data!.docs[index].data()["price"].toString()),
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        },
      ),
    );
  }
}



// class ProductsScreen extends StatelessWidget {
//   const ProductsScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               var doc =
//                   await FirebaseFirestore.instance.collection('products').add({
//                 "name": "Shoes",
//                 "price": 15.5,
//               });
//               print(doc.id);
//             },
//             child: const Text("Set Data"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               var response =
//                   await FirebaseFirestore.instance.collection('products').get();
//               for (var element in response.docs) {
//                 print(element.id);
//                 print(element.data());
//               }
//             },
//             child: const Text("Get All"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               var data = await FirebaseFirestore.instance
//                   .collection('products')
//                   .doc('3SDJfAtuwJm7JJUYk3x8')
//                   .get();
//               print(data.data());
//             },
//             child: const Text("Get Item"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               var data = await FirebaseFirestore.instance
//                   .collection('products')
//                   .doc('3SDJfAtuwJm7JJUYk3x8')
//                   .update({"name": "Laptop"});
//             },
//             child: const Text("Update Item"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               var data = await FirebaseFirestore.instance
//                   .collection('products')
//                   .doc('3SDJfAtuwJm7JJUYk3x8')
//                   .delete();
//             },
//             child: const Text("Delete Item"),
//           )
//         ],
//       ),
//     );
//   }
// }
