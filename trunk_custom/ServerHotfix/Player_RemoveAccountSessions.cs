

namespace ET
{

    public class Player_RemoveAccountSessions : AEvent<EventType.RemoveAccountSessions>
    {
        protected override void Run(EventType.RemoveAccountSessions args)
        {
            Scene scene = args.DomainScene;
            scene.GetComponent<AccountSessionsComponent>().Remove(args.AccountId);
        }
    }
}
