import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as path;
import 'google_auth_client.dart';

//TODO 이거를 토큰 형태로 바꾸면 베스트

@Deprecated("현재 사용하지 않음. 추후에도 사용하지 않으면 삭제 요망")
class GoogleDriveAppData {
  /// sign in with google
  Future<GoogleSignInAccount?> signInGoogle() async {
    GoogleSignInAccount? googleUser;
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          drive.DriveApi.driveFileScope,
        ],
      );

      googleUser =
          await googleSignIn.signInSilently() ?? await googleSignIn.signIn();
    } catch (e) {
      debugPrint(e.toString());
    }
    return googleUser;
  }

  ///sign out from google
  Future<void> signOut() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  ///get google drive client
  Future<drive.DriveApi?> getDriveApi(GoogleSignInAccount googleUser) async {
    drive.DriveApi? driveApi;
    try {
      Map<String, String> headers = await googleUser.authHeaders;
      GoogleAuthClient client = GoogleAuthClient(headers);
      driveApi = drive.DriveApi(client);
    } catch (e) {
      debugPrint(e.toString());
    }
    return driveApi;
  }

  /// upload file to google drive
  Future<drive.File?> uploadDriveFile({
    required drive.DriveApi driveApi,
    required io.File file,
    String? driveFileId,
  }) async {
    try {
      drive.File fileMetadata = drive.File();
      fileMetadata.name = path.basename(file.absolute.path);
      // fileMetadata.parents = "대충 부모 ID"; //TODO 부모 아이디 넣으면 됨.

      late drive.File response;
      if (driveFileId != null) {
        /// [driveFileId] not null means we want to update existing file
        response = await driveApi.files.update(
          fileMetadata,
          driveFileId,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      } else {
        /// [driveFileId] is null means we want to create new file
        fileMetadata.parents = ['appDataFolder'];
        response = await driveApi.files.create(
          fileMetadata,
          uploadMedia: drive.Media(file.openRead(), file.lengthSync()),
        );
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// download file from google drive
  Future<io.File?> restoreDriveFile({
    required drive.DriveApi driveApi,
    required drive.File driveFile,
    required String targetLocalPath,
  }) async {
    try {
      drive.Media media = await driveApi.files.get(driveFile.id!,
          downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

      List<int> dataStore = [];

      await media.stream.forEach((element) {
        dataStore.addAll(element);
      });

      io.File file = io.File(targetLocalPath);
      file.writeAsBytesSync(dataStore);

      return file;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// get drive file info
  Future<drive.File?> getDriveFile(
      drive.DriveApi driveApi, String filename) async {
    try {
      drive.FileList fileList = await driveApi.files.list(
          spaces: 'appDataFolder', $fields: 'files(id, name, modifiedTime)');
      List<drive.File>? files = fileList.files;
      drive.File? driveFile =
          files?.firstWhere((element) => element.name == filename);
      return driveFile;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
