/*--------------------------------------------------------------------------------------
 * Author: terahurtz
 *         Revised by Lihao Guo
 * 
 * Class: Console
 *
 * Descripition: A Console which promote user to input 
 *
 * The console class is provided by 
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
    textSize(13);
    text("Press F1 to move/stop line sweep", 515, y + 5);
    text("Press F2 to sweep line once", 515, y + 5 + font);
    text("Press F3 to Reset Canvas", 515, y + 5 + 2 * font);
  }

  void addChar(char c)
  {
    if (numChars < 25) {
      chars += c;
      numChars++;
    } else
      Tip = "The maximum length has been reached";
  }

  String readString()
  {
    return chars;
  }

  boolean isActive()
  {
    return active;
  }

  void activate()
  {
    active = true;
  }

  void deactivate()
  {
    active = false;
  }

  void reset()
  {
    chars = "";
  }

  void deleteChar()
  {
    if (numChars > 0)
    {        
      chars = chars.substring(0, chars.length()-1);
      numChars -= 1;
    }
  }

  void setTip(String tip) {
    Tip = tip;
  }
}


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
