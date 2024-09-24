using System.Net;
using UnityEngine;
using AppleAuth;
using AppleAuth.Enums;
using AppleAuth.Interfaces;
using System.Text;
using AppleAuth.Extensions;

namespace ET
{
    public class Apple_OnAppleSignIn : AEventClass<EventType.AppleSignIn>
    {
        protected override void Run(object numerice)
        {
            EventType.AppleSignIn args = numerice as EventType.AppleSignIn;


            Log.ILog.Debug($"apple SignInWithApple");

            var loginArgs = new AppleAuthLoginArgs(LoginOptions.IncludeEmail | LoginOptions.IncludeFullName);
            AppleAuthManager appleAuthManager = GameObject.Find("Global").GetComponent<Init>().appleAuthManager;


            if (GlobalHelp.IsEditorMode)
            {
                args.AppleSignInHandler("apple_112121212212212");
                return;
            }
            if (appleAuthManager == null)
            {
                Log.ILog.Debug($"apple appleAuthManager == null");
                return;
            }

            Log.ILog.Debug($"apple appleAuthManager != null");
            //appleAuthManager.LoginWithAppleId(
            //loginArgs,
            //credential =>
            //{
            //    // If a sign in with apple succeeds, we should have obtained the credential with the user id, name, and email, save it
            //    //PlayerPrefs.SetString(AppleUserIdKey, credential.User);
            //    //this.SetupGameMenu(credential.User, credential);
            //    Log.ILog.Debug($"apple登陆成功！！{credential.User}  {credential.ToString()}");
            //    args.AppleSignInHandler("apple_" +  credential.User);
            //},
            //error =>
            //{
            //    // var authorizationErrorCode = error.GetAuthorizationErrorCode();
            //    //  Debug.LogWarning("Sign in with Apple failed " + authorizationErrorCode.ToString() + " " + error.ToString());
            //    // this.SetupLoginMenuForSignInWithApple();
            //    Log.Error("apple登陆失败！！");
            //});


            appleAuthManager.LoginWithAppleId(
                loginArgs,
                credential =>
                {
                    // Obtained credential, cast it to IAppleIDCredential
                    var appleIdCredential = credential as IAppleIDCredential;
                    if (appleIdCredential != null)
                    {
                        // Apple User ID
                        // You should save the user ID somewhere in the device
                        var userId = appleIdCredential.User;

                        //PlayerPrefs.SetString("AppleUserIdKey", userId);

                        // Email (Received ONLY in the first login)
                        var email = appleIdCredential.Email;

                        // Full name (Received ONLY in the first login)
                        var fullName = appleIdCredential.FullName;

                        // Identity token
                        var identityToken = Encoding.UTF8.GetString(
                            appleIdCredential.IdentityToken,
                            0,
                            appleIdCredential.IdentityToken.Length);

                        // Authorization code
                        var authorizationCode = Encoding.UTF8.GetString(
                            appleIdCredential.AuthorizationCode,
                            0,
                            appleIdCredential.AuthorizationCode.Length);

                        Log.ILog.Debug($"apple登陆成功！！{userId}  {credential.ToString()}");
                        args.AppleSignInHandler("apple_" + userId);
                        // And now you have all the information to create/login a user in your system
                    }
                },
                error =>
                {
                    // Something went wrong
                    var authorizationErrorCode = error.GetAuthorizationErrorCode();

                    Log.Error($"authorizationErrorCode:  {authorizationErrorCode.ToString()}");
                });

        }
    }
}