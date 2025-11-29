import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Map, Flower, Bug, Lock, Unlock, ChevronDown, ChevronUp } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

const fields = [
  // Starter Fields
  {
    name: "Sunflower Field",
    zone: "Starter",
    pollenType: "Colorless",
    requirement: "None",
    description: "The first field you'll encounter. Great for beginners with easy-to-collect pollen.",
    tips: ["Best field for new players", "Collect tokens frequently", "Great for completing Black Bear's early quests"],
    mobs: ["None"],
    beeRecommendation: ["Basic Bee", "Hasty Bee", "Looker Bee"]
  },
  {
    name: "Dandelion Field",
    zone: "Starter",
    pollenType: "Colorless",
    requirement: "None",
    description: "A beautiful field of dandelions with moderate pollen yield.",
    tips: ["Good for early game grinding", "Watch for Rhino Beetles", "Collect falling dandelion puffs for bonus"],
    mobs: ["Rhino Beetle (occasionally)"],
    beeRecommendation: ["Basic Bee", "Bomber Bee", "Looker Bee"]
  },
  {
    name: "Mushroom Field",
    zone: "Starter",
    pollenType: "Red",
    requirement: "None",
    description: "A field dominated by mushrooms. Produces red pollen primarily.",
    tips: ["Best early red field", "Great for red quests", "Mushrooms regenerate quickly"],
    mobs: ["Ladybug"],
    beeRecommendation: ["Rad Bee", "Riley Bee", "Fire Bee"]
  },
  {
    name: "Blue Flower Field",
    zone: "Starter",
    pollenType: "Blue",
    requirement: "None",
    description: "A serene field of blue flowers. Primary source of early blue pollen.",
    tips: ["Best early blue field", "Great for blue quests", "Pairs well with Cool Bee"],
    mobs: ["None"],
    beeRecommendation: ["Cool Bee", "Bucko Bee", "Bubble Bee"]
  },
  {
    name: "Clover Field",
    zone: "5 Bee Zone",
    pollenType: "Colorless",
    requirement: "5 Bees",
    description: "A lucky field of clovers. Has a chance to spawn rare tokens.",
    tips: ["Look for lucky clovers", "Great token spawn rate", "Good for honey grinding"],
    mobs: ["Spider"],
    beeRecommendation: ["Honey Bee", "Looker Bee", "Lucky Bee"]
  },
  {
    name: "Spider Field",
    zone: "5 Bee Zone",
    pollenType: "Colorless",
    requirement: "5 Bees",
    description: "A dangerous field covered in spider webs. High risk, high reward.",
    tips: ["Watch out for spiders", "Good pollen yield", "Bring combat bees"],
    mobs: ["Spider (frequent)", "Cave Monster (rare)"],
    beeRecommendation: ["Brave Bee", "Lion Bee", "Demon Bee"]
  },
  {
    name: "Strawberry Field",
    zone: "5 Bee Zone",
    pollenType: "Red",
    requirement: "5 Bees",
    description: "Sweet strawberries provide red pollen and occasional treats.",
    tips: ["Great for red pollen", "Strawberries give bonus honey", "Good quest field"],
    mobs: ["Ladybug"],
    beeRecommendation: ["Riley Bee", "Fire Bee", "Demon Bee"]
  },
  {
    name: "Bamboo Field",
    zone: "10 Bee Zone",
    pollenType: "Blue",
    requirement: "10 Bees",
    description: "Tall bamboo stalks create a peaceful blue pollen haven.",
    tips: ["Excellent blue yield", "Bamboo shoots give bonuses", "Good for grinding"],
    mobs: ["Mantis"],
    beeRecommendation: ["Bucko Bee", "Diamond Bee", "Tadpole Bee"]
  },
  {
    name: "Pineapple Patch",
    zone: "15 Bee Zone",
    pollenType: "Colorless",
    requirement: "15 Bees",
    description: "Tropical pineapples offer high pollen counts and special treats.",
    tips: ["High pollen yield", "Pineapples spawn treats", "Great mid-game field"],
    mobs: ["Scorpion"],
    beeRecommendation: ["Music Bee", "Photon Bee", "Vector Bee"]
  },
  {
    name: "Stump Field",
    zone: "15 Bee Zone",
    pollenType: "Colorless",
    requirement: "15 Bees",
    description: "An old tree stump field with unique mechanics.",
    tips: ["Stump Snail boss spawns here", "Good for endurance runs", "High difficulty"],
    mobs: ["Stump Snail (Boss)"],
    beeRecommendation: ["Carpenter Bee", "Vicious Bee", "Digital Bee"]
  },
  {
    name: "Rose Field",
    zone: "25 Bee Zone",
    pollenType: "Red",
    requirement: "25 Bees",
    description: "Beautiful roses with thorns. Premium red pollen source.",
    tips: ["Best red field mid-game", "High pollen per flower", "Watch for thorns"],
    mobs: ["Mantis", "Scorpion"],
    beeRecommendation: ["Spicy Bee", "Demon Bee", "Fire Bee"]
  },
  {
    name: "Pine Tree Forest",
    zone: "25 Bee Zone",
    pollenType: "Blue",
    requirement: "25 Bees",
    description: "A dense pine forest with excellent blue pollen.",
    tips: ["Great blue yield", "Pine cones give bonuses", "Watch for beetles"],
    mobs: ["Rhino Beetle", "Mantis"],
    beeRecommendation: ["Tadpole Bee", "Buoyant Bee", "Frosty Bee"]
  },
  {
    name: "Pumpkin Patch",
    zone: "30 Bee Zone",
    pollenType: "Colorless",
    requirement: "30 Bees",
    description: "Giant pumpkins with massive pollen potential.",
    tips: ["Highest pollen per collection", "Slow regeneration", "Great for bursts"],
    mobs: ["Werewolf (at night)"],
    beeRecommendation: ["Photon Bee", "Vector Bee", "Precise Bee"]
  },
  {
    name: "Pepper Patch",
    zone: "35 Bee Zone",
    pollenType: "Red",
    requirement: "35 Bees",
    description: "Spicy peppers that yield premium red pollen.",
    tips: ["Highest red yield", "Flame boost effects", "End-game red grinding"],
    mobs: ["Fire Ant"],
    beeRecommendation: ["Spicy Bee", "Demon Bee", "Lion Bee"]
  },
  {
    name: "Mountain Top Field",
    zone: "35 Bee Zone",
    pollenType: "Blue",
    requirement: "35 Bees",
    description: "High altitude field with rare blue pollen.",
    tips: ["Premium blue pollen", "Altitude bonuses", "Snowflakes spawn"],
    mobs: ["Werewolf", "Tunnel Bear (rare)"],
    beeRecommendation: ["Buoyant Bee", "Tadpole Bee", "Fuzzy Bee"]
  }
];

const pollenColors = {
  "Red": "bg-red-100 text-red-800 border-red-300",
  "Blue": "bg-blue-100 text-blue-800 border-blue-300",
  "Colorless": "bg-gray-100 text-gray-800 border-gray-300"
};

const zoneColors = {
  "Starter": "from-green-400 to-emerald-500",
  "5 Bee Zone": "from-yellow-400 to-amber-500",
  "10 Bee Zone": "from-orange-400 to-orange-500",
  "15 Bee Zone": "from-red-400 to-rose-500",
  "25 Bee Zone": "from-purple-400 to-violet-500",
  "30 Bee Zone": "from-indigo-400 to-blue-500",
  "35 Bee Zone": "from-pink-400 to-rose-500"
};

export default function FieldGuide() {
  const [expandedField, setExpandedField] = useState(null);
  const [selectedZone, setSelectedZone] = useState('all');

  const zones = ['all', ...new Set(fields.map(f => f.zone))];

  const filteredFields = selectedZone === 'all' 
    ? fields 
    : fields.filter(f => f.zone === selectedZone);

  return (
    <div className="min-h-screen py-8 px-4">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-8"
        >
          <h1 className="text-3xl md:text-4xl font-bold text-amber-900 mb-2">🌻 Field Guide</h1>
          <p className="text-amber-700">Master every field with strategies, tips, and bee recommendations</p>
        </motion.div>

        {/* Zone Filter */}
        <div className="flex flex-wrap gap-2 justify-center mb-8">
          {zones.map((zone) => (
            <button
              key={zone}
              onClick={() => setSelectedZone(zone)}
              className={`px-4 py-2 rounded-full text-sm font-medium transition-all ${
                selectedZone === zone
                  ? 'bg-amber-500 text-white shadow-md'
                  : 'bg-white text-gray-600 hover:bg-amber-100'
              }`}
            >
              {zone === 'all' ? 'All Zones' : zone}
            </button>
          ))}
        </div>

        {/* Fields Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {filteredFields.map((field, index) => (
            <motion.div
              key={field.name}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.05 }}
            >
              <Card 
                className={`overflow-hidden border-0 shadow-sm hover:shadow-lg transition-all cursor-pointer ${
                  expandedField === field.name ? 'ring-2 ring-amber-400' : ''
                }`}
                onClick={() => setExpandedField(expandedField === field.name ? null : field.name)}
              >
                {/* Gradient Header */}
                <div className={`h-2 bg-gradient-to-r ${zoneColors[field.zone]}`}></div>
                
                <CardHeader className="pb-2">
                  <div className="flex items-start justify-between">
                    <div>
                      <CardTitle className="text-xl flex items-center gap-2">
                        <Flower className="w-5 h-5 text-amber-500" />
                        {field.name}
                      </CardTitle>
                      <div className="flex items-center gap-2 mt-2">
                        <Badge className={pollenColors[field.pollenType]}>
                          {field.pollenType} Pollen
                        </Badge>
                        <Badge variant="outline" className="flex items-center gap-1">
                          {field.requirement === "None" ? (
                            <Unlock className="w-3 h-3" />
                          ) : (
                            <Lock className="w-3 h-3" />
                          )}
                          {field.requirement === "None" ? "Unlocked" : field.requirement}
                        </Badge>
                      </div>
                    </div>
                    {expandedField === field.name ? (
                      <ChevronUp className="w-5 h-5 text-gray-400" />
                    ) : (
                      <ChevronDown className="w-5 h-5 text-gray-400" />
                    )}
                  </div>
                </CardHeader>

                <CardContent>
                  <p className="text-gray-600 text-sm mb-3">{field.description}</p>
                  
                  {/* Expanded Content */}
                  {expandedField === field.name && (
                    <motion.div
                      initial={{ opacity: 0, height: 0 }}
                      animate={{ opacity: 1, height: 'auto' }}
                      exit={{ opacity: 0, height: 0 }}
                      className="space-y-4 pt-4 border-t"
                    >
                      {/* Tips */}
                      <div>
                        <h4 className="font-semibold text-gray-900 mb-2">💡 Tips & Strategies</h4>
                        <ul className="space-y-1">
                          {field.tips.map((tip, i) => (
                            <li key={i} className="text-sm text-gray-600 flex items-start gap-2">
                              <span className="text-amber-500 mt-1">•</span>
                              {tip}
                            </li>
                          ))}
                        </ul>
                      </div>

                      {/* Mobs */}
                      <div>
                        <h4 className="font-semibold text-gray-900 mb-2">👾 Mobs</h4>
                        <div className="flex flex-wrap gap-2">
                          {field.mobs.map((mob, i) => (
                            <Badge key={i} variant="secondary" className="bg-red-50 text-red-700">
                              {mob}
                            </Badge>
                          ))}
                        </div>
                      </div>

                      {/* Bee Recommendations */}
                      <div>
                        <h4 className="font-semibold text-gray-900 mb-2">🐝 Recommended Bees</h4>
                        <div className="flex flex-wrap gap-2">
                          {field.beeRecommendation.map((bee, i) => (
                            <Badge key={i} className="bg-amber-100 text-amber-800 border border-amber-300">
                              {bee}
                            </Badge>
                          ))}
                        </div>
                      </div>
                    </motion.div>
                  )}
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>
      </div>
    </div>
  );
}