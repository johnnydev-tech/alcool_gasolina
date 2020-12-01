import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   TextEditingController _controllerAlcool = TextEditingController();
   TextEditingController _controllerGasolina = TextEditingController();
   String _textoResultado = "";
  void _Calcular(){
   double precoAlcool = double.tryParse(_controllerAlcool.text);
   double precoGasolina = double.tryParse(_controllerGasolina.text);

   if(precoAlcool == null || precoGasolina == null){
      setState(() {
        _textoResultado = "Número inválido, digite números maiores que 0 e utilizando (.)";
      });
   }else{
     setState(() {
       _textoResultado = "Número válido";
     });

     if((precoAlcool / precoGasolina) >= 0.7){
       setState(() {
         _textoResultado =" Melhor abastecer com Gasolina!";
       });
     }else
       {
         setState(() {
           _textoResultado =" Melhor abastecer com Álcool!";
         });
       }
     _limpar();
   }
  }

  void _limpar(){
    _controllerGasolina.text = "";
    _controllerAlcool.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Álcool ou Gasolina"),
        backgroundColor: Colors.blueAccent,
      ) ,
       body: Container(
         child: SingleChildScrollView(
           padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset("images/logo.png"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Saiba qual a melhor opção para bastecimento do seu carro!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextField(
                cursorColor: Colors.lightBlue,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Preço Álcool, ex: 2.99"
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerAlcool ,
              ),
              TextField(
                cursorColor: Colors.lightBlue,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Preço Gasolina, ex: 3.99"
                ),
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: _controllerGasolina,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.lightBlue,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: _Calcular
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text(
                  _textoResultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
         ),

       ),
    );
  }
}
