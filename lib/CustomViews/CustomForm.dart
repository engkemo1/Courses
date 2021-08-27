import 'package:flutter/material.dart';
import 'package:troom/Util/ConstStyles.dart';

class CustomForm extends StatelessWidget {
  final String hint;
  final IconData icon;
  Function onSave;
   final Function onChange;
  final Function onValidate;
   final TextEditingController myController;
  final String data;
  final TextInputType keybord;
  final int minLin;
  final bool obscureText;
  final bool enabled;
  final double hintSize;

  CustomForm({
    this.onSave,
    this.onChange,
    this.hint,
    this.enabled,
    this.myController,
    this.icon,
    this.onValidate,
    this.data,
    this.keybord,
    this.minLin,
    this.obscureText,
    this.hintSize
  });

  String _errorMsg(String str) {
    switch (str) {
      case 'Enter your Title':
        return 'Title is empty !';
      case 'Enter your Email':
        return 'Email is empty !';
      case 'Enter your Password':
        return 'Password is empty !';
        default:
          return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: myController,
      validator: (v){
        onValidate;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstStyles.WhiteColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstStyles.WhiteColor),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ConstStyles.WhiteColor),
          borderRadius: BorderRadius.circular(10),
        ),
        // fillColor: ConstStyles.WhiteColor,
        filled: true,
/*
        prefixIcon: Icon(
          icon,
          color: ConstStyles.WhiteColor,
        ),
*/
        labelText: hint,
        labelStyle: TextStyle(color: ConstStyles.TextColor,fontWeight: FontWeight.bold,
            fontSize:hintSize == null ? 20 : hintSize),
      ),
      initialValue: data,
      onChanged: (v)=> onChange,
      obscureText: obscureText == null ? false : obscureText,
      onSaved: (s) {
        return onSave(s);
      },
      style: TextStyle( color: ConstStyles.WhiteColor,fontWeight: FontWeight.bold,fontSize: 20),
      keyboardType: keybord == null ? TextInputType.text : keybord,
      maxLines: minLin == null ? 1 : minLin,
    );
  }

}
