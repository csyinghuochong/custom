using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using Assets.Scripts.Com.Game.Loader;

namespace Assets.Editor.Depend
{
    class DependBase
    {
        public string mExtension;
        public AssetType mAssetType;
        public List<string> mAssetsList = new List<string>();

        public virtual List<string> CompareComponent(Component component)
        {
            return null;
        }

        public virtual string GetTypeName()
        {
            return mAssetType.ToString();
        }

        public virtual List<string> GetWithExtension(List<string> assetNameList)
        {
            List<string> result = new List<string>();

            List<string> extensionList = mExtension.Split('|').ToList();

            for (int i = 0, count = assetNameList.Count; i < count; i++)
            {
                for (int j = 0, len = extensionList.Count; j < len; j++)
                {
                    result.Add(assetNameList[i] + extensionList[j]);
                }
            }

            return result;
        }

        public virtual List<string> GetWithExtension(string assetName)
        {
            List<string> result = new List<string>();
            List<string> extensionList = mExtension.Split('|').ToList();
            for (int j = 0, len = extensionList.Count; j < len; j++)
            {
                result.Add(assetName + extensionList[j]);
            }
            return result;
        }

        public void AddAssets(string str)
        {
            mAssetsList.Add(str);
        }

        public string GetAssetsListStr()
        {
            string result = mAssetType.ToString() + ":";

            if (mAssetsList.Count == 0)
            {
                return result + "nil";
            }

            for (int i = 0, count = mAssetsList.Count; i < count; i++)
            {
                result += (i == 0 ? "" : ",") + mAssetsList[i];
            }

            return result;
        }

        public static string Output(List<DependBase> dependBaseList)
        {
            string result = "";

            for (int i = 0, count = dependBaseList.Count; i < count; i++)
            {
                if (string.IsNullOrEmpty(result))
                {
                    result = dependBaseList[i].GetAssetsListStr();
                }
                else
                {
                    result += "#" + dependBaseList[i].GetAssetsListStr();
                }
            }

            return result;
        }
    }

    class UISpriteDepend : DependBase
    {
        public UISpriteDepend()
        {
            mExtension = ".prefab";
            mAssetType = AssetType.UISprite;
        }

        public override List<string> CompareComponent(Component component)
        {
            string componentTypeName = component.GetType().ToString();
            string assetName = null;
            if (componentTypeName == GetTypeName())
            {
                assetName = "";
                if (((UISprite)component).atlas != null)
                {
                    assetName = ((UISprite)component).atlas.name;
                    ((UISprite)component).atlas = null;
                }

                return new List<string>() { assetName };
            }

            return null;
        }
    }

    class UILabelDepend : DependBase
    {
        public UILabelDepend()
        {
            mExtension = ".prefab";
            mAssetType = AssetType.UILabel;
        }

        public override List<string> CompareComponent(Component component)
        {
            string componentTypeName = component.GetType().ToString();
            string assetName = null;
            if (componentTypeName == GetTypeName())
            {
                assetName = "";
                if (((UILabel)component).bitmapFont != null)
                {
                    assetName = ((UILabel)component).bitmapFont.name;
                    ((UILabel)component).bitmapFont = null;
                }

                return new List<string>() { assetName };
            }

            return null;
        }
    }

    class UITextureDepend : DependBase
    {
        public UITextureDepend()
        {
            mExtension = ".png|.jpg";
            mAssetType = AssetType.UITexture;
        }

        public override List<string> CompareComponent(Component component)
        {
            string componentTypeName = component.GetType().ToString();
            string assetName = null;
            if (componentTypeName == GetTypeName())
            {
                assetName = "";
                if (((UITexture)component).mainTexture != null)
                {
                    assetName = ((UITexture)component).mainTexture.name;
                    ((UITexture)component).mainTexture = null;
                }

                return new List<string>() { assetName };
            }

            return null;
        }
    }

    class MeshRendererDepend : DependBase
    {
        Renderer render;

        public MeshRendererDepend()
        {
            mExtension = ".mat";
            mAssetType = AssetType.MeshRenderer;
        }

        public override string GetTypeName()
        {
            return "UnityEngine." + base.GetTypeName();
        }

        public override List<string> CompareComponent(Component component)
        {
            string componentTypeName = component.GetType().ToString();
            if (componentTypeName == GetTypeName())
            {
                render = component as Renderer;

                List<string> result = new List<string>();
                int count = render.sharedMaterials.Length;

                for (int i = 0; i < count; i++)
                {
                    Material material = render.sharedMaterials[i];

                    if (material)
                        result.Add(material.name);
                    else
                        result.Add("");
                }

                render.sharedMaterial = null;
                render.sharedMaterials = new Material[count];
                render.material = null;
                render.materials = new Material[count];

                return result;
            }

            return null;
        }
    }

    class ParticleSystemRendererDepend : MeshRendererDepend
    {
        public ParticleSystemRendererDepend()
        {
            mExtension = ".mat";
            mAssetType = AssetType.ParticleSystemRenderer;
        }
    }

    class TrailRendererRendererDepend : MeshRendererDepend
    {
        public TrailRendererRendererDepend()
        {
            mExtension = ".mat";
            mAssetType = AssetType.TrailRenderer;
        }
    }
}
