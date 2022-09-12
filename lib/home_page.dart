import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum calidadServicio { Amazing, Good, Ok }

class _HomePageState extends State<HomePage> {
  calidadServicio? seleccion;
  bool redondeo = false;
  double total = 0.0;
  var entrada = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(
              Icons.room_service,
              color: Colors.green,
            ),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: entrada,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    labelText: "Cost of service",
                    labelStyle: TextStyle(color: Colors.green)),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.dinner_dining,
              color: Colors.green,
            ),
            title: Text("How was the service?"),
          ),
          opcion(calidadServicio.Amazing, "Amazing (20%)"),
          opcion(calidadServicio.Good, "Good (18%)"),
          opcion(calidadServicio.Ok, "Ok (15%)"),
          ListTile(
            leading: Icon(
              Icons.credit_card,
              color: Colors.green,
            ),
            title: Text("Round up tip"),
            trailing: Switch(
                value: redondeo,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {});
                  redondeo = value;
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              child: Text("CALCULATE"),
              onPressed: () {
                _tipCalculation();
                setState(() {});
              },
              color: Colors.green,
              textColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Tip amount: \$${total.toStringAsFixed(2)}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile opcion(valor, texto) {
    return ListTile(
        title: Text(texto),
        leading: Radio<calidadServicio>(
            value: valor,
            groupValue: seleccion,
            activeColor: Colors.green,
            onChanged: (calidadServicio? value) {
              setState(() {});
              seleccion = value;
            }));
  }

  void _tipCalculation() {
    double costo = 0.0;
    if (entrada.text.isNotEmpty)
      costo = double.parse(entrada.text);
    else
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: Text("Mensaje Informativo"),
              content: Text(
                  "Se debe ingresar una cantidad en el costo del servicio"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Aceptar"))
              ],
            );
          }));

    if (seleccion == calidadServicio.Amazing)
      total = costo * .20;
    else if (seleccion == calidadServicio.Good)
      total = costo * .18;
    else if (seleccion == calidadServicio.Ok) total = costo * .15;

    if (redondeo == true) total = total.ceil().toDouble();
  }
}
