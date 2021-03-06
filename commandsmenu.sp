/**
MIT License

Copyright (c) 2017 RumbleFrog

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
**/

#pragma semicolon 1

#define PLUGIN_AUTHOR "RumbleFrog"
#define PLUGIN_VERSION "1.0.0"

#include <sourcemod>
#include <sdktools>

#pragma newdecls required

Handle cb;
Menu Commands;

public Plugin myinfo = 
{
	name = "Commands Menu",
	author = PLUGIN_AUTHOR,
	description = "Retrieve a list of commands",
	version = PLUGIN_VERSION,
	url = "https://keybase.io/rumblefrog"
};

public void OnPluginStart()
{
	cb = CreateArray(64);
	
	ParseConfig();
	
	Commands = BuildCommandMenu();
	
	RegAdminCmd("sm_commands", CmdGetCommands, 0, "Get commands available");
}

public Action CmdGetCommands(int client, int args)
{
	if (Commands == null)
	{
		PrintToChat(client, "Command list not found");
	}
	
	Commands.Display(client, MENU_TIME_FOREVER);
	
	return Plugin_Handled;
}

bool ParseConfig()
{
	char path[PLATFORM_MAX_PATH];
	char line[1024];
	
	BuildPath(Path_SM, path, sizeof(path), "configs/commandsmenu.cfg");
	
	if (FileExists(path, true))
	{
		Handle list = OpenFile(path, "r");
		
		while (!IsEndOfFile(list) && ReadFileLine(list, line, sizeof(line)))
		{
			TrimString(line);
			PushArrayString(cb, line);
		}
		
		CloseHandle(list);
		
		return true;
	
	}
	else 
	{
		return false;
	}

}

Menu BuildCommandMenu()
{
	char buffer[64];
	char pieces[2][512];
	Menu menu = new Menu(Menu_Commands);
	
	for (int i = 0; i < GetArraySize(cb); i++)
	{
		GetArrayString(cb, i, buffer, sizeof(buffer));
		ExplodeString(buffer, ";", pieces, sizeof(pieces), sizeof(pieces[]));
		menu.AddItem(pieces[1], pieces[0]);
	}
	
	menu.SetTitle("List of commands");
	
	return menu;
}

public int Menu_Commands(Menu menu, MenuAction action, int param1, int param2)
{
	if (action == MenuAction_Select)
	{
		char info[512];
		
		menu.GetItem(param2, info, sizeof(info));
		PrintToChat(param1, "%s", info);
	}
}