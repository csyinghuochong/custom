using UnityEngine;
using System.Collections;
using UnityEditor;
using UnityEditorInternal;
using System.Collections.Generic;

[CustomEditor(typeof(SkillShakeHelper))]
public class SkillShakeHelperInspector : Editor
{
    private List<string> skills = new List<string>();
    private List<string> shakes = new List<string>();
    void OnEnable()
    {
        this.UpdateStates();
    }

    void UpdateStates()
    {
        SkillShakeHelper shakeHelper = target as SkillShakeHelper;
        if (shakeHelper)
        {
            Animator animator = shakeHelper.GetComponent<Animator>();
            this.skills.Clear();
            this.shakes.Clear();
            this.GetStates(animator,ref this.skills);
            if (shakeHelper.shakeCamera == null)
            {
                shakeHelper.shakeCamera = Camera.main.GetComponent<Animator>();
            }
            this.GetStates(shakeHelper.shakeCamera,ref this.shakes);
        }
    }
    void GetStates(Animator animator,ref List<string> states)
    {
        if (animator&&animator.runtimeAnimatorController)
        {
            UnityEditor.Animations.AnimatorController controller = animator.runtimeAnimatorController as UnityEditor.Animations.AnimatorController;
            //for (int i = 0; i < controller.layerCount; i++)
            //{
            //    UnityEditor.Animations.AnimatorControllerLayer layer = controller.GetLayer(i);
            //    this.GetStates(layer.stateMachine, ref states);
            //}
        }
    }
    void GetStates(UnityEditor.Animations.AnimatorStateMachine stateMachine, ref List<string> states)
    {
        //for (int i = 0; i < stateMachine.stateMachineCount; i++)
        //{
        //    this.GetStates(stateMachine.GetStateMachine(i), ref states);
        //}
        //for (int i = 0; i < stateMachine.stateCount; i++)
        //{
        //    UnityEditor.Animations.AnimatorState state = stateMachine.GetState(i);
        //    states.Add(state.uniqueName);
        //}
    }


    public override void OnInspectorGUI()
    {
        //base.OnInspectorGUI();
        SkillShakeHelper shakeHelper = target as SkillShakeHelper;
        if (shakeHelper)
        {
            int select = this.skills.IndexOf(shakeHelper.skillName);
            select = EditorGUILayout.Popup("Skill:", select, this.skills.ToArray());
            if (select >= 0 && select < this.skills.Count)
            {
                shakeHelper.skillName = this.skills[select];
            }

            shakeHelper.shakeTime = EditorGUILayout.FloatField("Shake Time:", shakeHelper.shakeTime);

            shakeHelper.shakeCamera = EditorGUILayout.ObjectField("Shake Camera:", shakeHelper.shakeCamera, typeof(Animator)) as Animator;
            select = this.shakes.IndexOf(shakeHelper.shakeName);
            select = EditorGUILayout.Popup("Shake:", select, this.shakes.ToArray());
            if (select >= 0 && select < this.shakes.Count)
            {
                shakeHelper.shakeName = this.shakes[select];
            }

        }
        if (GUILayout.Button("Update"))
        {
            this.UpdateStates();
        }
    }
}
