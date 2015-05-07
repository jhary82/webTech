// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
/*

import 'dart:async';*/

//import 'dart:io';
import 'package:html5lib/parser.dart';// show parse;
import 'package:html5lib/dom.dart';
import 'package:http/http.dart' as http;


main() async {
  String url = "";
  bool valid = false;
  print("Bitte geben Sie die URL ein, die sie auf ihre Bildgrößen untersuchen möchten:");  
  
  do {    
    //url = "http://www.nkode.io";//"http://www.education.gov.yk.ca/pdf/pdf-test.pdf";//"http://www.nkode.io";//stdin.readLineSync();
    url = "http://www.heise.de/newsticker/meldung/Root-Shell-im-Krankenhaus-Hospira-Infusionspumpe-mit-Telnet-Luecke-2633529.html?wt_mc=rss.ho.beitrag.rdf";
    //Überprüfen der URL
    await http.get(url).then( (e) {      
      //Abfrage, ob url-type html ist
      if( e.headers["content-type"].contains("html") ){
        valid = true;
        url = e.body;
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
   /*
   //Auslesen des Dom-trees    
    var document = parse(url);
    List<Element> images = document.querySelectorAll("img");
    
    images.forEach( (e){
      
      images[0].attributes.;
      
    });
    */
    
}

  
  
  

