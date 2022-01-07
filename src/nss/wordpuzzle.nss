void main()
{
  object oPC, oPlaceable;
  string sLetter, sSolution = "NOSE";                     // enter the solution here
  int nObjectType = GetObjectType(OBJECT_SELF);           // type used to identify the object

  if (nObjectType ==  OBJECT_TYPE_TRIGGER)                // we assume, it's one of the painted trigger's
  {
    oPC = GetEnteringObject();                            // the entering object is the player
    oPlaceable = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, GetLocation(oPC));  // get the nearest placeable with the letter
    sLetter = GetName(oPlaceable);                        // the letter is on the placeable's name

    if (FindSubString(GetLocalString(oPC, "word"), sLetter) == -1)  // only add if it isn't found yet
      SetLocalString(oPC, "word", GetLocalString(oPC, "word") + sLetter);  // set the letter to the collected letter's
  }

  if (nObjectType == OBJECT_TYPE_DOOR)                    // it's the door
  {
    oPC = GetClickingObject();                            // so the clicker is the pc
    if (GetLocalString(oPC, "word") == sSolution)         // only unlock if he collected the right letters in the right order
    {
      SetLocked(OBJECT_SELF, FALSE);                      // unlock it
      SendMessageToPC(oPC, "Door unlocked!");             // and send a message to the player
      DeleteLocalString(oPC, "word");                     // delete the passphrase
    }
  }
}

