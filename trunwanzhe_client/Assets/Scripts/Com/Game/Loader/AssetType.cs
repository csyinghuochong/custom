using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Loader
{
    enum AssetType
    {
        NONE,
        UISprite,
        UITexture,
        UIIcon,
        UILabel,
        MeshRenderer,
        ParticleSystemRenderer,
        TrailRenderer,
        SkinnedMeshRenderer,
        MeshFilter,
        TextAsset,
        BinDataTextAsset,
        UIPrefab,
        ExternalPrefab,
        Scene,
        AudioClip,
        Texture,
    }

    class AssetTypeTools
    {
        const string prefab = ".prefab";
        const string texture = ".texture";
        const string font = ".font";
        const string mat = ".mat";
        const string scene = ".scene";
        const string music = ".music";

        public static string GetAssetKey(string assetName, AssetType assetType)
        {
            switch (assetType)
            {
                case AssetType.UISprite:
                case AssetType.UIPrefab:
                case AssetType.ExternalPrefab:
                case AssetType.MeshFilter:
                    return assetName + prefab;
                case AssetType.UIIcon:
                case AssetType.UITexture:
                case AssetType.Texture:
                    return assetName + texture;
                case AssetType.UILabel:
                    return assetName + font;
                case AssetType.MeshRenderer:
                case AssetType.ParticleSystemRenderer:
                case AssetType.TrailRenderer:
                case AssetType.SkinnedMeshRenderer:
                    return assetName + mat;
                case AssetType.Scene:
                    return assetName + scene;
                case AssetType.AudioClip:
                    return assetName + music;
            }

            return assetName;
        }

        public static Type GetComponentType(AssetType assetType)
        {
            switch (assetType)
            {
                case AssetType.UISprite:
                    return typeof(UISprite);
                case AssetType.UILabel:
                    return typeof(UILabel);
                case AssetType.UITexture:
                    return typeof(UITexture);
                case AssetType.Texture:
                    return typeof(Texture2D);
                case AssetType.MeshRenderer:
                    return typeof(MeshRenderer);
                case AssetType.ParticleSystemRenderer:
                    return typeof(ParticleSystemRenderer);
                case AssetType.TrailRenderer:
                    return typeof(TrailRenderer);
                case AssetType.SkinnedMeshRenderer:
                    return typeof(SkinnedMeshRenderer);
                case AssetType.MeshFilter:
                    return typeof(MeshFilter);
            }

            Debug.LogError("GetComponentType error assetType:" + assetType);

            return null;
        }

        public static bool IsPackageType(AssetType type)
        {
            return type == AssetType.UIPrefab
                || type == AssetType.ExternalPrefab
                || type == AssetType.Scene;
        }

        public static bool IsMaterialType(AssetType assetType)
        {
            return assetType == AssetType.MeshRenderer ||
                     assetType == AssetType.ParticleSystemRenderer ||
                     assetType == AssetType.TrailRenderer ||
                     assetType == AssetType.SkinnedMeshRenderer;
        }

        public static bool IsUIType(AssetType assetType)
        {
            return assetType == AssetType.AudioClip ||
                assetType == AssetType.BinDataTextAsset ||
                assetType == AssetType.UILabel ||
                assetType == AssetType.UIPrefab ||
                assetType == AssetType.UISprite ||
                assetType == AssetType.UITexture ||
                assetType == AssetType.UIIcon;
        }
    }
}
