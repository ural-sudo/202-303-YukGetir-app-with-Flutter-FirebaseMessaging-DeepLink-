

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class FireBaseDeepLink {


  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

   void init()async {
    dynamicLinks.onLink;
  }
  
}