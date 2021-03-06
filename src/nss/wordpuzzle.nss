void d(string m) {
  SendMessageToPC(GetFirstPC(), m);
}

void main()
{
  object oPC, oPlaceable;
  string sLetter, sSolution = "ABCE";                     // enter the solution here
  int nObjectType = GetObjectType(OBJECT_SELF);           // type used to identify the object
    d("start\n"+ sSolution +"\n"+ IntToString(nObjectType));         // debug msg

  if (nObjectType ==  OBJECT_TYPE_TRIGGER)                // we assume, it's one of the painted trigger's
  {
    oPC = GetEnteringObject();                            // the entering object is the player
    oPlaceable = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, GetLocation(oPC));  // get the nearest placeable with the letter
    sLetter = GetName(oPlaceable);                        // the letter is on the placeable's name
      d("trigger\n"+ GetName(oPC) +"\n"+ GetName(oPlaceable) +"\n"+ sLetter);         // debug msg

    if (FindSubString(GetLocalString(oPC, "word"), sLetter) == -1)  // only add if it isn't found yet
    {
      SetLocalString(oPC, "word", GetLocalString(oPC, "word") + sLetter);  // set the letter to the collected letter's
        d("saved\n"+ GetLocalString(oPC, "word"));        // debug msg
    }
  }

  if (nObjectType == OBJECT_TYPE_DOOR)                    // it's the door
  {
    oPC = GetClickingObject();                            // so the clicker is the pc
      d("door\n"+ GetName(oPC) +"\n"+ GetName(OBJECT_SELF));    // debug msg

    if (GetLocalString(oPC, "word") == sSolution)         // only unlock if he collected the right letters in the right order
    {
      SetLocked(OBJECT_SELF, FALSE);                      // unlock it
      SendMessageToPC(oPC, "Door unlocked!");             // and send a message to the player
      DeleteLocalString(oPC, "word");                     // delete the passphrase
    }
  }
}

