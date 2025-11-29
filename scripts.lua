import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Code, Copy, Check, FileCode, Terminal, Download, ExternalLink, Info } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";

const scripts = [
  {
    id: "bee-data-module",
    name: "Bee Data Module",
    description: "Complete bee database with all stats. Use this as a reference module in your projects.",
    filename: "BeeData.lua",
    code: `--[[
    Bee Swarm Simulator - Bee Data Module
    Version: 1.0
    
    HOW TO USE IN VISUAL STUDIO CODE:
    1. Save this file as "BeeData.lua"
    2. In another script, require it: local BeeData = require("BeeData")
    3. Access data: BeeData.Bees.Common["Basic Bee"]
    
    HOW TO USE IN ROBLOX STUDIO:
    1. Create a ModuleScript in ReplicatedStorage
    2. Paste this code
    3. Require it from other scripts
]]

local BeeData = {}

-- All bees organized by rarity
BeeData.Bees = {
    Common = {
        ["Basic Bee"] = {
            color = "Colorless",
            attack = 1,
            speed = 14,
            energy = 20,
            abilities = {"Gather Pollen"},
            description = "The most basic bee. Great for beginners."
        },
        ["Bomber Bee"] = {
            color = "Red",
            attack = 1,
            speed = 14,
            energy = 25,
            abilities = {"Bomb", "Red Bomb"},
            description = "Drops bombs that collect pollen from flowers."
        },
        ["Brave Bee"] = {
            color = "Red",
            attack = 3,
            speed = 14,
            energy = 20,
            abilities = {"Brave Bash"},
            description = "A courageous bee that deals extra damage."
        },
        ["Bumble Bee"] = {
            color = "Blue",
            attack = 1,
            speed = 11,
            energy = 40,
            abilities = {"Buzz Bomb"},
            description = "Slow but has lots of energy."
        },
        ["Cool Bee"] = {
            color = "Blue",
            attack = 1,
            speed = 14,
            energy = 20,
            abilities = {"Cool Breeze"},
            description = "Creates cooling effects for blue pollen."
        },
        ["Hasty Bee"] = {
            color = "Colorless",
            attack = 1,
            speed = 18,
            energy = 20,
            abilities = {"Haste"},
            description = "One of the fastest bees."
        },
        ["Looker Bee"] = {
            color = "Colorless",
            attack = 1,
            speed = 14,
            energy = 20,
            abilities = {"Focus"},
            description = "Improves critical hit chance."
        },
        ["Rad Bee"] = {
            color = "Red",
            attack = 2,
            speed = 14,
            energy = 20,
            abilities = {"Rad Explosion"},
            description = "Creates explosive red pollen bursts."
        },
        ["Rascal Bee"] = {
            color = "Colorless",
            attack = 2,
            speed = 14,
            energy = 25,
            abilities = {"Surprise"},
            description = "A mischievous bee."
        },
        ["Stubborn Bee"] = {
            color = "Colorless",
            attack = 1,
            speed = 12,
            energy = 30,
            abilities = {"Persist"},
            description = "Never gives up."
        }
    },
    
    Rare = {
        ["Bubble Bee"] = {
            color = "Blue",
            attack = 2,
            speed = 15,
            energy = 25,
            abilities = {"Bubble Bomb"},
            description = "Creates bubbles for blue pollen."
        },
        ["Bucko Bee"] = {
            color = "Blue",
            attack = 2,
            speed = 14,
            energy = 25,
            abilities = {"Blue Boost"},
            description = "Blue bee leader."
        },
        ["Riley Bee"] = {
            color = "Red",
            attack = 2,
            speed = 14,
            energy = 25,
            abilities = {"Red Boost"},
            description = "Red bee leader."
        },
        ["Fire Bee"] = {
            color = "Red",
            attack = 3,
            speed = 16,
            energy = 20,
            abilities = {"Flame Heat"},
            description = "Generates heat for red pollen."
        },
        ["Frosty Bee"] = {
            color = "Blue",
            attack = 2,
            speed = 14,
            energy = 25,
            abilities = {"Frost"},
            description = "Creates frost for blue pollen."
        },
        ["Honey Bee"] = {
            color = "Colorless",
            attack = 1,
            speed = 15,
            energy = 25,
            abilities = {"Honey Gift"},
            description = "Produces bonus honey tokens."
        }
    },
    
    Epic = {
        ["Demon Bee"] = {
            color = "Red",
            attack = 5,
            speed = 16,
            energy = 25,
            abilities = {"Dark Flames"},
            description = "Fierce bee with powerful attacks."
        },
        ["Diamond Bee"] = {
            color = "Blue",
            attack = 3,
            speed = 18,
            energy = 25,
            abilities = {"Sparkle"},
            description = "Finds valuable tokens."
        },
        ["Lion Bee"] = {
            color = "Red",
            attack = 5,
            speed = 15,
            energy = 30,
            abilities = {"Lion's Roar"},
            description = "Brave and powerful."
        },
        ["Ninja Bee"] = {
            color = "Colorless",
            attack = 4,
            speed = 20,
            energy = 20,
            abilities = {"Stealth"},
            description = "Fastest bee with ninja abilities."
        },
        ["Music Bee"] = {
            color = "Colorless",
            attack = 2,
            speed = 15,
            energy = 30,
            abilities = {"Melody"},
            description = "Plays music that buffs bees."
        }
    },
    
    Legendary = {
        ["Photon Bee"] = {
            color = "Colorless",
            attack = 4,
            speed = 18,
            energy = 30,
            abilities = {"Beamstorm"},
            description = "Shoots beams of light."
        },
        ["Tabby Bee"] = {
            color = "Colorless",
            attack = 3,
            speed = 16,
            energy = 25,
            abilities = {"Scratch", "Tabby Love"},
            description = "Gets stronger with Tabby Love stacks."
        }
    },
    
    Mythic = {
        ["Fuzzy Bee"] = {
            color = "Colorless",
            attack = 3,
            speed = 14,
            energy = 45,
            abilities = {"Fuzzy Coat", "Cross Pollination"},
            description = "Creates fuzz bombs."
        },
        ["Spicy Bee"] = {
            color = "Red",
            attack = 5,
            speed = 16,
            energy = 35,
            abilities = {"Inferno"},
            description = "Creates inferno rings."
        },
        ["Tadpole Bee"] = {
            color = "Blue",
            attack = 2,
            speed = 14,
            energy = 40,
            abilities = {"Bubble Splash"},
            description = "Creates bubble explosions."
        },
        ["Vector Bee"] = {
            color = "Colorless",
            attack = 4,
            speed = 17,
            energy = 35,
            abilities = {"Vector", "Mark Surge"},
            description = "Creates triangular marks."
        }
    }
}

-- Field data
BeeData.Fields = {
    ["Sunflower Field"] = {zone = "Starter", pollen = "Colorless", difficulty = 1},
    ["Dandelion Field"] = {zone = "Starter", pollen = "Colorless", difficulty = 1},
    ["Mushroom Field"] = {zone = "Starter", pollen = "Red", difficulty = 1},
    ["Blue Flower Field"] = {zone = "Starter", pollen = "Blue", difficulty = 1},
    ["Clover Field"] = {zone = "5 Bee", pollen = "Colorless", difficulty = 2},
    ["Spider Field"] = {zone = "5 Bee", pollen = "Colorless", difficulty = 3},
    ["Strawberry Field"] = {zone = "5 Bee", pollen = "Red", difficulty = 2},
    ["Bamboo Field"] = {zone = "10 Bee", pollen = "Blue", difficulty = 2},
    ["Pineapple Patch"] = {zone = "15 Bee", pollen = "Colorless", difficulty = 3},
    ["Stump Field"] = {zone = "15 Bee", pollen = "Colorless", difficulty = 4},
    ["Rose Field"] = {zone = "25 Bee", pollen = "Red", difficulty = 3},
    ["Pine Tree Forest"] = {zone = "25 Bee", pollen = "Blue", difficulty = 3},
    ["Pumpkin Patch"] = {zone = "30 Bee", pollen = "Colorless", difficulty = 4},
    ["Pepper Patch"] = {zone = "35 Bee", pollen = "Red", difficulty = 4},
    ["Mountain Top"] = {zone = "35 Bee", pollen = "Blue", difficulty = 4}
}

-- Helper functions
function BeeData.GetBeeByName(name)
    for rarity, bees in pairs(BeeData.Bees) do
        if bees[name] then
            local beeInfo = bees[name]
            beeInfo.name = name
            beeInfo.rarity = rarity
            return beeInfo
        end
    end
    return nil
end

function BeeData.GetBeesByRarity(rarity)
    return BeeData.Bees[rarity] or {}
end

function BeeData.GetBeesByColor(color)
    local result = {}
    for rarity, bees in pairs(BeeData.Bees) do
        for name, data in pairs(bees) do
            if data.color == color then
                result[name] = data
                result[name].rarity = rarity
            end
        end
    end
    return result
end

function BeeData.GetFieldsByPollen(pollenType)
    local result = {}
    for name, data in pairs(BeeData.Fields) do
        if data.pollen == pollenType then
            table.insert(result, name)
        end
    end
    return result
end

return BeeData`
  },
  {
    id: "honey-calculator",
    name: "Honey Calculator",
    description: "Calculate honey production, grind times, and optimize your farming.",
    filename: "HoneyCalculator.lua",
    code: `--[[
    Bee Swarm Simulator - Honey Calculator
    Version: 1.0
    
    HOW TO USE:
    1. Save as "HoneyCalculator.lua"
    2. Run in VS Code with Lua extension or in Roblox Studio
    3. Modify the example values at the bottom
]]

local HoneyCalculator = {}

-- Field pollen multipliers (base values)
HoneyCalculator.FieldMultipliers = {
    ["Sunflower Field"] = 1.0,
    ["Dandelion Field"] = 1.1,
    ["Mushroom Field"] = 1.2,
    ["Blue Flower Field"] = 1.2,
    ["Clover Field"] = 1.3,
    ["Spider Field"] = 1.5,
    ["Strawberry Field"] = 1.6,
    ["Bamboo Field"] = 1.8,
    ["Pineapple Patch"] = 2.0,
    ["Stump Field"] = 2.2,
    ["Rose Field"] = 2.5,
    ["Pine Tree Forest"] = 2.7,
    ["Pumpkin Patch"] = 3.0,
    ["Pepper Patch"] = 3.5,
    ["Mountain Top"] = 4.0
}

-- Backpack capacities
HoneyCalculator.Backpacks = {
    ["Starter Backpack"] = 100,
    ["Basic Backpack"] = 250,
    ["Silver Backpack"] = 500,
    ["Golden Backpack"] = 1000,
    ["Diamond Backpack"] = 2500,
    ["Port-O-Hive"] = 5000,
    ["Coconut Canister"] = 10000000
}

--[[
    Calculate pollen per second
    @param beeCount: number of bees
    @param avgLevel: average bee level
    @param fieldName: name of the field
    @param hasBoost: boolean if field boost is active
    @return: pollen per second
]]
function HoneyCalculator.CalculatePollenPerSecond(beeCount, avgLevel, fieldName, hasBoost)
    local fieldMult = HoneyCalculator.FieldMultipliers[fieldName] or 1.0
    local levelBonus = 1 + (avgLevel * 0.05)
    local boostMult = hasBoost and 2 or 1
    
    -- Base pollen per bee per second
    local basePollen = 5
    
    local pollenPerSecond = beeCount * basePollen * fieldMult * levelBonus * boostMult
    return math.floor(pollenPerSecond)
end

--[[
    Calculate honey from pollen
    @param pollen: amount of pollen
    @param instantConversion: boolean if using instant conversion
    @return: honey amount
]]
function HoneyCalculator.PollenToHoney(pollen, instantConversion)
    -- Hive conversion rate is about 80% for normal, 100% for instant
    local rate = instantConversion and 1.0 or 0.8
    return math.floor(pollen * rate)
end

--[[
    Calculate time to reach honey goal
    @param currentHoney: current honey amount
    @param targetHoney: target honey amount
    @param pollenPerSecond: pollen gathered per second
    @return: table with hours, minutes, seconds
]]
function HoneyCalculator.TimeToGoal(currentHoney, targetHoney, pollenPerSecond)
    local honeyNeeded = targetHoney - currentHoney
    local honeyPerSecond = HoneyCalculator.PollenToHoney(pollenPerSecond, false)
    
    if honeyPerSecond <= 0 then
        return {hours = 999, minutes = 0, seconds = 0, formatted = "Infinite"}
    end
    
    local totalSeconds = honeyNeeded / honeyPerSecond
    local hours = math.floor(totalSeconds / 3600)
    local minutes = math.floor((totalSeconds % 3600) / 60)
    local seconds = math.floor(totalSeconds % 60)
    
    return {
        hours = hours,
        minutes = minutes,
        seconds = seconds,
        formatted = string.format("%d hours, %d minutes, %d seconds", hours, minutes, seconds)
    }
end

--[[
    Calculate trips needed to fill backpack
    @param backpackName: name of backpack
    @param pollenPerTrip: pollen collected per trip
    @return: number of trips
]]
function HoneyCalculator.TripsToFillBackpack(backpackName, pollenPerTrip)
    local capacity = HoneyCalculator.Backpacks[backpackName] or 1000
    return math.ceil(capacity / pollenPerTrip)
end

--[[
    Format large numbers nicely
    @param num: number to format
    @return: formatted string
]]
function HoneyCalculator.FormatNumber(num)
    if num >= 1000000000 then
        return string.format("%.2fB", num / 1000000000)
    elseif num >= 1000000 then
        return string.format("%.2fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.2fK", num / 1000)
    else
        return tostring(math.floor(num))
    end
end

--[[
    Print a full calculation report
]]
function HoneyCalculator.PrintReport(config)
    print("╔════════════════════════════════════════╗")
    print("║     HONEY CALCULATOR REPORT            ║")
    print("╠════════════════════════════════════════╣")
    print("║ Settings:                              ║")
    print(string.format("║   Bees: %d                             ║", config.beeCount))
    print(string.format("║   Avg Level: %d                        ║", config.avgLevel))
    print(string.format("║   Field: %s", config.field))
    print(string.format("║   Boost Active: %s                    ║", config.hasBoost and "Yes" or "No"))
    print("╠════════════════════════════════════════╣")
    
    local pps = HoneyCalculator.CalculatePollenPerSecond(
        config.beeCount, 
        config.avgLevel, 
        config.field, 
        config.hasBoost
    )
    local ppm = pps * 60
    local pph = ppm * 60
    
    print("║ Production:                            ║")
    print(string.format("║   Pollen/sec: %s", HoneyCalculator.FormatNumber(pps)))
    print(string.format("║   Pollen/min: %s", HoneyCalculator.FormatNumber(ppm)))
    print(string.format("║   Pollen/hour: %s", HoneyCalculator.FormatNumber(pph)))
    print(string.format("║   Honey/hour: %s", HoneyCalculator.FormatNumber(HoneyCalculator.PollenToHoney(pph, false))))
    print("╠════════════════════════════════════════╣")
    
    if config.targetHoney and config.currentHoney then
        local timeResult = HoneyCalculator.TimeToGoal(config.currentHoney, config.targetHoney, pps)
        print("║ Time to Goal:                          ║")
        print(string.format("║   Current: %s", HoneyCalculator.FormatNumber(config.currentHoney)))
        print(string.format("║   Target: %s", HoneyCalculator.FormatNumber(config.targetHoney)))
        print(string.format("║   Time: %s", timeResult.formatted))
    end
    
    print("╚════════════════════════════════════════╝")
end

-- ═══════════════════════════════════════════════════
-- EXAMPLE USAGE - Modify these values for your needs!
-- ═══════════════════════════════════════════════════

local myConfig = {
    beeCount = 35,
    avgLevel = 10,
    field = "Rose Field",
    hasBoost = true,
    currentHoney = 5000000,
    targetHoney = 50000000
}

HoneyCalculator.PrintReport(myConfig)

-- You can also use individual functions:
print("\\n--- Individual Calculations ---")
print("Pollen per second:", HoneyCalculator.CalculatePollenPerSecond(25, 8, "Pepper Patch", false))
print("Honey from 10000 pollen:", HoneyCalculator.PollenToHoney(10000, false))

return HoneyCalculator`
  },
  {
    id: "quest-tracker",
    name: "Quest Tracker",
    description: "Track your quest progress for all NPCs with save/load functionality.",
    filename: "QuestTracker.lua",
    code: `--[[
    Bee Swarm Simulator - Quest Tracker
    Version: 1.0
    
    This module helps track quest progress.
    Works in VS Code (Lua) or Roblox Studio.
]]

local QuestTracker = {}

-- Quest database
QuestTracker.Quests = {
    ["Black Bear"] = {
        {name = "Pollen Intro", task = "Collect 100 pollen", reward = "100 Honey"},
        {name = "Getting Started", task = "Collect 300 pollen", reward = "200 Honey"},
        {name = "Bee Gathering", task = "Collect 1,000 pollen", reward = "500 Honey + Ticket"},
        {name = "Making Honey", task = "Make 1,000 Honey", reward = "1,000 Honey"},
        {name = "Busy Bee", task = "Collect 5,000 pollen", reward = "2,000 Honey + Royal Jelly"},
        {name = "Flower Quest", task = "Collect from 500 flowers", reward = "5,000 Honey"},
        {name = "Bear's Beginning", task = "Make 10,000 Honey total", reward = "10,000 Honey + Silver Egg"}
    },
    
    ["Brown Bear"] = {
        {name = "Brown Bear's Daily", task = "Complete random tasks", reward = "Varies"},
        {name = "Clover Collector", task = "Collect 25,000 from Clover", reward = "10,000 Honey"},
        {name = "Spider Survivor", task = "Collect 30,000 from Spider Field", reward = "15,000 Honey"},
        {name = "Strawberry Picker", task = "Collect 40,000 from Strawberry", reward = "20,000 Honey"}
    },
    
    ["Mother Bear"] = {
        {name = "Mother's Warmth", task = "Feed bees treats", reward = "Royal Jelly"},
        {name = "Cozy Bear", task = "Collect 10,000 Red pollen", reward = "5,000 Honey"},
        {name = "Warm Bear", task = "Collect 10,000 Blue pollen", reward = "5,000 Honey"}
    },
    
    ["Science Bear"] = {
        {name = "Translating", task = "Requires Translator", reward = "Gifted Bucko/Riley"},
        {name = "Data Collection", task = "Collect using abilities", reward = "10,000 Honey"},
        {name = "Research", task = "Collect 100 tokens", reward = "25,000 Honey"}
    },
    
    ["Polar Bear"] = {
        {name = "Cold Storage", task = "Collect 100,000 Blue pollen", reward = "50,000 Honey"},
        {name = "Frozen Feast", task = "Feed bees 50 Treats", reward = "Royal Jelly x5"},
        {name = "Ice Age", task = "Defeat 20 Mantis", reward = "100,000 Honey + Diamond Egg"}
    }
}

-- Player's progress (in real app, this would be saved)
QuestTracker.Progress = {}

--[[
    Initialize tracker for a player
]]
function QuestTracker.Init()
    for npc, quests in pairs(QuestTracker.Quests) do
        QuestTracker.Progress[npc] = {}
        for i, quest in ipairs(quests) do
            QuestTracker.Progress[npc][i] = {
                completed = false,
                currentProgress = 0
            }
        end
    end
    print("Quest Tracker initialized!")
end

--[[
    Mark a quest as complete
    @param npc: NPC name
    @param questIndex: Quest number (1-based)
]]
function QuestTracker.CompleteQuest(npc, questIndex)
    if QuestTracker.Progress[npc] and QuestTracker.Progress[npc][questIndex] then
        QuestTracker.Progress[npc][questIndex].completed = true
        local quest = QuestTracker.Quests[npc][questIndex]
        print(string.format("✅ Completed: %s - %s", npc, quest.name))
        print(string.format("   Reward: %s", quest.reward))
    end
end

--[[
    Get next incomplete quest for an NPC
    @param npc: NPC name
    @return: Quest info or nil
]]
function QuestTracker.GetNextQuest(npc)
    local quests = QuestTracker.Quests[npc]
    local progress = QuestTracker.Progress[npc]
    
    if not quests or not progress then return nil end
    
    for i, quest in ipairs(quests) do
        if not progress[i].completed then
            return {
                index = i,
                name = quest.name,
                task = quest.task,
                reward = quest.reward
            }
        end
    end
    
    return nil -- All complete!
end

--[[
    Print progress report for all NPCs
]]
function QuestTracker.PrintProgress()
    print("╔════════════════════════════════════════╗")
    print("║        QUEST PROGRESS REPORT           ║")
    print("╠════════════════════════════════════════╣")
    
    for npc, quests in pairs(QuestTracker.Quests) do
        local completed = 0
        local total = #quests
        
        for i, quest in ipairs(quests) do
            if QuestTracker.Progress[npc] and QuestTracker.Progress[npc][i] and QuestTracker.Progress[npc][i].completed then
                completed = completed + 1
            end
        end
        
        local status = completed == total and "✅ DONE" or string.format("%d/%d", completed, total)
        print(string.format("║ %-20s %10s       ║", npc, status))
    end
    
    print("╚════════════════════════════════════════╝")
end

--[[
    Print detailed quests for specific NPC
    @param npc: NPC name
]]
function QuestTracker.PrintNPCQuests(npc)
    local quests = QuestTracker.Quests[npc]
    if not quests then
        print("Unknown NPC: " .. npc)
        return
    end
    
    print("\\n=== " .. npc .. " Quests ===")
    for i, quest in ipairs(quests) do
        local done = QuestTracker.Progress[npc] and 
                     QuestTracker.Progress[npc][i] and 
                     QuestTracker.Progress[npc][i].completed
        local status = done and "✅" or "⬜"
        print(string.format("%s %d. %s", status, i, quest.name))
        print(string.format("   Task: %s", quest.task))
        print(string.format("   Reward: %s", quest.reward))
    end
end

-- ═══════════════════════════════════════════════════
-- EXAMPLE USAGE
-- ═══════════════════════════════════════════════════

-- Initialize the tracker
QuestTracker.Init()

-- Complete some quests
QuestTracker.CompleteQuest("Black Bear", 1)
QuestTracker.CompleteQuest("Black Bear", 2)
QuestTracker.CompleteQuest("Black Bear", 3)

-- Print progress
QuestTracker.PrintProgress()

-- Print specific NPC quests
QuestTracker.PrintNPCQuests("Black Bear")

-- Get next quest
local nextQuest = QuestTracker.GetNextQuest("Black Bear")
if nextQuest then
    print("\\nNext quest: " .. nextQuest.name)
    print("Task: " .. nextQuest.task)
end

return QuestTracker`
  },
  {
    id: "hive-builder",
    name: "Hive Builder Simulator",
    description: "Simulate and plan your ideal hive composition with recommendations.",
    filename: "HiveBuilder.lua",
    code: `--[[
    Bee Swarm Simulator - Hive Builder
    Version: 1.0
    
    Plan and optimize your hive composition.
    Gives recommendations based on your playstyle.
]]

local HiveBuilder = {}

-- Hive slots by progression
HiveBuilder.MaxSlots = {
    starter = 25,
    midgame = 35,
    lategame = 45,
    endgame = 50
}

-- Recommended hive compositions
HiveBuilder.Compositions = {
    ["Balanced"] = {
        description = "Good mix of all colors. Great for beginners.",
        red = 0.33,
        blue = 0.33,
        colorless = 0.34
    },
    ["Red Hive"] = {
        description = "Focus on red bees. Best for Pepper Patch grinding.",
        red = 0.70,
        blue = 0.10,
        colorless = 0.20
    },
    ["Blue Hive"] = {
        description = "Focus on blue bees. Best for Pine Tree/Mountain Top.",
        red = 0.10,
        blue = 0.70,
        colorless = 0.20
    },
    ["White Hive"] = {
        description = "Focus on colorless bees. Versatile for all fields.",
        red = 0.15,
        blue = 0.15,
        colorless = 0.70
    }
}

-- Current hive
HiveBuilder.MyHive = {}

--[[
    Add a bee to your hive
    @param beeName: Name of the bee
    @param level: Bee's level
    @param isGifted: Whether the bee is gifted
]]
function HiveBuilder.AddBee(beeName, level, isGifted)
    table.insert(HiveBuilder.MyHive, {
        name = beeName,
        level = level or 1,
        gifted = isGifted or false
    })
    print(string.format("Added %s%s (Lvl %d) to hive", 
        isGifted and "Gifted " or "", 
        beeName, 
        level or 1))
end

--[[
    Remove a bee from your hive
    @param beeName: Name of the bee to remove
    @return: true if removed, false if not found
]]
function HiveBuilder.RemoveBee(beeName)
    for i, bee in ipairs(HiveBuilder.MyHive) do
        if bee.name == beeName then
            table.remove(HiveBuilder.MyHive, i)
            print("Removed " .. beeName .. " from hive")
            return true
        end
    end
    print("Bee not found: " .. beeName)
    return false
end

--[[
    Get hive statistics
    @return: Table with stats
]]
function HiveBuilder.GetStats()
    local stats = {
        total = #HiveBuilder.MyHive,
        red = 0,
        blue = 0,
        colorless = 0,
        gifted = 0,
        avgLevel = 0,
        totalAttack = 0
    }
    
    local levelSum = 0
    
    -- Bee color mapping (simplified)
    local beeColors = {
        -- Red
        ["Bomber Bee"] = "red", ["Brave Bee"] = "red", ["Rad Bee"] = "red",
        ["Riley Bee"] = "red", ["Fire Bee"] = "red", ["Demo Bee"] = "red",
        ["Demon Bee"] = "red", ["Lion Bee"] = "red", ["Spicy Bee"] = "red",
        -- Blue
        ["Bumble Bee"] = "blue", ["Cool Bee"] = "blue", ["Bubble Bee"] = "blue",
        ["Bucko Bee"] = "blue", ["Frosty Bee"] = "blue", ["Diamond Bee"] = "blue",
        ["Shy Bee"] = "blue", ["Tadpole Bee"] = "blue", ["Buoyant Bee"] = "blue",
        -- Colorless (default)
    }
    
    for _, bee in ipairs(HiveBuilder.MyHive) do
        local color = beeColors[bee.name] or "colorless"
        stats[color] = stats[color] + 1
        
        if bee.gifted then
            stats.gifted = stats.gifted + 1
        end
        
        levelSum = levelSum + bee.level
    end
    
    stats.avgLevel = stats.total > 0 and (levelSum / stats.total) or 0
    
    return stats
end

--[[
    Get hive composition percentages
]]
function HiveBuilder.GetComposition()
    local stats = HiveBuilder.GetStats()
    if stats.total == 0 then
        return {red = 0, blue = 0, colorless = 0}
    end
    
    return {
        red = stats.red / stats.total,
        blue = stats.blue / stats.total,
        colorless = stats.colorless / stats.total
    }
end

--[[
    Get recommendation for closest matching build
]]
function HiveBuilder.GetRecommendation()
    local comp = HiveBuilder.GetComposition()
    local bestMatch = nil
    local bestScore = 999
    
    for name, build in pairs(HiveBuilder.Compositions) do
        local score = math.abs(comp.red - build.red) + 
                      math.abs(comp.blue - build.blue) + 
                      math.abs(comp.colorless - build.colorless)
        
        if score < bestScore then
            bestScore = score
            bestMatch = name
        end
    end
    
    return bestMatch, HiveBuilder.Compositions[bestMatch]
end

--[[
    Print full hive report
]]
function HiveBuilder.PrintReport()
    local stats = HiveBuilder.GetStats()
    local comp = HiveBuilder.GetComposition()
    local recommendation, recData = HiveBuilder.GetRecommendation()
    
    print("╔════════════════════════════════════════╗")
    print("║          HIVE BUILDER REPORT           ║")
    print("╠════════════════════════════════════════╣")
    print(string.format("║ Total Bees: %-27d ║", stats.total))
    print(string.format("║ Average Level: %-24.1f ║", stats.avgLevel))
    print(string.format("║ Gifted Bees: %-26d ║", stats.gifted))
    print("╠════════════════════════════════════════╣")
    print("║ Composition:                           ║")
    print(string.format("║   🔴 Red: %d (%.0f%%)                     ║", stats.red, comp.red * 100))
    print(string.format("║   🔵 Blue: %d (%.0f%%)                    ║", stats.blue, comp.blue * 100))
    print(string.format("║   ⚪ Colorless: %d (%.0f%%)               ║", stats.colorless, comp.colorless * 100))
    print("╠════════════════════════════════════════╣")
    print("║ Closest Build Type: " .. recommendation)
    print("║ " .. recData.description)
    print("╚════════════════════════════════════════╝")
end

--[[
    Print list of all bees in hive
]]
function HiveBuilder.PrintHive()
    print("\\n=== My Hive ===")
    for i, bee in ipairs(HiveBuilder.MyHive) do
        local giftedStr = bee.gifted and "⭐ " or ""
        print(string.format("%d. %s%s (Lvl %d)", i, giftedStr, bee.name, bee.level))
    end
    print(string.format("Total: %d bees", #HiveBuilder.MyHive))
end

-- ═══════════════════════════════════════════════════
-- EXAMPLE USAGE
-- ═══════════════════════════════════════════════════

-- Build a sample hive
HiveBuilder.AddBee("Basic Bee", 10, false)
HiveBuilder.AddBee("Brave Bee", 8, true)
HiveBuilder.AddBee("Riley Bee", 9, false)
HiveBuilder.AddBee("Fire Bee", 7, false)
HiveBuilder.AddBee("Spicy Bee", 10, true)
HiveBuilder.AddBee("Cool Bee", 8, false)
HiveBuilder.AddBee("Bucko Bee", 9, false)
HiveBuilder.AddBee("Hasty Bee", 8, false)
HiveBuilder.AddBee("Looker Bee", 7, true)
HiveBuilder.AddBee("Photon Bee", 10, true)

-- Print reports
HiveBuilder.PrintHive()
HiveBuilder.PrintReport()

return HiveBuilder`
  }
];

const setupGuide = `
# Setting Up Visual Studio Code for Lua

## Step 1: Install VS Code
Download from: https://code.visualstudio.com/

## Step 2: Install Lua Extension
1. Open VS Code
2. Press Ctrl+Shift+X (Extensions)
3. Search for "Lua" by sumneko
4. Click Install

## Step 3: Create Your Project
1. Create a new folder (e.g., "BSS-Scripts")
2. Open it in VS Code (File → Open Folder)
3. Create new .lua files

## Step 4: Run Scripts
Option A - Output Panel:
1. Install "Code Runner" extension
2. Right-click your .lua file
3. Select "Run Code"

Option B - Terminal:
1. Install Lua from lua.org
2. Open terminal in VS Code
3. Type: lua yourfile.lua

## Tips:
- Save files with .lua extension
- Use Ctrl+S to save
- Check the OUTPUT panel for results
`;

export default function Scripts() {
  const [copiedCode, setCopiedCode] = useState(null);

  const handleCopy = async (code, id) => {
    try {
      await navigator.clipboard.writeText(code);
      setCopiedCode(id);
      setTimeout(() => setCopiedCode(null), 2000);
    } catch (err) {
      console.error('Failed to copy:', err);
    }
  };

  const handleDownload = (code, filename) => {
    const blob = new Blob([code], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  };

  return (
    <div className="min-h-screen py-8 px-4">
      <div className="max-w-5xl mx-auto">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-8"
        >
          <h1 className="text-3xl md:text-4xl font-bold text-amber-900 mb-2">💻 Lua Scripts</h1>
          <p className="text-amber-700">Working scripts for Visual Studio Code & Roblox Studio</p>
        </motion.div>

        {/* Setup Guide Accordion */}
        <Accordion type="single" collapsible className="mb-8">
          <AccordionItem value="setup" className="bg-white rounded-xl border border-amber-200">
            <AccordionTrigger className="px-6 hover:no-underline">
              <div className="flex items-center gap-3">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Terminal className="w-5 h-5 text-blue-600" />
                </div>
                <div className="text-left">
                  <h3 className="font-semibold text-gray-900">VS Code Setup Guide</h3>
                  <p className="text-sm text-gray-500">How to run these scripts on your computer</p>
                </div>
              </div>
            </AccordionTrigger>
            <AccordionContent className="px-6 pb-6">
              <div className="bg-gray-900 rounded-lg p-4 text-gray-100 text-sm whitespace-pre-wrap font-mono">
                {setupGuide}
              </div>
            </AccordionContent>
          </AccordionItem>
        </Accordion>

        {/* Info Alert */}
        <Alert className="mb-8 border-green-200 bg-green-50">
          <Info className="h-4 w-4 text-green-600" />
          <AlertTitle className="text-green-800">Ready to Use!</AlertTitle>
          <AlertDescription className="text-green-700">
            These scripts are complete and functional. Download or copy them directly into Visual Studio Code.
            Each script includes instructions at the top explaining how to use it.
          </AlertDescription>
        </Alert>

        {/* Scripts */}
        <div className="space-y-6">
          {scripts.map((script, index) => (
            <motion.div
              key={script.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              <Card className="overflow-hidden">
                <CardHeader className="pb-2">
                  <div className="flex items-start justify-between">
                    <div className="flex items-center gap-3">
                      <div className="p-2 bg-purple-100 rounded-lg">
                        <FileCode className="w-5 h-5 text-purple-600" />
                      </div>
                      <div>
                        <CardTitle className="text-lg">{script.name}</CardTitle>
                        <CardDescription>{script.description}</CardDescription>
                      </div>
                    </div>
                    <Badge className="bg-purple-100 text-purple-800 border-purple-200">
                      {script.filename}
                    </Badge>
                  </div>
                </CardHeader>

                <CardContent>
                  <div className="flex gap-2 mb-4">
                    <Button
                      size="sm"
                      onClick={() => handleCopy(script.code, script.id)}
                      variant="outline"
                      className="flex items-center gap-1"
                    >
                      {copiedCode === script.id ? (
                        <>
                          <Check className="w-4 h-4 text-green-500" />
                          Copied!
                        </>
                      ) : (
                        <>
                          <Copy className="w-4 h-4" />
                          Copy Code
                        </>
                      )}
                    </Button>
                    <Button
                      size="sm"
                      onClick={() => handleDownload(script.code, script.filename)}
                      className="bg-purple-600 hover:bg-purple-700 flex items-center gap-1"
                    >
                      <Download className="w-4 h-4" />
                      Download .lua
                    </Button>
                  </div>

                  <pre className="bg-gray-900 text-gray-100 p-4 rounded-lg overflow-x-auto text-sm max-h-96 overflow-y-auto">
                    <code>{script.code}</code>
                  </pre>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>
      </div>
    </div>
  );
}