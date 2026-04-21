// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart triage.dart [command] [args]');
    print('Commands:');
    print('  prs <platform>');
    print('  labels');
    return;
  }
  final commandType = args[0];
  if (commandType == 'labels') {
    await getLabels();
    return;
  }
  if (commandType == 'prs') {
    final platform = args[1];
    final repo = args[2];
    await getPullRequests(platform, repo);
    return;
  }
}

Future<void> getPullRequests(String platform, String repo) async {
  final ProcessResult result = await Process.run('gh', [
    'pr',
    'list',
    '--repo',
    'flutter/$repo',
    '--search',
    'is:open is:pr label:platform-$platform,team-$platform sort:created-asc -is:draft',
    '--limit',
    '100',
    '--json',
    'number,title,body,author,createdAt,updatedAt,labels,comments,reviews',
  ]);
  if (result.exitCode != 0) {
    stderr.writeln('Error running gh command:');
    stderr.writeln(result.stderr);
    exit(result.exitCode);
  }

  final scriptFile = File(Platform.script.toFilePath());
  final outputFile = File('${scriptFile.parent.parent.path}/temp/prs_${platform}_$repo.json');
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