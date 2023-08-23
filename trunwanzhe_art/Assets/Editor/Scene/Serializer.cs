using UnityEngine;
using System.Collections;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using System.Text;
using System;
using System.Collections.Generic;

public class Serializer
{
    public void SerializeToXml(object objToSerialize, string fileName)
    {
        try
        {
            XmlSerializer xmlSerializer = new XmlSerializer(objToSerialize.GetType());
            XmlTextWriter xmlWriter = new XmlTextWriter(fileName, new UTF8Encoding(false));
            xmlWriter.Formatting = Formatting.Indented;
            xmlSerializer.Serialize(xmlWriter, objToSerialize);
            xmlWriter.Flush();
            xmlWriter.Close();
        }
        catch (Exception ex)
        {
            throw new ApplicationException("Couldn't Serialize Object:" + objToSerialize.GetType().Name, ex);
        }
    }

    public void DeserializeXml<T>(byte[] bytes, Action<T> callBack)
    {
        XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
        MemoryStream stream = new MemoryStream(bytes);
        T config = (T)xmlSerializer.Deserialize(stream);

        callBack(config);
    }
}