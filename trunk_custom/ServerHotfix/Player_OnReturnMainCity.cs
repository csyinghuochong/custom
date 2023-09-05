namespace ET
{
    public class Player_OnReturnMainCity : AEvent<EventType.ReturnMainCity>
    {
        protected override void Run(EventType.ReturnMainCity args)
        {
            Scene scene = args.DomainScene;
            long userId = args.UnitId;

            int sceneTypeEnum = scene.GetComponent<MapComponent>().SceneTypeEnum;
            if (SceneConfigHelper.IsSingleFuben(sceneTypeEnum))
            {
                if (sceneTypeEnum == SceneTypeEnum.LocalDungeon)
                {
                    long olddungeonid = args.DomainScene.GetComponent<LocalDungeonComponent>().LastDungeonId;
                    Scene oldScene = Game.Scene.Get(olddungeonid);
                    if (oldScene != null)
                    {
                        TransferHelper.NoticeFubenCenter(oldScene, 2).Coroutine();
                        oldScene.Dispose();
                    }
                }
                TransferHelper.NoticeFubenCenter(scene, 2).Coroutine();
                scene.Dispose();
            }
            if (sceneTypeEnum == SceneTypeEnum.TeamDungeon)
            {
                TeamSceneComponent teamSceneComponent = scene.GetParent<TeamSceneComponent>();
                teamSceneComponent.OnUnitReturn(scene, userId);
            }
            if (sceneTypeEnum == SceneTypeEnum.JiaYuan)
            {
                JiaYuanSceneComponent jiayuanSceneComponent = scene.GetParent<JiaYuanSceneComponent>();
                jiayuanSceneComponent.OnUnitLeave(scene);
            }
            if (sceneTypeEnum == (int)SceneTypeEnum.Arena)
            {
                ArenaDungeonComponent areneSceneComponent = scene.GetComponent<ArenaDungeonComponent>();
                areneSceneComponent.OnUnitDisconnect(userId);
            }
        }
    }
}
