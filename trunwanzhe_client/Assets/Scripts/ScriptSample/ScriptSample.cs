using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

//所有命名均以英文命名;

//文件夹名字开头字母大写，在vs上创建类时，vs会根据文件路径生成命名空间。如本文件的命名空间“Assets.ScriptSample”是vs自动生成;

//类文件名反映出其包含的类，如ScriptSample.cs文件包含了ScriptSample类。一个类文件尽量包含少的类实现，不要超过两个,最好是只包含一个;

namespace Assets.ScriptSample
{
    //类名开头字母大写，记得加上public访问修饰符，否则不在同一个命名空间下是访问不了的;
    public class ScriptSample
    {
        //《---适当加注释说明游戏逻辑---》;

        //所有成员变量和函数最好加上访问修饰符(private public protected internal);

        //多单词命名采用驼峰式命名规则，如变量名mScriptSample;

        //成员变量前面加m标识;
        public int mInt;

        //静态变量加s标识;
        public static float sFloat;

        //常量全用大写字母;
        public const string STRING = "";
        //常量多单词命名需要中间加下划线;
        public const string CONST_STRING = "";

        //函数命名首字母大写;
        //参数命名首字母小写，采用驼峰式命名规则;
        public void TestSample(int value, string valueString)
        {

        }
    }
}
