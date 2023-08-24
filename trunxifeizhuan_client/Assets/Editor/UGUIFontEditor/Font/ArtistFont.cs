using UnityEngine;
using System.Collections;
using UnityEditor;

public class ArtistFont : MonoBehaviour
{
    public static void BatchCreateArtistFont()
    {
        string dirName = "";
        string fntname = EditorUtils.SelectObjectPathInfo(ref dirName).Split('.')[0];
        Debug.Log(fntname);
        Debug.Log(dirName);

        string fntFileName = dirName + fntname + ".fnt";
        Font CustomFont = new Font();
        TextAsset BMFontText = UnityEditor.AssetDatabase.LoadAssetAtPath(fntFileName, typeof(TextAsset)) as TextAsset;
        BMFont mbFont = new BMFont();
        BMFontReader.Load(mbFont, BMFontText.name, BMFontText.bytes);  // 借用NGUI封装的读取类
        CharacterInfo[] characterInfo = new CharacterInfo[mbFont.glyphs.Count];
        for (int i = 0; i < mbFont.glyphs.Count; i++)
        {
            BMGlyph bmInfo = mbFont.glyphs[i];
            CharacterInfo info = new CharacterInfo();
            info.index = bmInfo.index;
            //info.uv.x = (float)bmInfo.x / (float)mbFont.texWidth;
            //info.uv.y = 1 - (float)bmInfo.y / (float)mbFont.texHeight;
            //info.uv.width = (float)bmInfo.width / (float)mbFont.texWidth;
            //info.uv.height = -1f * (float)bmInfo.height / (float)mbFont.texHeight;
            //info.vert.x = (float)bmInfo.offsetX;
            //info.vert.y = (float)bmInfo.offsetY;
            //info.vert.width = (float)bmInfo.width;
            //info.vert.height = (float)bmInfo.height;
            //info.width = (float)bmInfo.advance;

            float uvx = (float)bmInfo.x / (float)mbFont.texWidth;
            float uvy = 1 - (float)bmInfo.y / (float)mbFont.texHeight;
            float uvw = (float)bmInfo.width / (float)mbFont.texWidth;
            float uvh = -1f * (float)bmInfo.height / (float)mbFont.texHeight;

            info.uvBottomLeft = new Vector2(uvx, uvy);
            info.uvBottomRight = new Vector2(uvx + uvw, uvy);
            info.uvTopLeft = new Vector2(uvx, uvy + uvh);
            info.uvTopRight = new Vector2(uvx + uvw, uvy + uvh);

            info.minX = bmInfo.offsetX;
            info.minY = (int)((float)bmInfo.offsetY + (float)bmInfo.height);
            info.glyphWidth = bmInfo.width;
            info.glyphHeight = -bmInfo.height;
            //info.advance = bmInfo.advance;

            characterInfo[i] = info;
        }
        CustomFont.characterInfo = characterInfo;


        string textureFilename = dirName + mbFont.spriteName + ".png";
        Shader shader = Shader.Find("Sprites/Default");
        Material mat = new Material(shader);
        Texture tex = UnityEditor.AssetDatabase.LoadAssetAtPath(textureFilename, typeof(Texture)) as Texture;
        mat.SetTexture("_MainTex", tex);
        AssetDatabase.CreateAsset(mat, dirName + fntname + ".mat");
        CustomFont.material = mat;

        string fontPath = dirName + fntname + ".fontsettings";
        AssetDatabase.CreateAsset(CustomFont, fontPath);
        AssetDatabase.SaveAssets();
        AssetDatabase.Refresh();
    }
}
