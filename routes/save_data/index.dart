import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:hive/hive.dart';

Future<Response> onRequest(RequestContext context) async {
  Hive.init(Directory.current.path);
  final box = await Hive.openBox<String>('test');

  final data = context.request.url.queryParameters['name'];

  final id = context.request.url.queryParameters['id'];

  if (data == null) {
    return Response(body: 'name not found');
  }

  await box.put(id, data);

  await Hive.close();

  return Response(body: 'saved');
}
