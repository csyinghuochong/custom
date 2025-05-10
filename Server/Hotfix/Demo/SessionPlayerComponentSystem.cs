﻿

namespace ET
{

	public static class SessionPlayerComponentSystem
	{
		public class SessionPlayerComponentAwakeSystem : AwakeSystem<SessionPlayerComponent>
		{
			public override void Awake(SessionPlayerComponent self)
			{
				self.isLoginAgain = false;
				self.AccountId = 0;
				self.PlayerId = 0;
				self.PlayerInstanceId = 0;
			}
		}

		public class SessionPlayerComponentDestroySystem: DestroySystem<SessionPlayerComponent>
		{
			public override void Destroy(SessionPlayerComponent self)
			{
				Player player = Game.EventSystem.Get(self.PlayerInstanceId) as Player;
				if (player == null)
				{
					Log.Debug($"SessionPlayerComponent  player == null {self.AccountId}");
					return;
				}

				Log.Debug($"SessionPlayerDestroy zone: {self.DomainZone()} self.isLoginAgain = {self.isLoginAgain}: player.Id:{player.Id} player.InstanceId:{player.InstanceId}");
				ActorLocationSenderComponent.Instance.Send(self.PlayerId, new G2M_SessionDisconnect());
				player.RemoveComponent<PlayerOfflineOutTimeComponent>();
				player.AddComponent<PlayerOfflineOutTimeComponent>();	//n秒后会kickplayer
				player.ClientSession = null;

				self.AccountId = 0;
				self.PlayerId = 0;
				self.PlayerInstanceId = 0;
				self.isLoginAgain = false;
			}
		}

		public static Player GetMyPlayer(this SessionPlayerComponent self)
		{
			return self.Domain.GetComponent<PlayerComponent>().Get(self.AccountId);
		}

		public static Player GetPlayer(this SessionPlayerComponent self, long accountId)
		{
			return self.Domain.GetComponent<PlayerComponent>().Get(accountId);
		}
	}
}
