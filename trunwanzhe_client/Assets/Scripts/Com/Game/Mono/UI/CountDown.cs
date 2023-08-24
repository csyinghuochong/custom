using Assets.Scripts.Com.Game.Utils.Timers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Assets.Scripts.Com.Game.Mono.UI
{
    class CountDown
    {
        public CountDown(UILabel label, string str, int time, string finish, Action callback)
        {
            if (mGameTimer == null)
            {
                mGameTimer = new GameTimer(1f, 0, UpdateTime,null,true);
            }

            if (time > 0)
            {
                mTime = time;
                mLabel = label;
                mText = str;
                mFinish = finish;
                mFinishCallback = callback;
                mGameTimer.Start();
                UpdateTime();
            }
            else
            {
                label.text = finish;
            }
        }

        public void SetTime(int time)
        {
            if (time > 0)
            {
                mTime = time;
                mGameTimer.Start();
            }
            else
            {
                mTime = 0;
                mGameTimer.Stop();
                mLabel.text = mFinish;
            }
        }

        public int GetTime()
        {
            return mTime;
        }

        public void StopGameTimer()
        {
            mGameTimer.Stop();
        }

        private void UpdateTime()
        {
            mTime--;
            if (mTime > 0)
            {
                int hour = mTime / 3600;
                int minute = (mTime % 3600) / 60;
                int second = mTime % 60;
                mLabel.text = string.Format(mText, GetTimeString(hour), GetTimeString(minute), GetTimeString(second));
            }
            else
            {
                mGameTimer.Stop();
                mLabel.text = mFinish;

                if (mFinishCallback != null)
                {
                    mFinishCallback();
                }
            }
        }

        private string GetTimeString(int time)
        {
            string str = time.ToString();
            if (time < 10)
            {
                str = "0" + time.ToString();
            }
            return str;
        }

        public void Dispose()
        {
            mLabel = null;
            if (mGameTimer != null)
            {
                mGameTimer.Dispose();
                mGameTimer = null;
            }
        }

        private int mTime = 0;
        private UILabel mLabel = null;
        private string mText = "";
        private string mFinish = "";
        private GameTimer mGameTimer = null;
        private Action mFinishCallback;
    }
}
