using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using DragonBones;
using System.IO;

public class GameArmatureComponent : MonoBehaviour
{
    public TextAsset textureAtlasJSON = null;
    public Texture2D[] textures = null;

    private UnityArmatureComponent mUnityArmatureComponent;

    //需要设定GameArmatureComponent在ScriptExecutionOrder的顺序，保证在UnityArmatureComponent前调用Awake
    void Awake()
    {
        mUnityArmatureComponent = gameObject.GetComponent<UnityArmatureComponent>();
        LoadData(mUnityArmatureComponent.dragonBonesJSON);
        mUnityArmatureComponent.dragonBonesJSON = null;
    }

    public void SetMask()
    {
        if (mMaterials == null)
        {
            MeshRenderer[] renderers = this.GetComponentsInChildren<MeshRenderer>(true);

            if (renderers != null)
            {
                Shader shader = Shader.Find("DragonBones/Sprites/Default/Mask");
                mMaterials = new Material[renderers.Length];
                for (int i = 0; i < renderers.Length; i++)
                {
                    var m = renderers[i].material;
                    mMaterials[i] = m;
                    m.shader = shader;
                }
            }
        }
    }

    private Material[] mMaterials = null;
    public void SetColor(string propertyName, Color color)
    {
        if (mMaterials != null)
        {
            for (int i = 0; i < mMaterials.Length; i++)
            {
                var m = mMaterials[i];
                m.SetColor(propertyName, color);
            }
        }
        else
        {
            MeshRenderer[] renderers = this.GetComponentsInChildren<MeshRenderer>(true);

            if (renderers != null)
            {
                mMaterials = new Material[renderers.Length];
                for (int i = 0; i < renderers.Length; i++)
                {
                    var m = renderers[i].material;
                    m.SetColor(propertyName, color);

                    mMaterials[i] = m;
                }
            }
        }
    }

    DragonBonesData LoadData(TextAsset dragonBonesJSON)
    {
        DragonBonesData dragonBonesData = null;

        if (dragonBonesJSON != null)
        {
            dragonBonesData = UnityFactory.factory.LoadDragonBonesData(dragonBonesJSON);
            LoadTextureAtlasData(textureAtlasJSON, textures);
        }

        return dragonBonesData;
    }

    UnityTextureAtlasData LoadTextureAtlasData(TextAsset textureAtlasJSON, Texture2D[] textures, string name = null, float scale = 0.0f)
    {
        if (textureAtlasJSON == null || textures == null || textures.Length == 0)
        {
            return null;
        }

        var textureAtlasData = UnityFactory.factory.ParseTextureAtlasData((Dictionary<string, object>)MiniJSON.Json.Deserialize(textureAtlasJSON.text), null, name, scale) as UnityTextureAtlasData;

        string imageName = Path.GetFileNameWithoutExtension(textureAtlasData.imagePath);
        var shader = Shader.Find("DragonBones/Sprites/Default");
        var material = new Material(shader);
        material.mainTexture = textures[0];
        if( textures.Length > 1)
            material.SetTexture("_AlphaTex", textures[1]);
        textureAtlasData.texture = material;

        return textureAtlasData;
    }
}
