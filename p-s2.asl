// Post-Shift 2 AutoSplitter by Derric Young with Assistance from ero, jstme and others

// State's (This is Neccessary as Autosplitters Requiare This for Proper Funtion)
state("Post-Shift 2 Part A ver1-0-0") {}
state("post-shift-2-part-a-v1.0.1") {}
state("post-shift-2-part-a-release-ver1-0-2") {}
state("Post-Shift 2 Part B ver1-0-0") {}
state("Post-Shift 2 Part B Release ver1-0-1") {}
// the EXE Names Here happen to Be the Defualt EXE Names This Game was Distributed With
// This is the Init Code. Its Purpose is to Get the Code Scan for the Game, Detects if its Part A or B and Sets the Values for the Proper Code Execution.
init
{
//  This Code Scans For the Current Frame Number. The Frame Number is the Scene like on Other Game Engines. Just Refered to as Frames in Clickteam Fusion 2.5
    var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
    var ptr = scanner.Scan(new SigScanTarget(2, "8B 3D ???????? 8B F7"));
    if (ptr == IntPtr.Zero) throw new NullReferenceException("Sigscanning failed!");
    vars.FrameID = new MemoryWatcher<int>(new DeepPointer(game.ReadPointer(ptr), game.ReadValue<int>(ptr + 0xC)));
//  This Part Replaces the Current EXE Names to instead of being for example being post-shift-2-part-a is instead replaced with post shift 2 part a. also  defualts vars.version to X
    var gameName = game.ProcessName.ToLower().Replace("-", " ");
    vars.version = 'X';
//  This Detects if the Game is Part A or Part B
    if (gameName.Contains("part a"))
    {
        version = "Part A";
        vars.version = 'A';
    }
    else if (gameName.Contains("part b"))
    {
        version = "Part B";
        vars.version = 'B';
    }
    timer.IsGameTimePaused = false;
}
// This Pauses the Timer when None of the Parts are Open. the Timer is Unpaused With the Last Line of the Init Code.
exit
{
    timer.IsGameTimePaused = true;
}
// This is the Update Code. The First and Second Line
update
{
    if (vars.version == 'X')
        return false;

    vars.FrameID.Update(game);


    switch ((char)vars.version)
    {
        case 'A':
      //  	print("Part A Detected");
            	break;
        case 'B':
      //  	print("Part B Detected");
            	break;
    }
}
// this is the start code. what it does is it starts the timer. frameid 13 and 14 are cutscene splits for either the intro to the game or the minatar ballora cutscene. 3 and 2 are just the load screens.
start {
   if(vars.FrameID.Current == 13 && vars.FrameID.Old == 2 && version == "Part A" || 
	vars.FrameID.Current == 3 && vars.FrameID.Old == 2 && version == "Part A" || 
	vars.FrameID.Current == 10 && vars.FrameID.Old == 2 && version == "Part A" || 
	vars.FrameID.Current == 14 && vars.FrameID.Old == 1 && version == "Part B" || 
	vars.FrameID.Current == 2 && vars.FrameID.Old == 1 && version == "Part B") {
    return true;
  }
}
// Resetting. This Only Resets on the Intro Cutscene of Part A. Nothing Else
reset {
  if(vars.FrameID.Current == 13 && vars.FrameID.Old == 2 && version == "Part A") {
    return true;
  }
}
// Splits. This Contains All the Splitting Funtonality of the Game. From Part A to B
split {
  if(vars.FrameID.Current == 2 && vars.FrameID.Old == 1 && version == "Part B" || 
	vars.FrameID.Current == 14 && vars.FrameID.Old == 1 && version == "Part B" || 
	vars.FrameID.Current == 7 && vars.FrameID.Old == 8 && version == "Part B" || 
	vars.FrameID.Current == 15 && vars.FrameID.Old == 7 && version == "Part B" || 
	vars.FrameID.Current == 16 && vars.FrameID.Old == 7 && version == "Part B" || 
	vars.FrameID.Current == 17 && vars.FrameID.Old == 7 && version == "Part B" || 
	vars.FrameID.Current == 17 && vars.FrameID.Old == 8 && version == "Part B" || 
	vars.FrameID.Current == 1 && vars.FrameID.Old == 7 && version == "Part B" || 
	vars.FrameID.Current == 18 && vars.FrameID.Old == 7 && version == "Part B" || 
	vars.FrameID.Current == 3 && vars.FrameID.Old == 2 && version == "Part A" || 
	vars.FrameID.Current == 6 && vars.FrameID.Old == 5 && version == "Part A" || 
	vars.FrameID.Current == 7 && vars.FrameID.Old == 6 && version == "Part A" || 
	vars.FrameID.Current == 2 && vars.FrameID.Old == 7 && version == "Part A" || 
	vars.FrameID.Current == 9 && vars.FrameID.Old == 7 && version == "Part A" || 
	vars.FrameID.Current == 2 && vars.FrameID.Old == 18 && version == "Part B" || 
	vars.FrameID.Current == 18 && vars.FrameID.Old == 8 && version == "Part B") {
    return true;
  }
}