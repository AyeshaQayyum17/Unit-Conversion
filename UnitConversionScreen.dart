import 'package:flutter/material.dart';

class UnitConversionScreen extends StatefulWidget {
  const UnitConversionScreen({super.key});

  @override
  _UnitConversionScreenState createState() => _UnitConversionScreenState();
}

class _UnitConversionScreenState extends State<UnitConversionScreen> {
  String? _unitType;
  String? _fromUnit;
  String? _toUnit;
  double? _value;
  double? _convertedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text('Unit Conversion App')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                value: _unitType,
                onChanged: (value) {
                  setState(() {
                    _unitType = value as String?;
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text('Length'),
                    value: 'length',
                  ),
                  DropdownMenuItem(
                    child: Text('Weight'),
                    value: 'weight',
                  ),
                  DropdownMenuItem(
                    child: Text('Temperature'),
                    value: 'temperature',
                  ),
                ],
              ),
              DropdownButtonFormField(
                value: _fromUnit,
                onChanged: (value) {
                  setState(() {
                    _fromUnit = value as String?;
                  });
                },
                items: _getFromUnitItems(),
              ),
              DropdownButtonFormField(
                value: _toUnit,
                onChanged: (value) {
                  setState(() {
                    _toUnit = value as String?;
                  });
                },
                items: _getToUnitItems(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Value',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) => _value = double.parse(value!),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _convertedValue = _convertValue();
                    setState(() {});
                  }
                },
                child: Text('Convert'),
              ),
              Text(
                _convertedValue != null
                    ? 'Converted value: ${_convertedValue!.toStringAsFixed(2)}'
                    : '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getFromUnitItems() {
    switch (_unitType) {
      case 'length':
        return [

          DropdownMenuItem(

            child: Text('Meters'),
            value: 'meters',
          ),
          DropdownMenuItem(
            child: Text('Feet'),
            value: 'feet',
          ),
          DropdownMenuItem(
            child: Text('Inches'),
            value: 'inches',
          ),
        ];
      case 'weight':
        return [
          DropdownMenuItem(
            child: Text('Kilograms'),
            value: 'kilograms',
          ),
          DropdownMenuItem(
            child: Text('Pounds'),
            value: 'pounds',
          ),
          DropdownMenuItem(
            child: Text('Ounces'),
            value: 'ounces',
          ),
        ];
      case 'temperature':
        return [
          DropdownMenuItem(
            child: Text('Celsius'),
            value: 'celsius',
          ),
          DropdownMenuItem(
            child: Text('Fahrenheit'),
            value: 'fahrenheit',
          ),
        ];
      default:
        return [];
    }
  }

  List<DropdownMenuItem<String>> _getToUnitItems() {
    switch (_unitType) {
      case 'length':
        return [
          DropdownMenuItem(
            child: Text('Feet'),
            value: 'feet',
          ),
          DropdownMenuItem(
            child: Text('Inches'),
            value: 'inches',
          ),
          DropdownMenuItem(
            child: Text('Meters'),
            value: 'eters',
          ),
        ];
      case 'weight':
        return [
          DropdownMenuItem(
            child: Text('Pounds'),
            value: 'pounds',
          ),
          DropdownMenuItem(
            child: Text('Ounces'),
            value: 'ounces',
          ),
          DropdownMenuItem(
            child: Text('Kilograms'),
            value: 'kilograms',
          ),
        ];
      case 'temperature':
        return [
          DropdownMenuItem(
            child: Text('Fahrenheit'),
            value: 'fahrenheit',
          ),
          DropdownMenuItem(
            child: Text('Celsius'),
            value: 'celsius',
          ),
        ];
      default:
        return [];
    }
  }

  double? _convertValue() {
    switch (_unitType) {
      case 'length':
        switch (_fromUnit) {
          case 'eters':
            switch (_toUnit) {
              case 'feet':
                return _value! * 3.28084;
              case 'inches':
                return _value! * 39.3701;
              default:
                return _value;
            }
          case 'feet':
            switch (_toUnit) {
              case 'eters':
                return _value! / 3.28084;
              case 'inches':
                return _value! * 12;
              default:
                return _value;
            }
          case 'inches':
            switch (_toUnit) {
              case 'eters':
                return _value! / 39.3701;
              case 'feet':
                return _value! / 12;
              default:
                return _value;
            }
          default:
            return null;
        }
      case 'weight':
        switch (_fromUnit) {
          case 'kilograms':
            switch (_toUnit) {
              case 'pounds':
                return _value! * 2.20462;
              case 'ounces':
                return _value! * 35.274;
              default:
                return _value;
            }
          case 'pounds':
            switch (_toUnit) {
              case 'kilograms':
                return _value! / 2.20462;
              case 'ounces':
                return _value! * 16;
              default:
                return _value;
            }
          case 'ounces':
            switch (_toUnit) {
              case 'kilograms':
                return _value! / 35.274;
              case 'pounds':
                return _value! / 16;
              default:
                return _value;
            }
          default:
            return null;
        }
      case 'temperature':
        switch (_fromUnit) {
          case 'celsius':
            switch (_toUnit) {
              case 'fahrenheit':
                return _value! * 9 / 5 + 32;
              default:
                return _value;
            }
          case 'fahrenheit':
            switch (_toUnit) {
              case 'celsius':
                return (_value! - 32) * 5 / 9;
              default:
                return _value;
            }
          default:
            return null;
        }
      default:
        return null;
    }
  }
}