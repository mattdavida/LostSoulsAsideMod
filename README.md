# Lost Soul Aside - Simple Cheats

Keybind cheats to keep the power from the intro + console commands for game breaking features.

## What This Does

### Hotkeys:
- **F4**: God Mode - 9999 HP/ATK/Mana/Gold + 100% Crit + Break shields
- **F5**: Toggle Ultimate Form - Transform like in the intro
- **F6**: Max Attack (9999)  
- **F7**: Gold Multiplier (9999)
- **F8**: 100% Critical Hits
- **F9**: Max Mana (9999)
- **5**: Max HP (9999)

### Console Commands (open console with ~):
- `add_item <id> <qty>` - Add specific items (see all_items.jsonc for IDs)
- `add_all_items` - Add one of every item in the game
- `add_all_weapons` - Adds every weapon in the game instantly
- `toggle_fly` - Toggle flight mode for unlimited exploration + noclip

## Requirements

- UE4SS Framework (latest from GitHub)
- Download: https://github.com/UE4SS-RE/RE-UE4SS/releases

## Installation

1. Install UE4SS to: `<Game>/Projectlsa/Binaries/Win64/`
2. Extract this mod to: `<Game>/Binaries/Win64/ue4ss/Mods/`
3. Add `SimpleCheats : 1` to `ue4ss/Mods/mods.txt`
4. Launch game, press F4 for god mode or F5 for ultimate form
5. Open console with `~` key for weapon/flight commands

## Item Database

For the `add_item` command, check **`all_items.jsonc`** for complete item reference:
- **366 items mapped** from weapons to accessories to materials
- Easy to browse: `{"19001": "Empire Glory", "31119": "Ring of Lording"}`
- Find exactly what you need for your build

### Examples:
- `add_item 19001 1` - Empire Glory (weapon)
- `add_item 31119 1` - Ring of Lording (accessory)  
- `add_item 100000 999` - Divine Gold (currency)

## Notes

- Works with any save file, new or existing
- F5 toggles the ultimate transformation on/off
- `add_item`: Target specific accessories/materials for builds
- `add_all_items`: Includes developer testing items
- `add_all_weapons` gives access to entire weapon arsenal  
- `toggle_fly` allows unlimited exploration and movement + noclip 
- Compatible with other visual/performance mods  
- No story progression required for anything

For players who want complete freedom to experience the game without limitations.

## Download

Available on [Nexus Mods](https://www.nexusmods.com/lostsoulaside/mods/12)
