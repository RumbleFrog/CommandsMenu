# CommandsMenu [![Build Status](https://travis-ci.org/RumbleFrog/CommandsMenu.svg?branch=master)](https://travis-ci.org/RumbleFrog/CommandsMenu)
Display a menu of commands parsed a simple config file

# Usage
sm_commands (!commands | /commands)

# Installation

- Extract commandsmenu.cfg to addons/sourcemod/configs/
- Extract commandsmenu.smx to addons/sourcemod/plugins/

# Config file

```
DisplayName;Info
```

**DisplayName** is what will show up in the menu

**Info** is what will show up in chat if pressed or the content of the submenu

The fields are separated by semi-colon

One entry per line

### Example

```
!command;Displays current menu
```

# Download 

Download the latest version from the [release](https://github.com/RumbleFrog/CommandsMenu/releases) page

# License
MIT
