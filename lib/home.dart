import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  String etanolLabel = "";
  String gasolinaLabel = "";
  String _textoResultado = "";
  void _calcular() {
    FocusScope.of(context).unfocus();

    if (_controllerAlcool.text.isEmpty || _controllerGasolina.text.isEmpty) {
      setState(() {
        _textoResultado = 'Por Favor insiria algum valor!';
      });
    } else {
      setState(() {
        etanolLabel = _controllerAlcool.text;
        gasolinaLabel = _controllerGasolina.text;
      });
      String alcool =
          _controllerAlcool.text.replaceAll('BRL', '').substring(1).toString();
      String gasolina = _controllerGasolina.text
          .replaceAll('BRL', '')
          .substring(1)
          .toString();

      double precoAlcool = double.tryParse(alcool.replaceAll(',', '.'));
      double precoGasolina = double.tryParse(gasolina.replaceAll(',', '.'));

      if (precoAlcool == null || precoGasolina == null) {
        setState(() {
          _textoResultado =
              "Valor inválido, digite números maiores que 0 e utilizando (.)";
        });
      } else {
        setState(() {
          _textoResultado = "Número válido";
        });

        if ((precoAlcool / precoGasolina) >= 0.7) {
          setState(() {
            _textoResultado = "Abasteça com\nGasolina!";
          });
        } else {
          setState(() {
            _textoResultado = "Abasteça com\nEtanol!";
          });
        }
        _limpar();
      }
    }
  }

  void _limpar() {
    _controllerGasolina.text = "";
    _controllerAlcool.text = "";
  }

  var maskMoeda = CurrencyTextInputFormatter(locale: 'pt-BR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Etanol ou Gasolina"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _textoResultado = "";
                  etanolLabel = "";
                  gasolinaLabel = "";
                });
              },
              icon: Icon(Icons.sync))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Digite po preço por Litro",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                inputFormatters: [maskMoeda],
                cursorColor: Colors.green,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 2),
                  ),
                  labelText: "Etanol",
                ),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                ),
                controller: _controllerAlcool,
              ),
              const SizedBox(height: 30),
              TextField(
                cursorColor: Colors.green,
                keyboardType: TextInputType.number,
                inputFormatters: [maskMoeda],
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 2),
                  ),
                  labelText: "Gasolina",
                ),
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                ),
                controller: _controllerGasolina,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _calcular),
              ),
              const SizedBox(
                height: 50,
              ),
              _textoResultado.isEmpty
                  ? Container()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        'gasolina',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    gasolinaLabel,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        'etanol',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    etanolLabel,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.teal, Colors.greenAccent],
                              )),
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_gas_station,
                                color: Colors.white,
                                size: 58,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _textoResultado,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
