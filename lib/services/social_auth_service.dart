import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class SocialAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // GitHub OAuth credentials - Replace with your own from GitHub Developer Settings
  static const String githubClientId = 'YOUR_GITHUB_CLIENT_ID';
  static const String githubClientSecret = 'YOUR_GITHUB_CLIENT_SECRET';
  static const String githubScopes = 'read:user,user:email';

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      return {
        'email': googleUser.email,
        'displayName': googleUser.displayName,
        'photoUrl': googleUser.photoUrl,
        'id': googleUser.id,
        'accessToken': googleAuth.accessToken,
      };
    } catch (error) {
      print('Google Sign In Error: $error');
      return null;
    }
  }

  Future<Map<String, dynamic>?> signInWithGitHub(BuildContext context) async {
    try {
      final completer = Completer<String>();
      
      final authUrl = Uri.https('github.com', '/login/oauth/authorize', {
        'client_id': githubClientId,
        'scope': githubScopes,
        'state': _generateRandomState(),
      });

      // Show GitHub login in WebView
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('GitHub Login'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(authUrl)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onNavigationRequest: (request) {
                      final uri = Uri.parse(request.url);
                      if (uri.queryParameters.containsKey('code')) {
                        completer.complete(uri.queryParameters['code']);
                        Navigator.of(context).pop();
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                completer.completeError('User cancelled');
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );

      final code = await completer.future;

      // Exchange code for access token
      final tokenEndpoint = Uri.https('github.com', '/login/oauth/access_token');
      final response = await http.post(
        tokenEndpoint,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'client_id': githubClientId,
          'client_secret': githubClientSecret,
          'code': code,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get access token');
      }

      final tokenData = json.decode(response.body);
      final accessToken = tokenData['access_token'];

      if (accessToken == null) {
        throw Exception('No access token received');
      }

      // Get user data using the access token
      return await _getGitHubUserData(accessToken);
    } catch (error) {
      print('GitHub Sign In Error: $error');
      return null;
    }
  }

  Future<Map<String, dynamic>> _getGitHubUserData(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/user'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      
      // Get user email if not included in profile
      if (userData['email'] == null) {
        final emailResponse = await http.get(
          Uri.parse('https://api.github.com/user/emails'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
        );

        if (emailResponse.statusCode == 200) {
          final emails = json.decode(emailResponse.body);
          final primaryEmail = emails.firstWhere(
            (email) => email['primary'] == true,
            orElse: () => emails.first,
          );
          userData['email'] = primaryEmail['email'];
        }
      }

      return {
        'email': userData['email'],
        'displayName': userData['name'] ?? userData['login'],
        'photoUrl': userData['avatar_url'],
        'id': userData['id'].toString(),
        'accessToken': accessToken,
      };
    } else {
      throw Exception('Failed to get GitHub user data');
    }
  }

  String _generateRandomState() {
    final values = List<int>.generate(32, (i) => DateTime.now().millisecondsSinceEpoch % 256);
    return base64Url.encode(values).replaceAll('=', '');
  }

  Future<void> signOutGoogle() => _googleSignIn.signOut();
} 