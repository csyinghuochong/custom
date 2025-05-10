using System.Collections.Generic;
using System.Threading;

namespace ET
{
    public static class ConsoleMode
    {
        public const string ReloadDll = "R";
        public const string ReloadConfig = "C";
        public const string ShowMemory = "M";
        public const string Repl = "Repl";
        public const string Debugger = "Debugger";
        public const string CreateRobot = "CreateRobot";
        public const string Robot = "robot";
        public const string OnLineNumer = "online";
        public const string Mail = "mail";
        public const string StopServer = "stopserver";
        public const string Rechage = "rechage";
        public const string ChaXun = "chaxun";
        public const string KickOut = "kickout";
        public const string Combat = "combat";
        public const string ServerRank = "serverrank";
        public const string Watcher = "watcher";
        public const string Level = "level";
        public const string Gold = "gold";
        public const string RechargeChaXun = "rechargechaxun";
    }

    public class ConsoleComponent: Entity, IAwake, ILoad
    {
        public CancellationTokenSource CancellationTokenSource;
        public Dictionary<string, IConsoleHandler> Handlers = new Dictionary<string, IConsoleHandler>();
    }
}