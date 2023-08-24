
using System;
using System.Collections;
using System.IO;
using System.Runtime.CompilerServices;
using System.Text.RegularExpressions;
using UnityEngine;

public sealed class PluginFileUtil
{
    internal static bool AppendTextAfter(string path, string find, string append)
    {
        bool flag = false;
        ArrayList strings = ReadAllText(path);
        for (int i = 0; i < strings.Count; i++)
        {
            if (((string)strings[i]).IndexOf(find) > -1)
            {
                strings.Insert(i + 1, append);
                flag = true;
                break;
            }
        }
        WriteAllText(path, strings);
        return flag;
    }

    internal static void CopyDirectory(string source, string target, bool overwrite)
    {
        CopyDirectoryFiltered(source, target, overwrite, null, false);
    }

    internal static void CopyDirectoryFiltered(string source, string target, bool overwrite, string regExExcludeFilter, bool recursive)
    {
        Regex regex = null;
        try
        {
            if (regExExcludeFilter != null)
            {
                regex = new Regex(regExExcludeFilter);
            }
        }
        catch (ArgumentException)
        {
            Debug.Log("CopyDirectoryRecursive: Pattern '" + regExExcludeFilter + "' is not a correct Regular Expression. Not excluding any files.");
            return;
        }
        if (!Directory.Exists(target))
        {
            Directory.CreateDirectory(target);
            overwrite = false;
        }
        foreach (string str in Directory.GetFiles(source))
        {
            if ((regex == null) || !regex.IsMatch(str))
            {
                string fileName = Path.GetFileName(str);
                string to = Path.Combine(target, fileName);
                UnityFileCopy(str, to, overwrite);
            }
        }
        if (recursive)
        {
            foreach (string str4 in Directory.GetDirectories(source))
            {
                if ((regex == null) || !regex.IsMatch(str4))
                {
                    string str5 = Path.GetFileName(str4);
                    CopyDirectoryFiltered(Path.Combine(source, str5), Path.Combine(target, str5), overwrite, regExExcludeFilter, recursive);
                }
            }
        }
    }

    internal static void CopyDirectoryRecursive(string source, string target)
    {
        CopyDirectoryRecursive(source, target, false, false);
    }

    internal static void CopyDirectoryRecursive(string source, string target, bool overwrite)
    {
        CopyDirectoryRecursive(source, target, overwrite, false);
    }

    internal static void CopyDirectoryRecursive(string source, string target, bool overwrite, bool ignoreMeta)
    {
        CopyDirectoryRecursiveFiltered(source, target, overwrite, !ignoreMeta ? null : @"\.meta$");
    }

    internal static void CopyDirectoryRecursiveFiltered(string source, string target, bool overwrite, string regExExcludeFilter)
    {
        CopyDirectoryFiltered(source, target, overwrite, regExExcludeFilter, true);
    }

    internal static void CopyDirectoryRecursiveForPostprocess(string source, string target, bool overwrite)
    {
        CopyDirectoryRecursiveFiltered(source, target, overwrite, @".*/\.+|\.meta$");
    }

    internal static void CopyDirectoryRecursiveIgnoreMeta(string source, string target)
    {
        CopyDirectoryRecursive(source, target, false, true);
    }

    internal static void CopyFileIfExists(string src, string dst, bool overwrite)
    {
        if (File.Exists(src))
        {
            UnityFileCopy(src, dst, overwrite);
        }
    }

    internal static void CreateOrCleanDirectory(string dir)
    {
        if (Directory.Exists(dir))
        {
            Directory.Delete(dir, true);
        }
        Directory.CreateDirectory(dir);
    }

    internal static string NiceWinPath(string unityPath)
    {
        return ((Application.platform != RuntimePlatform.WindowsEditor) ? unityPath : unityPath.Replace("/", @"\"));
    }

    internal static ArrayList ReadAllText(string path)
    {
        ArrayList list = new ArrayList();
        using (StreamReader reader = File.OpenText(NiceWinPath(path)))
        {
            string str = string.Empty;
            while ((str = reader.ReadLine()) != null)
            {
                list.Add(str);
            }
        }
        return list;
    }

    internal static string RemovePathPrefix(string fullPath, string prefix)
    {
        char[] separator = new char[] { Path.DirectorySeparatorChar };
        string[] strArray = fullPath.Split(separator);
        char[] chArray2 = new char[] { Path.DirectorySeparatorChar };
        string[] strArray2 = prefix.Split(chArray2);
        int index = 0;
        if (strArray[0] == string.Empty)
        {
            index = 1;
        }
        while (((index < strArray.Length) && (index < strArray2.Length)) && (strArray[index] == strArray2[index]))
        {
            index++;
        }
        if (index == strArray.Length)
        {
            return string.Empty;
        }
        return string.Join(Path.DirectorySeparatorChar.ToString(), strArray, index, strArray.Length - index);
    }

    internal static void ReplaceText(string path, params string[] input)
    {
        ArrayList strings = ReadAllText(path);
        for (int i = 0; i < input.Length; i += 2)
        {
            for (int j = 0; j < strings.Count; j++)
            {
                strings[j] = ((string)strings[j]).Replace(input[i], input[i + 1]);
            }
        }
        WriteAllText(path, strings);
    }

    internal static bool ReplaceTextRegex(string path, params string[] input)
    {
        bool flag = false;
        ArrayList strings = ReadAllText(path);
        for (int i = 0; i < input.Length; i += 2)
        {
            for (int j = 0; j < strings.Count; j++)
            {
                string str = (string)strings[j];
                strings[j] = Regex.Replace(str, input[i], input[i + 1]);
                if (str != ((string)strings[j]))
                {
                    flag = true;
                }
            }
        }
        WriteAllText(path, strings);
        return flag;
    }

    internal static void UnityDirectoryDelete(string path)
    {
        UnityDirectoryDelete(path, false);
    }

    internal static void UnityDirectoryDelete(string path, bool recursive)
    {
        Directory.Delete(NiceWinPath(path), recursive);
    }

    internal static void UnityFileCopy(string from, string to)
    {
        UnityFileCopy(from, to, false);
    }

    internal static void UnityFileCopy(string from, string to, bool overwrite)
    {
        File.Copy(NiceWinPath(from), NiceWinPath(to), overwrite);
    }

    internal static string UnityGetDirectoryName(string path)
    {
        return Path.GetDirectoryName(path.Replace("//", @"\\")).Replace(@"\\", "//");
    }

    internal static string UnityGetFileName(string path)
    {
        return Path.GetFileName(path.Replace("//", @"\\")).Replace(@"\\", "//");
    }

    internal static string UnityGetFileNameWithoutExtension(string path)
    {
        return Path.GetFileNameWithoutExtension(path.Replace("//", @"\\")).Replace(@"\\", "//");
    }

    internal static void WriteAllText(string path, ArrayList strings)
    {
        StreamWriter writer = new StreamWriter(NiceWinPath(path));
        IEnumerator enumerator = strings.GetEnumerator();
        try
        {
            while (enumerator.MoveNext())
            {
                string current = (string)enumerator.Current;
                writer.WriteLine(current);
            }
        }
        finally
        {
            IDisposable disposable = enumerator as IDisposable;
            if (disposable == null)
            {
            }
            disposable.Dispose();
        }
        writer.Close();
    }
}


