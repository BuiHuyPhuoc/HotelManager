import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: " + fCMToken!);
  }

  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "hotelmanager-2b353",
      "private_key_id": "cd37bb3f67512f4e075a51e2d56a704260cc665b",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC4YfpcfN1jz/BH\nyDu9zEl6yTPYfukXEwwjmUK+DkWFZV3QOChwQxaof8ZJNJO5aw+OuFp4cpBduf2/\nueHcNJa9Z+6x2ezzJE5kPShvobuMH/VXhU2n2N1e5hLix0jHonAS0Pr6xl4kYlDD\nL4syEa+z0jAb3RDX3oB/99h3Un6TvBUVv/fLlE+M1G1TJTBpKsmJI77iblPbVR6Q\nskIOm41db/ndjc1dolCKuDjfeg5wYh2FkN5v01mSsH5rR1aLBQD9z8zUhvRdZTEw\n0kDJeAt40xXdsx9YpXez41smq7Nl8BTQgeO0T7I05MCTmX5KlWnJX9XB3o2KSzPr\nDfJV6q7HAgMBAAECggEAWeLB14azsu3y+DuADEXj6GzfzoIIBcyuVUhoxhhVAfPp\nqRFHfXrnN9uagaOVBIZRvkTXLfLDuD1sm6P1nJEyj0F0ltVjcyDW6nz6Enmo4WXP\nCAyfT90kBhhpSo7WRyREOJgSUmCUEm6vaofp9s2ydxpXg63ggSwiPsBHkdvwgvoQ\nlGX4CG3PweIiG7wXkxfvvlb0H6VxwZeI5Et88iLZWKGvSncskBHEU7QbHynfIt4O\n5BwUk54E1R8l566pkzam55nxzLTX7Ya1cv0ftxTBE+MEnmeu8HoVaUZZP884rTEZ\niPVgC0H9vWKn3GhmIVFZr2ePz0fU7QadFpUp1v67QQKBgQDntht16WQkSvEVDVJc\np1bNg8jgJDJqmkt8BuFsxiSFx6x73T+aAFvkuR1/M0/lefpYoGqMYCzpcFgOkL77\nP0KCxJwz0T/2mkC0nttyCSJY0sZpnSO/tt4SDjBz9wkVhHzmHWC0pVmcC5dtznhz\nDCtt/rhgtPDemMPDRILQQbTXJwKBgQDLtdLVcAHm2McFDZzDNZOSM7ovsPnyYVvb\nq7b5V/KAp3ShkZTPFzFYKu1i7JJGiizgj9aEEDCz6b5PoronZ/6zN8bH9FQOFNHR\nrR1iKypOs0D32WrRCRA1wpQrfmGGbImSgZ6TXYCOJkk8Hg+MODlrCvqKOLSAqbC0\nc/sbsxMvYQKBgHMqGtnvB1vWd55sAZyVe1on/uYQd5JuX8gkL1R94tcvF/Z0T9E+\nDm5O5286VKKMjrYP/QUKJCheMxYCMTn1BhyylaRXg0ARCMn9DrrN+WlGUWFavdLi\nk9tLfB+XD8fHEsDYpyEB8djSFhB4h3s++DLyYDeIlxM7wEjEO3RAxB4PAoGBAKWq\nE3Cya0mCB7ArVs5GFuHyITtBsLMVzC9EYUQ76qIIDMiMbTlRQjbSikVF4Ntu6Xoi\nX7D8va7Cq5t12e/MGg1Dkevw3h6pfc0H/Ppl4j0od/BYJw8iUMV3nSoV2FgKkoLL\n2Ns9UhvINQyn4bsFymQsBH4+CUUNOwA1xgPLyRFhAoGBAORgEmes9yqlqx9o4gaE\nWbfUMeOKrkqs4nTumddIdDtke/4mGl18+B+AFk/DhQFAbHCb1Yt7ILAh+ao4p4YM\n3b/Io7QL2yDTZV5PYSPVjkp+3kC08OTFraIjyv1YmUMrrS2MMmAObeGpO4P1ZPNB\n0jZPDTrGdUDRS3ZbzddAIlzZ\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-hfuyz@hotelmanager-2b353.iam.gserviceaccount.com",
      "client_id": "102505058314529116676",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-hfuyz%40hotelmanager-2b353.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Obtain the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver(
      {required String receiveToken,
      required String title,
      required String body}) async {
    final String serverKey = await getAccessToken(); // Your FCM server key
    final String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/hotelmanager-2b353/messages:send';
    final currentFCMToken = receiveToken;
    final Map<String, dynamic> message = {
      'message': {
        'token': currentFCMToken,
        'notification': {'title': title, 'body': body},
        'data': {
          'current_user_fcm_token': currentFCMToken,
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }
}
