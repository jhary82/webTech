/**
 * @author: Simon Krause
 * 
 */

import 'dart:html';
import 'dart:math' as Math;


void main() {
  InputElement input = querySelector("input");
  Element table = querySelector("#table");  
  Element errors = querySelector("#errors");
  
  input.onInput.listen( (e) {
    try{
      if(!input.value.isEmpty){
        int value = int.parse(input.value);
        if(value < 0){
         errors.innerHtml = "Bitte geben Sie eine positive ganze Zahl > 0 ein!";
         errors.classes.clear();
         table.innerHtml = "";
        }
        else if( value > 100000){
         errors.innerHtml = "Wir berechnen nur Primzahlen bis 100000!";
         errors.classes.clear();
         table.innerHtml = getPrims(100000);
        }
        else{
         errors.innerHtml = "";
         errors.classes.add("notShow");
         table.innerHtml = getPrims(value);
       }
      }
      else{
        errors.innerHtml = "";
        errors.classes.add("notShow");
        table.innerHtml = "Und hier könnten Ihre Primzahlen stehen...";  
      }
    }catch(Exception){
      errors.innerHtml = "Bitte geben Sie eine positive ganze Zahl > 0 ein!";
      errors.classes.clear();
      table.innerHtml = "";      
     };
  });
   
}


  /**
   * Primzahlen
   */
  List<int> prims = <int>[];

  /**
   * 
   */
  List<bool> gestrichen = <bool>[];
  
  
  /**
   * Gibt die Primzahlen bis value in einer Html-Tabelle zurück
   */
  String getPrims(int value){
    if(value <=1){
      return "";
    }
    //lösche alte Listen
    prims.clear();
    gestrichen.clear();
    
    // alle auf false setzen
    for(int i = 0; i <= value; i++){
      gestrichen.add(false);
    }
        
// siebe mit allen (prim) zahlen i 
// wobei i der kleinste Primfaktor einer zusammengesetzten zahl j = i*k ist.
// Der kleinste primfaktor einer zusammengesetzten Zahl j kann nicht größer als die wurzel von j <= n sein.
  for(int i = 2; i <= Math.sqrt(value); i++){
    if( !gestrichen.elementAt(i) ){
      prims.add(i);
      for(int a = i*i; a <= value; a += i){
        gestrichen[a] = true;
      }
    }    
  }
    
// gib die primzahlen größer als wurzel n aus. Also die, die noch nicht gestrichen wurden
  for(int i = Math.sqrt(value).floor() + 1; i <= value; i++){
    if(!gestrichen[i]){
      prims.add(i);
    }
  }
    
    //erzeuge TableString
    var str = "<tr><td>"+prims.first.toString()+"</td>";  
    for(int i = 1; i < prims.length; i++){
       if(i % 13 == 0){
           str += "</tr><td>"+prims[i].toString()+"</td>";
       }
       else{
        str += "<td>"+prims[i].toString()+"</td>";
      }
     }

    return "<table>"+str+"</tr></table>";
  }  
  
  
  
        
