using UnityEngine;
using System.Collections;
using UnityEditor;
using System.IO;

public class EditorHelper : MonoBehaviour {

	[MenuItem("Assets/BatchCreateArtistFont")]
	static public void BatchCreateArtistFont()
	{
		ArtistFont.BatchCreateArtistFont();
	}

    [MenuItem("Assets/CheckSpriteCite")]
    static void CheckSpriteCite()
    {
        CheckAssets.CheckSpriteCite();
    }

    [MenuItem("Assets/CheckScripts")]
    static void CheckCheckScripts()
    {
        CheckAssets.CheckScripts();
    }

    [MenuItem("Assets/ChangeImage")]
    static void ChangeImage()
    {
        CheckAssets.ChangeImage();
    }
}
