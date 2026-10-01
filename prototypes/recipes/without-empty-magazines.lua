local container_recipes = {
    ["empty-magazine"] = "empty-recipe",
    ["empty-shotgun-shell"] = "empty-shotgun-recipe",
    ["empty-high-capacity-magazine"] = "empty-high-capacity-recipe",
    ["empty-high-capacity-shotgun-shell"] = "empty-high-capacity-shotgun-recipe",
    ["advanced-magazine"] = "advanced-recipe",
    ["advanced-high-capacity-magazine"] = "advanced-high-capacity-recipe",
    ["advanced-shotgun-shell"] = "advanced-shotgun-recipe"
}

-- Only change ammunition recipes owned or modified by More Ammo.
local ammo_recipes = {
    "firearm-magazine", "piercing-rounds-magazine", "uranium-rounds-magazine",
    "shotgun-shell", "piercing-shotgun-shell", "uranium-shotgun-recipe",
    "acid-ammo-recipe", "fire-ammo-recipe", "fmj-ammo-recipe", "sp-ammo-recipe",
    "tungsten-ammo-recipe", "he-ammo-recipe", "water-recipe",
    "beryllium-ammo-recipe", "cryonite-ammo-recipe", "iridium-ammo-recipe",
    "naquium-ammo-recipe", "vulcanite-ammo-recipe", "vulcanite-shotgun-recipe"
}

local recycling = mods["quality"] and require("__quality__.prototypes.recycling")

local function add_ingredient(ingredients, ingredient, multiplier)
    local copy = table.deepcopy(ingredient)
    copy.amount = copy.amount * multiplier
    for _, existing in ipairs(ingredients) do
        if existing.type == "item" and copy.type == "item" and existing.name == copy.name then
            existing.amount = existing.amount + copy.amount
            return
        end
    end
    table.insert(ingredients, copy)
end

local function replace_containers(recipe)
    if not recipe then
        return
    end

    local ingredients = {}
    local changed = false
    for _, ingredient in ipairs(recipe.ingredients) do
        local container_recipe_name = container_recipes[ingredient.name]
        local container_recipe = container_recipe_name and data.raw.recipe[container_recipe_name]
        if ingredient.type == "item" and container_recipe then
            changed = true
            -- Each More Ammo container recipe produces one container. Read its
            -- actual ingredients so configured high-capacity costs are retained.
            for _, material in ipairs(container_recipe.ingredients) do
                add_ingredient(ingredients, material, ingredient.amount)
            end
        else
            add_ingredient(ingredients, ingredient, 1)
        end
    end
    if changed then
        recipe.ingredients = ingredients
        -- Quality creates recycling recipes in data-updates, before this pass.
        -- Refresh existing ones so they return materials instead of empty containers.
        if recycling then
            for _, result in ipairs(recipe.results) do
                if data.raw.recipe[result.name .. "-recycling"] then
                    recycling.generate_recycling_recipe(recipe)
                    break
                end
            end
        end
    end
end

for _, recipe_name in ipairs(ammo_recipes) do
    replace_containers(data.raw.recipe[recipe_name])
    replace_containers(data.raw.recipe["high-capacity-" .. recipe_name])
end
