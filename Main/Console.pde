/*--------------------------------------------------------------------------------------
 * Author: terahurtz
 *         Revised by Lihao Guo
 * 
 * Class: Console
 *
 * Descripition: A Console which promote user to input 
 *
 * The basic console class is provided by 
 *                         https://forum.processing.org/one/topic/taking-user-input.html
 *
 *--------------------------------------------------------------------------------------*/
class Console
{ 
  float x;
  float y;
  String chars;
  int numChars;
  boolean active;
  int font;
  int gap;
  String Output;
  String Record;
  String Tip;

  Console(float x, float y, int font)
  {
    this.x = x;
    this.y = y;
    active = false;
    this.font = font;
    chars = "";
    Tip = "Here is the result. ";
    numChars = 0;
    gap = font + 6;
    Output = "";
    Record = "";
  }

  void display()
  {
    // Set the color
    stroke(255);

    fill(0);
    strokeWeight(1);
    rect(x, y + 5, 230, 24);

    // Here are Input Box for file
    fill(255);
    textSize(font);
    text("Please Input A File Name and Press Enter to Draw the Line", x, y);
    text(chars, x + 5, y + gap);
    text(" .in", 230 + x, y + gap);
    fill(220, 20, 60);
    text(Tip, x, y + 2 * gap );

    // Here are some Key setting
    fill(100);
    rect(510, y - 10, 280, 60);
    fill(0);
    textSize(11);
    text("Press F1 to move/stop line sweep", 515, y + 5);
    text("Press F2 to sweep line once", 515, y + 5 + 11);
    text("Press F3 to Reset Canvas", 515, y + 5 + 2 * 11);
    text("Press Enter with empty filename to reload", 515, y + 5 + 3 * 11);

    // Output of Sweeping
    fill(15, 111, 55, 255);
    rect(803, 1, 395, 466);
    fill(255);
    textSize(15);
    text("Output:", 805, 15);
    textSize(12);
    fill(69, 245, 66, 255);
    text(Output, 805, 18, 395, 300);
    fill(255);
    text("----------------Record-----------------------------------", 805, 300, 395, 15);
    fill(69, 245, 255, 255);
    text(Record, 805, 300, 395, 150);
  }

  void addChar(char c)
  {
    if (numChars < 25) {
      chars += c;
      numChars++;
    } else
      Tip = "The maximum length has been reached";
  }

  // ReadString by Console
  String readString()
  {
    return chars;
  }

  // Check Console is Activate or Not
  boolean isActive()
  {
    return active;
  }

  // Activate the Console
  void activate()
  {
    active = true;
  }

  // Deactivate the Console
  void deactivate()
  {
    active = false;
  }

  // Reset the Console
  void reset()
  {
    chars = "";
    numChars = 0;
    Tip = "";
    Output ="";
    Record ="";
  }
  
  //Delete Char one by one
  void deleteChar()
  {
    if (numChars > 0)
    {        
      chars = chars.substring(0, chars.length()-1);
      numChars -= 1;
    }
  }

  // Set Tip for Console
  void setTip(String tip) {
    Tip = tip;
  }

  // Set Record for intersection lines
  void setRecord(String rec) {
    Record = Record + "\n" + rec;
  }

  // Set SkipList output For debug
  void setOutput(String out) {
    Output = out;
  }
}


/********************************************************************
 *  This method will Analyze the key input
*******************************************************************/
String keyAnalyzer(char c)
{
  if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' || c == '5' || c == '6' || c == '7' || c == '8' || c == '9')
  {
    return "NUMBER";
  } else if (c == 'A' || c == 'a' || c == 'B' || c == 'b' || c == 'C' || c == 'c' || c == 'D' || c == 'd' || c == 'E' || c == 'e' ||
    c == 'F' || c == 'f' || c == 'G' || c == 'g' || c == 'H' || c == 'h' || c == 'I' || c == 'i' || c == 'J' || c == 'j' ||
    c == 'K' || c == 'k' || c == 'L' || c == 'l' || c == 'M' || c == 'm' || c == 'N' || c == 'n' || c == 'O' || c == 'o' ||
    c == 'P' || c == 'p' || c == 'Q' || c == 'q' || c == 'R' || c == 'r' || c == 'S' || c == 's' || c == 'T' || c == 't' ||
    c == 'U' || c == 'u' || c == 'V' || c == 'v' || c == 'W' || c == 'w' || c == 'X' || c == 'x' || c == 'Y' || c == 'y' ||
    c == 'Z' || c == 'z' || c == '.')
  {
    return "LETTER";
  } else
  {
    return "OTHER";
  }
}
