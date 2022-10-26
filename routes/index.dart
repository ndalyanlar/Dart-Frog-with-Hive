import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:hive/hive.dart';

Future<Response> onRequest(RequestContext context) async {
  Hive.init(Directory.current.path);

  final box = await Hive.openBox<String>('test');
  final id = context.request.url.queryParameters['id'];

  final status = box.get(id);
  await Hive.close();

  if (status != null) {
    return Response(body: status);
  }

  return Response(body: 'not found id');
}
