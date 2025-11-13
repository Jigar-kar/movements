import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<bool> googleSignIn(BuildContext context) async {
  try {
    context.loaderOverlay.show(); // Show loading overlay

    // Trigger Google Sign-In
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Check if the user cancels the sign-in process
    if (gUser == null) {
      print("Google Sign-In canceled");
      context.loaderOverlay.hide(); // Hide loading overlay
      return false;
    }

    // Get GoogleSignInAuthentication
    GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create AuthCredential using GoogleSignInAuthentication
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Sign in with AuthCredential
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Get the current user
    User? user = result.user;

    // Close the loading overlay
    context.loaderOverlay.hide();

    if (user != null) {
      print("User UID: ${user.uid}");
      return true;
    } else {
      print("Failed to get user details");
    }
  } catch (e) {
    print("Error during Google Sign-In: $e");
    context.loaderOverlay.hide(); // Hide loading overlay in case of error
  }

  // Return false in case of any error
  return false;
}

signUp(String email, String passeord) async {}

Future<bool> signOutUser() async {
  User? user = auth.currentUser;

  if (user != null) {
    // Check the provider ID to determine the sign-in method
    if (user.providerData.isNotEmpty &&
        user.providerData[0].providerId == 'google.com') {
      // If the user signed in with Google, disconnect from Google Sign-In
      await GoogleSignIn().disconnect();
    }

    // Sign out from Firebase
    await auth.signOut();

    // Return true to indicate successful sign-out
    return Future.value(true);
  }

  // Return false if there is no user to sign out
  return false;
}
