using System;
using System.IO;
using System.Net;
using UnityEngine;
public class FtpHelper
{
    private static FtpWebRequest reqFTP;
    private static FileStream fs;
    private static Stream strm;
    private static int buffLength = 2048;
    private static byte[] buff = new byte[buffLength];
    private static FileInfo fileInf;

    //ftp的上传功能  
    public static void Upload(string filename, string ftpPath, string ftpFileName)
    {
        fileInf = new FileInfo(filename);

        reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(ftpPath + ftpFileName));
        reqFTP.Credentials = new NetworkCredential("036lixiongjun", "123456");
        reqFTP.UsePassive = true;
        reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
        reqFTP.UseBinary = true;
        reqFTP.ContentLength = fileInf.Length;

        fs = fileInf.OpenRead();
        strm = reqFTP.GetRequestStream();

        UploadFile();
    }

    static void UploadFile()
    {
        buff = new byte[buffLength];

        try
        {
            int contentLen = fs.Read(buff, 0, buffLength);
            while (contentLen != 0)
            {
                strm.Write(buff, 0, contentLen);
                contentLen = fs.Read(buff, 0, buffLength);
            }
        }
        catch (Exception ex)
        {

        }

        fs.Dispose();
        strm.Dispose();
    }
}