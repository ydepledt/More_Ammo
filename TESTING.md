# Optional empty magazines and shells

In **Settings > Mod settings > Startup > More Ammo**, disable **Require empty
magazines and shells**, apply the change and restart Factorio.

All ammunition recipes provided or modified by More Ammo then use the materials
from their empty container recipes directly. This includes extended magazines,
compressed shotgun shells and Space Exploration's advanced magazines. Filled
ammunition used in upgrade recipes is still required. Container items and recipes
remain available for existing saves and other mods.

The option is enabled by default, preserving the mod's existing recipes. Crafting
times, ammunition output, technology unlocks and damage settings are unchanged.

## Manual check (Factorio 2.0)

Use a separate test save. Install the modified mod as a folder named
`More_Ammo_1.5.22` or a ZIP containing that folder in your Factorio mods directory.
Back up an existing copy of the same mod version before replacing it.

1. With the option enabled, confirm that a firearm magazine requires an empty
   magazine and two iron plates.
2. Disable the option and restart. Confirm the following costs with the other
   mod settings at their defaults:

   | Ammunition | Ingredients |
   | --- | --- |
   | Firearm magazine | 4 iron plates |
   | Shotgun shells | 2 iron plates + 2 copper plates |
   | Full-metal-jacket magazine | 5 iron plates + 3 steel plates + 2 copper plates |
   | Extended firearm magazine | 8 iron plates |
   | Acid magazine | 7 iron plates + 4 steel plates + 10 sulfuric acid |

3. Craft basic ammunition without any empty containers in your inventory.
4. Enable/disable extended magazines and change their container cost multipliers;
   the direct material costs should include the configured container costs.
5. With Quality/Space Age enabled, check that recycling affected ammunition
   returns materials rather than empty containers.
6. If Space Exploration is installed, check its ammunition recipes also replace
   advanced magazines with their iron, steel and plastic costs.
7. Re-enable the option and restart to restore the original container ingredients.

French setting label: **Exiger des chargeurs et douilles vides**.
