// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "dart:html";
import 'package:TowerDefense/towerLib.dart';

String targetClass = "Wuff";

void main() {
  querySelector(".tower").onClick.listen( (ev) {
    Element target = ev.target;
    targetClass = target.classes.first;
    target.classes.toggle("marked");
  });
  var all = querySelectorAll(".a");
  all.onClick.listen( (ev) {
    Element target = ev.target;    
    target.classes.add(targetClass);
  });
  
  
  
}
