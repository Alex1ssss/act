import 'package:flutter/material.dart';
import 'package:myapp/details.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // Controladores separados para cada campo
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _stockController = TextEditingController();
  
  bool isSubmitting = false;

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  // Función para mostrar el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2101);

    // Muestra el DatePicker
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && selectedDate != initialDate) {
      // Formato la fecha seleccionada en formato dd/MM/yyyy
      _dateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text("PRODUCTOS"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // ID del producto
            MyTextField(
              myController: _idController,
              fieldName: "ID DEL PRODUCTO",
              myIcon: Icons.numbers,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            
            // Nombre del producto
            MyTextField(
              myController: _nameController,
              fieldName: "NOMBRE DEL PRODUCTO",
              myIcon: Icons.text_fields,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            
            // Fecha de ingreso (con selector de fecha)
            GestureDetector(
              onTap: () => _selectDate(context), // Mostrar el selector de fecha al tocar
              child: MyTextField(
                myController: _dateController,
                fieldName: "FECHA DE INGRESO",
                myIcon: Icons.calendar_today,
                prefixIconColor: Colors.deepPurple.shade300,
                enabled: false, // Deshabilitamos el TextField para evitar escritura manual
              ),
            ),
            const SizedBox(height: 10.0),
            
            // Precio producto
            MyTextField(
              myController: _priceController,
              fieldName: "PRECIO PRODUCTO",
              myIcon: Icons.attach_money,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            
            // Descripción
            MyTextField(
              myController: _descriptionController,
              fieldName: "DESCRIPCION",
              myIcon: Icons.description,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            
            // Categoría del producto
            MyTextField(
              myController: _categoryController,
              fieldName: "CATEGORIA DEL PRODUCTO",
              myIcon: Icons.category,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            
            // Stock
            MyTextField(
              myController: _stockController,
              fieldName: "STOCK",
              myIcon: Icons.storage,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 20.0),
            
            // Botón de envío
            myBtn(context),
          ],
        ),
      ),
    );
  }

  // Función que devuelve el botón de envío y navega a la pantalla Details
  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: isSubmitting
          ? null
          : () {
              // Validación de campos antes de enviar
              if (_idController.text.isEmpty ||
                  _nameController.text.isEmpty ||
                  _dateController.text.isEmpty ||
                  _priceController.text.isEmpty ||
                  _descriptionController.text.isEmpty ||
                  _categoryController.text.isEmpty ||
                  _stockController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, complete todos los campos.')),
                );
                return;
              }

              // Cambiar estado a submitting (enviando)
              setState(() {
                isSubmitting = true;
              });

              // Navegar a la pantalla Details
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Details(
                    productName: _nameController.text,
                    productDescription: _descriptionController.text,
                  );
                }),
              ).then((_) {
                // Restablecer el estado de submitting cuando se termine
                setState(() {
                  isSubmitting = false;
                });
              });
            },
      child: isSubmitting
          ? const CircularProgressIndicator()
          : Text(
              "Submit Form".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
    );
  }
}

// Widget custom para los campos de texto
class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(myIcon, color: prefixIconColor),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade300),
        ),
        labelStyle: const TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}
