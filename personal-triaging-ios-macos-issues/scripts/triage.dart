// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart triage.dart [command] [args]');
    print('Commands:');
    print('  issues <teamLabel> <additionalLabels>');
    print('  labels');
    return;
  }
  final commandType = args[0];
  if (commandType == 'labels') {
    await getLabels();
    return;
  }
  if (commandType == 'issues') {
    final teamLabel = args[1];
    final additionalLabels = args[2];
    await getIssues(teamLabel, additionalLabels);
    return;
  }
}

Future<void> getIssues(String teamLabel, String additionalLabels) async {
  final ProcessResult result = await Process.run('gh', [
    'issue',
    'list',
    '--repo',
    'flutter/flutter',
    '--search',
    'is:open label:$teamLabel $additionalLabels',
    '--limit',
    '100',
    '--json',
    'number,title,body,author,createdAt,updatedAt,labels,assignees,comments',
  ]);

  if (result.exitCode != 0) {
    stderr.writeln('Error running gh command:');
    stderr.writeln(result.stderr);
    exit(result.exitCode);
  }

  final scriptFile = File(Platform.script.toFilePath());
  final outputFile = File('${scriptFile.parent.parent.path}/temp/$teamLabel.json');
  outputFile.createSync(recursive: true);
  await outputFile.writeAsString(result.stdout as String);
}


Future<void> getLabels() async {
  final ProcessResult result = await Process.run('gh', [
    'label',
    'list',
    '--repo',
    'flutter/flutter',
    '--limit',
    '500',
    '--json',
    'name',
  ]);

  if (result.exitCode != 0) {
    stderr.writeln('Error running gh command:');
    stderr.writeln(result.stderr);
    exit(result.exitCode);
  }

  final scriptFile = File(Platform.script.toFilePath());
  final outputFile = File('${scriptFile.parent.parent.path}/temp/labels.json');
  outputFile.createSync(recursive: true);
  await outputFile.writeAsString(result.stdout as String);
}