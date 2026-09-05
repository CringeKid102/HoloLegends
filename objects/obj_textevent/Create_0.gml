if(instance_number(obj_textevent)>1 or instance_number(obj_textbox)>0){ instance_destroy(); exit; }

//-----------Customise (FOR USER)
myVoice			= snd_voice2;
myTextCol		= c_white;
myPortrait		= -1;
myFont			= fnt_dialogue;
myName			= "None";

//-----------Setup (LEAVE THIS STUFF)
myTextbox   = noone;
// Initialize dialogue variables
myText = -1;
mySpeaker = -1;
myEffects = -1;
myTextSpeed = -1;
myTypes = 0;
myNextLine = -1;
myScripts = -1;
myTextCol_array = -1;
myEmotion = -1;
myEmote = -1;