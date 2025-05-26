import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details({Key? key, required this.productName, required this.productDescription})
      : super(key: key);

  final String productName, productDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("detalles"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Producto dinámico dentro de una Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: IconButton(
                  icon: const Icon(Icons.bookmark_added_rounded, color: Colors.blueAccent),
                  onPressed: () {},
                ),
                title: Text(
                  productName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                subtitle: Text(
                  productDescription,
                  style: const TextStyle(fontSize: 14.0),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    // Lógica de eliminación de producto
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
