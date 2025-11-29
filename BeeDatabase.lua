import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Search, Filter, Star, Zap, Shield, Heart, X } from 'lucide-react';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';

const bees = [
  // Common Bees
  { name: "Basic Bee", rarity: "Common", color: "Yellow", attack: 1, speed: 14, energy: 20, ability: "Gather Pollen", description: "The most basic bee. A great starting companion for new beekeepers.", obtain: "Starter bee, can also be obtained from Basic Eggs" },
  { name: "Bomber Bee", rarity: "Common", color: "Red", attack: 1, speed: 14, energy: 25, ability: "Bomb", description: "Drops red bombs that collect pollen from nearby flowers.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Brave Bee", rarity: "Common", color: "Red", attack: 3, speed: 14, energy: 20, ability: "Brave Bash", description: "A courageous bee that deals extra damage to mobs.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Bumble Bee", rarity: "Common", color: "Blue", attack: 1, speed: 11, energy: 40, ability: "Buzz Bomb", description: "A slow but hardworking bee with lots of energy.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Cool Bee", rarity: "Common", color: "Blue", attack: 1, speed: 14, energy: 20, ability: "Cool Breeze", description: "Creates a cooling effect that helps blue pollen collection.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Hasty Bee", rarity: "Common", color: "Colorless", attack: 1, speed: 18, energy: 20, ability: "Haste", description: "One of the fastest bees, grants speed boosts.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Looker Bee", rarity: "Common", color: "Colorless", attack: 1, speed: 14, energy: 20, ability: "Focus", description: "Helps you spot hidden items and improves critical hits.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Rad Bee", rarity: "Common", color: "Red", attack: 2, speed: 14, energy: 20, ability: "Rad Explosion", description: "A radical bee that creates explosive red pollen bursts.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Rascal Bee", rarity: "Common", color: "Colorless", attack: 2, speed: 14, energy: 25, ability: "Surprise", description: "A mischievous bee that loves surprises.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Stubborn Bee", rarity: "Common", color: "Colorless", attack: 1, speed: 12, energy: 30, ability: "Persist", description: "Never gives up, has increased gathering persistence.", obtain: "Basic Egg, Silver Egg, Gold Egg, Diamond Egg" },
  
  // Rare Bees
  { name: "Bubble Bee", rarity: "Rare", color: "Blue", attack: 2, speed: 15, energy: 25, ability: "Bubble Bomb", description: "Creates bubbles that collect blue pollen efficiently.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Bucko Bee", rarity: "Rare", color: "Blue", attack: 2, speed: 14, energy: 25, ability: "Blue Boost", description: "A blue bee leader that enhances blue pollen collection.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Commander Bee", rarity: "Rare", color: "Colorless", attack: 3, speed: 14, energy: 25, ability: "Command", description: "Leads other bees in battle, increasing their effectiveness.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Demo Bee", rarity: "Rare", color: "Red", attack: 2, speed: 14, energy: 30, ability: "Demolition", description: "Expert at explosive pollen collection.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Exhausted Bee", rarity: "Rare", color: "Colorless", attack: 1, speed: 10, energy: 80, ability: "Tireless", description: "Slow but has incredible stamina.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Fire Bee", rarity: "Rare", color: "Red", attack: 3, speed: 16, energy: 20, ability: "Flame Heat", description: "Generates heat that improves red pollen gathering.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Frosty Bee", rarity: "Rare", color: "Blue", attack: 2, speed: 14, energy: 25, ability: "Frost", description: "Creates frost that enhances blue pollen collection.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Honey Bee", rarity: "Rare", color: "Colorless", attack: 1, speed: 15, energy: 25, ability: "Honey Gift", description: "Produces bonus honey tokens regularly.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Riley Bee", rarity: "Rare", color: "Red", attack: 2, speed: 14, energy: 25, ability: "Red Boost", description: "A red bee leader that enhances red pollen collection.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  { name: "Shocked Bee", rarity: "Rare", color: "Colorless", attack: 2, speed: 17, energy: 20, ability: "Shock", description: "Stuns enemies and increases token collection.", obtain: "Silver Egg, Gold Egg, Diamond Egg" },
  
  // Epic Bees
  { name: "Carpenter Bee", rarity: "Epic", color: "Blue", attack: 4, speed: 15, energy: 30, ability: "Build", description: "Constructs helpful structures in the field.", obtain: "Gold Egg, Diamond Egg" },
  { name: "Demon Bee", rarity: "Epic", color: "Red", attack: 5, speed: 16, energy: 25, ability: "Dark Flames", description: "A fierce bee with powerful attack abilities.", obtain: "Gold Egg, Diamond Egg" },
  { name: "Diamond Bee", rarity: "Epic", color: "Blue", attack: 3, speed: 18, energy: 25, ability: "Sparkle", description: "A precious bee that finds valuable tokens.", obtain: "Gold Egg, Diamond Egg" },
  { name: "Lion Bee", rarity: "Epic", color: "Red", attack: 5, speed: 15, energy: 30, ability: "Lion's Roar", description: "A brave and powerful attacking bee.", obtain: "Gold Egg, Diamond Egg" },
  { name: "Music Bee", rarity: "Epic", color: "Colorless", attack: 2, speed: 15, energy: 30, ability: "Melody", description: "Plays music that buffs nearby bees.", obtain: "Gold Egg, Diamond Egg" },
  { name: "Ninja Bee", rarity: "Epic", color: "Colorless", attack: 4, speed: 20, energy: 20, ability: "Stealth", description: "The fastest bee with ninja abilities.", obtain: "Gold Egg, Diamond Egg" },
  { name: "Shy Bee", rarity: "Epic", color: "Blue", attack: 2, speed: 14, energy: 35, ability: "Retreat", description: "A shy but helpful pollinator.", obtain: "Gold Egg, Diamond Egg" },
  
  // Legendary Bees
  { name: "Baby Bee", rarity: "Legendary", color: "Colorless", attack: 1, speed: 12, energy: 50, ability: "Baby Love", description: "An adorable bee that charms everyone.", obtain: "Diamond Egg, Star Egg, Legendary Eggs" },
  { name: "Carpenter Bee", rarity: "Legendary", color: "Blue", attack: 4, speed: 15, energy: 35, ability: "Hover", description: "Expert builder bee.", obtain: "Diamond Egg, Star Egg" },
  { name: "Demon Bee", rarity: "Legendary", color: "Red", attack: 7, speed: 16, energy: 30, ability: "Dark Scythe", description: "A powerful demonic bee.", obtain: "Diamond Egg, Star Egg" },
  { name: "Photon Bee", rarity: "Legendary", color: "Colorless", attack: 4, speed: 18, energy: 30, ability: "Beamstorm", description: "Shoots beams of light for massive pollen collection.", obtain: "Diamond Egg, Star Egg" },
  
  // Mythic Bees
  { name: "Fuzzy Bee", rarity: "Mythic", color: "Colorless", attack: 3, speed: 14, energy: 45, ability: "Fuzzy Coat", description: "Creates fuzz bombs that collect massive pollen.", obtain: "Mythic Egg only" },
  { name: "Spicy Bee", rarity: "Mythic", color: "Red", attack: 5, speed: 16, energy: 35, ability: "Inferno", description: "Creates inferno rings of fire for pollen.", obtain: "Mythic Egg only" },
  { name: "Tadpole Bee", rarity: "Mythic", color: "Blue", attack: 2, speed: 14, energy: 40, ability: "Bubble Splash", description: "Creates massive bubble explosions.", obtain: "Mythic Egg only" },
  { name: "Vector Bee", rarity: "Mythic", color: "Colorless", attack: 4, speed: 17, energy: 35, ability: "Vector", description: "Creates triangular marks for bonus effects.", obtain: "Mythic Egg only" },
  { name: "Buoyant Bee", rarity: "Mythic", color: "Blue", attack: 2, speed: 13, energy: 50, ability: "Float", description: "Floats and creates rising pollen clouds.", obtain: "Mythic Egg only" },
  { name: "Precise Bee", rarity: "Mythic", color: "Colorless", attack: 5, speed: 16, energy: 30, ability: "Target Practice", description: "Incredibly accurate with critical hit bonuses.", obtain: "Mythic Egg only" },
];

const rarityColors = {
  "Common": "bg-gray-100 text-gray-800 border-gray-300",
  "Rare": "bg-blue-100 text-blue-800 border-blue-300",
  "Epic": "bg-purple-100 text-purple-800 border-purple-300",
  "Legendary": "bg-amber-100 text-amber-800 border-amber-300",
  "Mythic": "bg-gradient-to-r from-pink-100 to-purple-100 text-pink-800 border-pink-300"
};

const colorIcons = {
  "Red": "🔴",
  "Blue": "🔵",
  "Colorless": "⚪",
  "Yellow": "🟡"
};

export default function BeeDatabase() {
  const [search, setSearch] = useState('');
  const [selectedRarity, setSelectedRarity] = useState('all');
  const [selectedColor, setSelectedColor] = useState('all');
  const [selectedBee, setSelectedBee] = useState(null);

  const filteredBees = bees.filter(bee => {
    const matchesSearch = bee.name.toLowerCase().includes(search.toLowerCase());
    const matchesRarity = selectedRarity === 'all' || bee.rarity === selectedRarity;
    const matchesColor = selectedColor === 'all' || bee.color === selectedColor;
    return matchesSearch && matchesRarity && matchesColor;
  });

  return (
    <div className="min-h-screen py-8 px-4">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-8"
        >
          <h1 className="text-3xl md:text-4xl font-bold text-amber-900 mb-2">🐝 Bee Database</h1>
          <p className="text-amber-700">Explore all bees, their stats, and how to obtain them</p>
        </motion.div>

        {/* Filters */}
        <div className="bg-white rounded-2xl p-4 md:p-6 shadow-sm border border-amber-100 mb-8">
          <div className="flex flex-col md:flex-row gap-4">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
              <Input
                placeholder="Search bees..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="pl-10 border-amber-200 focus:ring-amber-500"
              />
            </div>
            
            <Tabs value={selectedRarity} onValueChange={setSelectedRarity} className="w-full md:w-auto">
              <TabsList className="bg-amber-50 flex-wrap h-auto">
                <TabsTrigger value="all" className="text-xs md:text-sm">All</TabsTrigger>
                <TabsTrigger value="Common" className="text-xs md:text-sm">Common</TabsTrigger>
                <TabsTrigger value="Rare" className="text-xs md:text-sm">Rare</TabsTrigger>
                <TabsTrigger value="Epic" className="text-xs md:text-sm">Epic</TabsTrigger>
                <TabsTrigger value="Legendary" className="text-xs md:text-sm">Legendary</TabsTrigger>
                <TabsTrigger value="Mythic" className="text-xs md:text-sm">Mythic</TabsTrigger>
              </TabsList>
            </Tabs>
          </div>

          <div className="flex flex-wrap gap-2 mt-4">
            <span className="text-sm text-gray-500 mr-2">Color:</span>
            {['all', 'Red', 'Blue', 'Colorless'].map((color) => (
              <Button
                key={color}
                variant={selectedColor === color ? 'default' : 'outline'}
                size="sm"
                onClick={() => setSelectedColor(color)}
                className={selectedColor === color ? 'bg-amber-500 hover:bg-amber-600' : ''}
              >
                {color === 'all' ? 'All' : `${colorIcons[color]} ${color}`}
              </Button>
            ))}
          </div>
        </div>

        {/* Results Count */}
        <p className="text-amber-700 mb-4">{filteredBees.length} bees found</p>

        {/* Bee Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          <AnimatePresence>
            {filteredBees.map((bee, index) => (
              <motion.div
                key={bee.name + bee.rarity}
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.9 }}
                transition={{ delay: index * 0.02 }}
                onClick={() => setSelectedBee(bee)}
                className="bg-white rounded-xl p-4 shadow-sm border border-amber-100 hover:shadow-lg hover:border-amber-300 transition-all cursor-pointer group"
              >
                <div className="flex items-start justify-between mb-3">
                  <div className="text-3xl">{colorIcons[bee.color]}</div>
                  <Badge className={`${rarityColors[bee.rarity]} border`}>
                    {bee.rarity}
                  </Badge>
                </div>
                
                <h3 className="font-semibold text-gray-900 mb-1 group-hover:text-amber-700 transition-colors">
                  {bee.name}
                </h3>
                
                <p className="text-sm text-gray-500 mb-3 line-clamp-2">{bee.description}</p>
                
                <div className="flex gap-4 text-xs text-gray-600">
                  <span className="flex items-center gap-1">
                    <Zap className="w-3 h-3 text-amber-500" /> {bee.attack}
                  </span>
                  <span className="flex items-center gap-1">
                    <Shield className="w-3 h-3 text-blue-500" /> {bee.speed}
                  </span>
                  <span className="flex items-center gap-1">
                    <Heart className="w-3 h-3 text-red-500" /> {bee.energy}
                  </span>
                </div>
              </motion.div>
            ))}
          </AnimatePresence>
        </div>

        {/* Bee Detail Modal */}
        <Dialog open={!!selectedBee} onOpenChange={() => setSelectedBee(null)}>
          <DialogContent className="max-w-lg">
            {selectedBee && (
              <>
                <DialogHeader>
                  <DialogTitle className="flex items-center gap-3">
                    <span className="text-3xl">{colorIcons[selectedBee.color]}</span>
                    <span>{selectedBee.name}</span>
                  </DialogTitle>
                </DialogHeader>
                
                <div className="space-y-4">
                  <Badge className={`${rarityColors[selectedBee.rarity]} border`}>
                    {selectedBee.rarity}
                  </Badge>
                  
                  <p className="text-gray-600">{selectedBee.description}</p>
                  
                  <div className="grid grid-cols-3 gap-4 p-4 bg-amber-50 rounded-xl">
                    <div className="text-center">
                      <Zap className="w-5 h-5 mx-auto text-amber-500 mb-1" />
                      <div className="text-xl font-bold text-gray-900">{selectedBee.attack}</div>
                      <div className="text-xs text-gray-500">Attack</div>
                    </div>
                    <div className="text-center">
                      <Shield className="w-5 h-5 mx-auto text-blue-500 mb-1" />
                      <div className="text-xl font-bold text-gray-900">{selectedBee.speed}</div>
                      <div className="text-xs text-gray-500">Speed</div>
                    </div>
                    <div className="text-center">
                      <Heart className="w-5 h-5 mx-auto text-red-500 mb-1" />
                      <div className="text-xl font-bold text-gray-900">{selectedBee.energy}</div>
                      <div className="text-xs text-gray-500">Energy</div>
                    </div>
                  </div>
                  
                  <div className="space-y-2">
                    <div className="flex items-center gap-2">
                      <Star className="w-4 h-4 text-amber-500" />
                      <span className="font-medium">Ability:</span>
                      <span className="text-gray-600">{selectedBee.ability}</span>
                    </div>
                    
                    <div className="p-3 bg-gray-50 rounded-lg">
                      <span className="font-medium">How to obtain:</span>
                      <p className="text-gray-600 text-sm mt-1">{selectedBee.obtain}</p>
                    </div>
                  </div>
                </div>
              </>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}