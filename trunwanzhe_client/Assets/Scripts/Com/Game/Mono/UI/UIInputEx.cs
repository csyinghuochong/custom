using UnityEngine;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

public class UIInputEx : UIInput
{
    System.Text.RegularExpressions.Regex mRegex = new System.Text.RegularExpressions.Regex(@"^[\u4e00-\u9fa5]+$");
    protected int GetStringLength(string str)
    {
        int count = 0;
        for (int i = 0, imax = str.Length; i < imax; ++i)
        {
            count += this.GetCharCount(str[i].ToString());
        }
        return count;
    }

    protected int GetCharCount(string s)
    {
        return mRegex.IsMatch(s) ? 2 : 1; 
    }
    protected override void Insert (string text)
	{
		string left = GetLeftText();
		string right = GetRightText();
		int rl = right.Length;
        int characterCount = this.GetStringLength(this.value);

		StringBuilder sb = new StringBuilder(left.Length + right.Length + text.Length);
		sb.Append(left);
        
		// Append the new text
		for (int i = 0, imax = text.Length; i < imax; ++i)
		{
			// If we have an input validator, validate the input first
			char c = text[i];
			if (c == '\b')
			{
				DoBackspace();
				continue;
			}

            int tempCharacterCount = characterCount + this.GetCharCount(c.ToString());
			// Can't go past the character limit
            if (characterLimit > 0 && tempCharacterCount >= characterLimit) break;
            
			if (onValidate != null) c = onValidate(sb.ToString(), sb.Length, c);
			else if (validation != Validation.None) c = Validate(sb.ToString(), sb.Length, c);

			// Append the character if it hasn't been invalidated
            if (c != 0)
            {
                sb.Append(c);
                characterCount = tempCharacterCount;
            }
		}

		// Advance the selection
		mSelectionStart = sb.Length;
		mSelectionEnd = mSelectionStart;

		// Append the text that follows it, ensuring that it's also validated after the inserted value
		for (int i = 0, imax = right.Length; i < imax; ++i)
		{
			char c = right[i];
			if (onValidate != null) c = onValidate(sb.ToString(), sb.Length, c);
			else if (validation != Validation.None) c = Validate(sb.ToString(), sb.Length, c);
			if (c != 0) sb.Append(c);
		}

		mValue = sb.ToString();
		UpdateLabel();
		ExecuteOnChange();
	}
}
