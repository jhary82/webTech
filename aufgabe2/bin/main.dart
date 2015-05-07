/**
 * @author: Simon Krause
 * 
 */

import 'dart:html';


void main() {
  InputElement input = querySelector("input");
  Element table = querySelector("#table");  
  Element errors = querySelector("#errors");
  
  input.onInput.listen( (e) {
    try{
      if(!input.value.isEmpty){
        int value = int.parse(input.value);
        if(value < 0){
         errors.innerHtml = "Bitte geben Sie eine positive ganze Zahl >0 ein!";
         table.innerHtml = "";
        }
        else if( value > 100000){
         errors.innerHtml = "Wir berechnen nur Primzahlen bis 100000!";
         table.innerHtml = calculate(100000);
        }
        else{
         errors.innerHtml = "";
         table.innerHtml = calculate(value);
       }
      }
      else{
        errors.innerHtml = "";
        table.innerHtml = "<p>Und hier könnten Ihre Primzahlen stehen...</p>";  
      }
    }catch(Exception){
      errors.innerHtml = "Bitte geben Sie eine positive ganze Zahl > 0 ein!";
      table.innerHtml = "";      
     };
  });
   
}

/**
 * alle Zahlen
 */
List<int> list = <int>[];
/**
 * Primzahlen
 */
List<int> prims = <int>[];

String calculate(int maxValue){
    //Abbruch 
   if(maxValue <= 1) {
     return "";
   }
   //lösche alte Daten
    list.clear();
    prims.clear();
   // erzeuge alle Zahlen
   for(int i = 2; i <= maxValue; i++){
      list.add(i);
   } 
   while(list.length > 0){
          prims.add(list.first);
          int num = prims.last;
          list.removeWhere((e)=>e % num == 0);      
    }
   //erzeuge TableString   
   String str ="";
   prims.forEach( (e) => str += "<div>"+"  "+e.toString()+"</div>");  
   
   return str;
 }
