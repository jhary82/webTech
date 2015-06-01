// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:io';
import 'package:html5lib/parser.dart';
import 'package:html5lib/dom.dart';
import 'package:http/http.dart' as http;


main() async{
  String url = "", urlHtml = "";
    bool valid = false; 
    print("Bitte geben Sie die URL ein, die sie auf ihre Zeichenhäufigkeiten untersuchen möchten:");  
    
    do {
      //url = "http://elpais.com/";
      url = stdin.readLineSync();
      
     
      //Überprüfen der URL
      await http.get(url).then( (e) {      
        //Abfrage, ob url-type html ist
        if( e.headers["content-type"].contains("html") ){
          valid = true;
          urlHtml = e.body;
        }
        else{
          valid = false;
          print("URL $url scheint kein HTML-Dokument zu sein. (Content type: "+ e.headers["content-type"]+").");
        }
      }).catchError( (e) {
        //falsche url    
        valid = false;        
        print("URL '$url' konnte nicht verarbeitet werden.");
      });    
    }while( !valid );
        
     //Auslesen des Dom-trees    
      var document = parse(urlHtml);         
      
      String str = "";
      int maxLength = 0;//Anzahl aller Zeichen
            
      str += document.body.text;
      
      //Filtere Script Elemente aus
      List<Element> skripte = document.body.querySelectorAll("script");      
      skripte.forEach( (f) => str = str.replaceAll(f.text, ""));
      //Filtere Style Elemente aus
      List<Element> style = document.body.querySelectorAll("style");      
      style.forEach( (f) => str = str.replaceAll(f.text, ""));
                 
      print(str);
      str = str.toLowerCase();// alles kleinschreiben      
      Map<String, int> map = new Map<String, int>();
            
      //filtere alles ausser a-z raus 
      str.splitMapJoin( (new RegExp("[a-z]")),
                onMatch:    (m) {
                  String str = m.group(0);
                  maxLength++;
                  map[str] = 1 + (map.containsKey(str)? map[str] : 0);
                },
                onNonMatch: (n) => '');    
      
      //sortiere die map und gebe aus       
      var sortList = map.keys.toList()..sort((a,b)=> map[b] - map[a]);
      sortList.forEach( (e) {        
        print( e.toString() + ": "+map[e].toString()+" (${(map[e] / maxLength * 100).toStringAsFixed(2)})%");
      });
      
          
}
