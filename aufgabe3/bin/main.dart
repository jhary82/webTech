// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'dart:async';

//import 'dart:io';
import 'package:html5lib/parser.dart';// show parse;
import 'package:html5lib/dom.dart';
import 'package:http/http.dart' as http;


main() async {
  String url = "", urlHtml = "";
  bool valid = false;
  int maxBytes = 0;
  print("Bitte geben Sie die URL ein, die sie auf ihre Bildgrößen untersuchen möchten:");  
  
  do {    
    //url = "http://www.nkode.io";//"http://www.education.gov.yk.ca/pdf/pdf-test.pdf";////stdin.readLineSync();
    url = "http://www.nkode.io";
    //Überprüfen der URL
    await http.get(url).then( (e) {      
      //Abfrage, ob url-type html ist
      if( e.headers["content-type"].contains("html") ){
        valid = true;
        urlHtml = e.body;
        maxBytes = e.body.length;
      }
      else{
        valid = false;
        print("URL $url scheint kein HTML-Dokument zu sein. (Content type: "+ e.headers["content-type"]+").");
      }
    }).catchError( (e) {
      //falsche url    
      valid = false;        
      print("sinnlose Eingabe\nURL '$url' konnte nicht verarbeitet werden.");
    });    
  }while( !valid );
   
   //Auslesen des Dom-trees    
    var document = parse(urlHtml);  
    Map<String, int> images = new Map();
    //sortieren
    images.values.toList()..sort();
    
    //ges. Uri
    final uri = Uri.parse(url);
        
    var list = document.querySelectorAll("img[src]");
   
    
    Future.forEach(list, (e)async{
      final imageUri = uri.resolve( e.attributes["src"] );
      final image = await http.get(imageUri);
      images[e] = image.body.length;      
    });
    
    
    
    images.forEach( (s, i)=> print(s+" mit "+i.toString()));
    
}

 
  
  

