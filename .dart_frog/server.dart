// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/timer.dart' as timer;
import '../routes/tasks.dart' as tasks;
import '../routes/task.dart' as task;
import '../routes/register.dart' as register;
import '../routes/login.dart' as login;
import '../routes/index.dart' as index;


void main() async {
  final address = InternetAddress.tryParse('') ?? InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/timer', (context) => timer.onRequest(context,))..all('/tasks', (context) => tasks.onRequest(context,))..all('/task', (context) => task.onRequest(context,))..all('/register', (context) => register.onRequest(context,))..all('/login', (context) => login.onRequest(context,))..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

