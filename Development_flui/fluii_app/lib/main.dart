


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FormularioAbastecimiento(),
  ));      
}


class FormularioAbastecimiento extends StatefulWidget 
{  const FormularioAbastecimiento({super.key});

  @override
  State<FormularioAbastecimiento> createState() => _FormularioAbastecimientoState();

}

class _FormularioAbastecimientoState extends State<FormularioAbastecimiento> 
{
  final TextEditingController _precioVentaController = TextEditingController();
  final TextEditingController _costoActualController = TextEditingController();
  final TextEditingController _stockMinimoController = TextEditingController();
  final TextEditingController _stockDisponibleController = TextEditingController();
  final TextEditingController _unidadesVendidasController = TextEditingController();

String _resultadoIA = "Ingresa tus datos papoi y oprime evaluar";
Color _colorCaja = const Color(0xFF0F5FF4);
bool _loading = false;

Future<void> _evaluarDatos() async {

  if (_precioVentaController.text.isEmpty || 
      _costoActualController.text.isEmpty || 
      _stockMinimoController.text.isEmpty || 
      _stockDisponibleController.text.isEmpty || 
      _unidadesVendidasController.text.isEmpty) {
        return;
      };




      final stockMinimo = double.tryParse(
      _stockMinimoController.text.trim().replaceAll(',', '.')
      );

      final stockDisponible = double.tryParse(
        _stockDisponibleController.text.trim().replaceAll(',', '.')
      );

      final unidadesVendidas = double.tryParse(
        _unidadesVendidasController.text.trim().replaceAll(',', '.')
      );

      final precioVenta = double.tryParse(
        _precioVentaController.text.trim().replaceAll(',', '.')
      );

      final costoActual = double.tryParse(
        _costoActualController.text.trim().replaceAll(',', '.')
      );
      



final url = Uri.parse('http://127.0.0.1:8000/predecir_abastecimiento');



 final respuesta = await http.post(
  url,
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({
    'precio_venta': _precioVentaController.text.trim(),
    'costo_actual': _costoActualController.text.trim(),
    'stock_minimo': _stockMinimoController.text.trim(),
    'stock_disponible': _stockDisponibleController.text.trim(),
    'unidades_vendidas': _unidadesVendidasController.text.trim(),
 })

 );

 try {
  if (respuesta.statusCode == 200) {
    final datos = jsonDecode(respuesta.body);

    setState(() {
      _resultadoIA = datos['resultado'];
      _colorCaja = const Color(0xFF0F5FF4);
    });
}
}
 catch (e) {
  setState(() {
    _resultadoIA = 'Error al conectar con FLUI';
    _colorCaja = const Color(0xFFB71C1C);
  });

}
}
}
