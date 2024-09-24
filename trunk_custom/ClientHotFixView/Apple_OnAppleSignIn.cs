using System.Net;
using UnityEngine;
using AppleAuth;
using AppleAuth.Enums;
using AppleAuth.Interfaces;

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
                return;
            }

            appleAuthManager.LoginWithAppleId(
            loginArgs,
            credential =>
            {
                // If a sign in with apple succeeds, we should have obtained the credential with the user id, name, and email, save it
                //PlayerPrefs.SetString(AppleUserIdKey, credential.User);
                //this.SetupGameMenu(credential.User, credential);
                Log.ILog.Debug($"apple登陆成功！！{credential.User}  {credential.ToString()}");
                args.AppleSignInHandler("apple_" +  credential.User);
            },
            error =>
            {
                // var authorizationErrorCode = error.GetAuthorizationErrorCode();
                //  Debug.LogWarning("Sign in with Apple failed " + authorizationErrorCode.ToString() + " " + error.ToString());
                // this.SetupLoginMenuForSignInWithApple();
                Log.Error("apple登陆失败！！");
            });
        }
    }
}