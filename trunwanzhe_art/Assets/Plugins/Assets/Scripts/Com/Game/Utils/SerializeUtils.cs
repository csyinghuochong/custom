using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using UnityEngine;

namespace Assets.Scripts.Com.Game.Utils
{
    public static class SerializeUtils
    {
        //对象序列化保存
        public static void Serializer(String path, object data)
        {
            FileStream fileStream = new FileStream(path, FileMode.Create);
            IFormatter formatter = new BinaryFormatter();
            formatter.Serialize(fileStream, data);
            fileStream.Close();
        }

        //反序列化对象
        public static object Deserializer(String path)
        {
            if (!File.Exists(path))
            {
                Debug.LogError(string.Format("Deserializer error, path:{0}", path));
                return null;
            }

            FileStream fileStream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read);
            return DeserializationFromStream(fileStream);
        }

        public static object DeserializationFromStream(Stream stream)
        {
            try
            {
                IFormatter formatter = new BinaryFormatter();
                object dataObject = formatter.Deserialize(stream);
                stream.Close();
                return dataObject;
            }
            catch (Exception ex)
            {
                Debug.LogException(ex);
            }
            return null;
        }

        public static object DeserializationFromBytes(byte[] bytes)
        {
            MemoryStream stream = new MemoryStream(bytes);
            object obj = DeserializationFromStream(stream);
            stream.Close();

            return obj;
        }

        public static void SerializeToXml(object objToSerialize, string fileName)
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

        public static void DeserializeXml<T>(byte[] bytes, Action<T> callBack)
        {
            XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));

            using (MemoryStream stream = new MemoryStream(bytes))
            {
                T config = (T)xmlSerializer.Deserialize(stream);
                callBack(config);
            }
        }
    }
}
