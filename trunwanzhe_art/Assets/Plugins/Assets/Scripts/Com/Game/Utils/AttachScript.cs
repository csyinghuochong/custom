using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Assets.Scripts.Com.Net;
using UnityEngine;

namespace Assets.Plugins.Assets.Scripts.Com.Game.Utils
{
    class AttachScript : MonoBehaviour
    {
        void Start()
        {
            RC4Crypto.InitCiphertext((Resources.Load("Encrypt/Key") as TextAsset).text + this.gameObject.name);
        }
    }
}
