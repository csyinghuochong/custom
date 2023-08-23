using UnityEngine;
using System.Collections;
using System;
using System.Reflection;
using System.IO;
using Assets.Scripts.Com.Game.Manager;
using Assets.Scripts.Com.Game.Utils;
using Assets.Plugins.Assets.Scripts.Com.Game.Manager;
using Assets.Plugins.Assets.Scripts.Com.Game.Utils;
using Assets.Plugins.Assets.Scripts.Com.Game.Platform;
using Assets.Scripts.Com.Net;

public class Launch : MonoBehaviour
{
    public void Awake()
    {
        RC4Crypto.InitCiphertext("YKCW6-BPFPF-BT8C9-7DCTH-QXGWC");
    }

    void Start()
    {
        print("Launch......");
        ResourceURL.sUsePersistentPath = true;

        GameManager.Instance.AddPluginsComponent(gameObject);
        GameManager.Instance.mGameResUpdateManager.Init();
    }

    public void LoadGameScript()
    {
        ResourceLoader.Instance.LoadAsset<TextAsset>("Dll/vo.bytes", "vo", delegate(TextAsset textAsset)
        {
            AppDomain.CurrentDomain.Load(RC4Crypto.DecryptEx(textAsset.bytes));
        });

        ResourceLoader.Instance.LoadAsset<TextAsset>("Dll/GameScript.bytes", "GameScript", delegate(TextAsset textAsset)
        {
            AppDomain.CurrentDomain.Load(RC4Crypto.DecryptEx(textAsset.bytes));

            LoadGameScriptComplete();
        });
    }

    private void LoadGameScriptComplete()
    {
        Assembly[] assemblyList = AppDomain.CurrentDomain.GetAssemblies();
        foreach (Assembly assembly in assemblyList)
        {
            Type type = assembly.GetType("Assets.Scripts.Com.Game.Mono.Main");

            if (type != null)
            {
                Component com = gameObject.AddComponent(type);
                break;
            }
        }
    }
}
