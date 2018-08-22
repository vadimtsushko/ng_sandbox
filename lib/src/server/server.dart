// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Replies "Hello, world!" to all requests.
// Use the URL localhost:4040 in your browser.
import 'dart:io';
import 'dart:async';



class Server{

  HttpRequest request;

  void listen() async {

    var server = await HttpServer.bind(
      InternetAddress.LOOPBACK_IP_V4,
      4040,
    );

    await for (var request in server) {

      this.request = request;
      request.response.headers.add('Access-Control-Allow-Origin', '*');
      tasks();
    }
  }

  void writeln(String str){
    this.request.response.writeln(str);
  }
  void close(){
    this.request.response.close();
  }

  Server(){
    listen();

  }

  tasks(){
    final part = request.uri.queryParameters['part'];

    if(part == null) {
      writeln('need id parts');
    } else {
      File targetFile = File('lib/src/server/parts/${part}.txt');
      writeln(targetFile.readAsStringSync());
    }
    close();
  }
}

Future main() async {

  Server();

}