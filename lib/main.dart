import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraHome(),
    );
  }
}

class CalculadoraHome extends StatefulWidget {
  @override
  _CalculadoraHomeState createState() => _CalculadoraHomeState();
}

class _CalculadoraHomeState extends State<CalculadoraHome> {
  String _output = "";               // Resultado o entrada que se muestra en la pantalla
  String _operationDisplay = "";     // Mostrar la operación completa en la pantalla
  double _num1 = 0;                  // Primer número
  double _num2 = 0;                  // Segundo número
  String _operation = "";            // Operación actual
  bool _isResultDisplayed = false;   // Si el resultado ya está en pantalla

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Reiniciar la calculadora
        _output = "";
        _operationDisplay = "";  // Limpiar la operación completa
        _num1 = 0;
        _num2 = 0;
        _operation = "";
        _isResultDisplayed = false;
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        // Si ya hay un resultado en pantalla, empieza con el nuevo número
        if (_isResultDisplayed) {
          _operationDisplay = _output + " ";  // Muestra el resultado anterior como primer número
          _isResultDisplayed = false;
        }
        // Guardar el primer número y la operación
        if (_output.isNotEmpty) {
          _num1 = double.parse(_output); // Almacenar el número actual ingresado
          _operation = buttonText; // Almacenar la operación seleccionada
          // Reemplazar '*' y '/' por '×' y '÷' para mostrar
          String operationSymbol = buttonText == "*" ? "×" : buttonText == "/" ? "÷" : buttonText;
          _operationDisplay += _output + " " + operationSymbol + " "; // Actualizar la pantalla con la operación completa
          _output = ""; // Limpiar la entrada actual para el próximo número
        }
      } else if (buttonText == "=") {
        // Al presionar igual, ejecutar la operación
        if (_output.isNotEmpty) {
          _num2 = double.parse(_output); // Guardar el segundo número
          _operationDisplay += _output + " = "; // Mostrar la operación completa

          // Realizar la operación adecuada
          if (_operation == "+") {
            _output = (_num1 + _num2).toString();
          }
          if (_operation == "-") {
            _output = (_num1 - _num2).toString();
          }
          if (_operation == "*") {
            _output = (_num1 * _num2).toString();
          }
          if (_operation == "/") {
            if (_num2 != 0) {
              _output = (_num1 / _num2).toString();
            } else {
              _output = "Error"; // Manejo de la división por cero
            }
          }

          _operationDisplay = ""; // Borrar la operación de la pantalla
          _isResultDisplayed = true; // Marcar que se mostró el resultado
        }
      } else {
        // Si ya hay un resultado en pantalla, empezar de nuevo
        if (_isResultDisplayed) {
          _output = "";  // Limpiar el resultado previo
          _operationDisplay = "";  // Limpiar la operación previa
          _isResultDisplayed = false;
        }
        // Si se presiona un número, actualizar la entrada actual
        _output = _output + buttonText;
      }
    });
  }

  // Crear botones
  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          // Mostrar la operación completa
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _operationDisplay, // Mostrar la operación completa
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          // Mostrar el resultado o la entrada actual
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output.isEmpty ? "0" : _output, // Mostrar el número actual o el resultado
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          // Crear los botones de la calculadora
          Column(children: [
            Row(children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/")
            ]),
            Row(children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("*")
            ]),
            Row(children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-")
            ]),
            Row(children: [
              buildButton("C"),
              buildButton("0"),
              buildButton("="),
              buildButton("+")
            ]),
          ]),
        ],
      ),
    );
  }
}
