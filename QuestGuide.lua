import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { ScrollText, CheckCircle, Circle, ChevronRight, Star, Gift, Clock } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';
import { Progress } from '@/components/ui/progress';

const npcs = [
  {
    name: "Black Bear",
    emoji: "🐻",
    location: "Near Sunflower Field",
    difficulty: "Beginner",
    description: "Your first quest giver. Teaches you the basics of the game.",
    quests: [
      { name: "Pollen Intro", task: "Collect 100 pollen from Sunflower Field", reward: "100 Honey", tips: "Just walk through flowers!" },
      { name: "Getting Started", task: "Collect 300 pollen from any field", reward: "200 Honey", tips: "Try Dandelion Field for variety" },
      { name: "Bee Gathering", task: "Collect 1,000 pollen total", reward: "500 Honey + Ticket", tips: "Convert pollen regularly at hive" },
      { name: "Making Honey", task: "Make 1,000 Honey", reward: "1,000 Honey", tips: "Fill your backpack and return to hive" },
      { name: "Busy Bee", task: "Collect 5,000 pollen", reward: "2,000 Honey + Royal Jelly", tips: "Use multiple fields" },
      { name: "Flower Quest", task: "Collect from 500 flowers", reward: "5,000 Honey", tips: "Each flower touch counts" },
      { name: "Bear's Beginning", task: "Make 10,000 Honey total", reward: "10,000 Honey + Silver Egg", tips: "Your first egg reward!" }
    ]
  },
  {
    name: "Mother Bear",
    emoji: "🐻‍❄️",
    location: "Behind Pro Shop",
    difficulty: "Intermediate",
    description: "A caring bear who rewards consistent grinding.",
    quests: [
      { name: "Cozy Bear", task: "Collect 10,000 Red pollen", reward: "5,000 Honey", tips: "Use Strawberry or Mushroom Field" },
      { name: "Warm Bear", task: "Collect 10,000 Blue pollen", reward: "5,000 Honey", tips: "Blue Flower or Bamboo Field" },
      { name: "Hugging Bear", task: "Defeat 5 Spiders", reward: "10,000 Honey + Treats", tips: "Found in Spider Field" },
      { name: "Mother's Love", task: "Collect 50,000 pollen from 5 fields", reward: "Royal Jelly x3", tips: "Visit different colored fields" },
      { name: "Family Picnic", task: "Use 10 Treats on bees", reward: "15,000 Honey + Star Jelly", tips: "Feed your favorite bees!" }
    ]
  },
  {
    name: "Brown Bear",
    emoji: "🧸",
    location: "Near Clover Field",
    difficulty: "Intermediate",
    description: "Focuses on specific field challenges.",
    quests: [
      { name: "Clover Collector", task: "Collect 25,000 pollen from Clover Field", reward: "10,000 Honey", tips: "Good luck clovers give bonuses" },
      { name: "Spider Survivor", task: "Collect 30,000 from Spider Field", reward: "15,000 Honey + Tickets x3", tips: "Bring combat bees" },
      { name: "Strawberry Picker", task: "Collect 40,000 from Strawberry Field", reward: "20,000 Honey", tips: "Red bees work best here" },
      { name: "Field Master", task: "Collect from all 5-Bee zone fields", reward: "Gold Egg", tips: "Complete all starter zones" }
    ]
  },
  {
    name: "Polar Bear",
    emoji: "❄️",
    location: "Snow Area",
    difficulty: "Advanced",
    description: "Challenging quests with great rewards.",
    quests: [
      { name: "Cold Storage", task: "Collect 100,000 Blue pollen", reward: "50,000 Honey", tips: "Pine Tree Forest recommended" },
      { name: "Frozen Feast", task: "Feed bees 50 Treats", reward: "Royal Jelly x5", tips: "Stock up on treats first" },
      { name: "Ice Age", task: "Defeat 20 Mantis", reward: "100,000 Honey + Diamond Egg", tips: "Found in advanced fields" },
      { name: "Polar Power", task: "Collect 500,000 total pollen", reward: "Star Jelly + Mythic Egg", tips: "Long grind but worth it!" }
    ]
  },
  {
    name: "Science Bear",
    emoji: "🔬",
    location: "Near Mushroom Field",
    difficulty: "Intermediate",
    description: "Experimental quests that teach game mechanics.",
    quests: [
      { name: "Data Collection", task: "Collect 20,000 pollen using abilities", reward: "10,000 Honey", tips: "Wait for bee abilities to activate" },
      { name: "Experiment 1", task: "Use a Red Boost and Blue Boost", reward: "Glitter x3", tips: "Boost items from shop" },
      { name: "Research", task: "Collect 100 tokens", reward: "25,000 Honey + Ticket", tips: "Tokens are the drops in fields" },
      { name: "Discovery", task: "Use a field booster", reward: "50,000 Honey", tips: "Buy from Boost Shop" }
    ]
  },
  {
    name: "Spirit Bear",
    emoji: "👻",
    location: "End Game Area",
    difficulty: "Expert",
    description: "The ultimate quest giver for end-game players.",
    quests: [
      { name: "Spiritual Journey", task: "Collect 1,000,000 pollen", reward: "200,000 Honey", tips: "Use boosters and best bees" },
      { name: "Enlightenment", task: "Collect 500,000 from each color", reward: "Star Egg", tips: "Balance your pollen types" },
      { name: "Transcendence", task: "Defeat all bosses once", reward: "Mythic Egg + 500,000 Honey", tips: "Ultimate challenge!" }
    ]
  }
];

export default function QuestGuide() {
  const [selectedNpc, setSelectedNpc] = useState(npcs[0]);
  const [completedQuests, setCompletedQuests] = useState({});

  const toggleQuest = (npcName, questIndex) => {
    const key = `${npcName}-${questIndex}`;
    setCompletedQuests(prev => ({
      ...prev,
      [key]: !prev[key]
    }));
  };

  const getCompletedCount = (npc) => {
    return npc.quests.filter((_, i) => completedQuests[`${npc.name}-${i}`]).length;
  };

  return (
    <div className="min-h-screen py-8 px-4">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-8"
        >
          <h1 className="text-3xl md:text-4xl font-bold text-amber-900 mb-2">📜 Quest Guide</h1>
          <p className="text-amber-700">Complete walkthroughs for all NPC quests</p>
        </motion.div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* NPC List */}
          <div className="lg:col-span-1 space-y-3">
            {npcs.map((npc, index) => {
              const completed = getCompletedCount(npc);
              const total = npc.quests.length;
              const progress = (completed / total) * 100;

              return (
                <motion.div
                  key={npc.name}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: index * 0.05 }}
                >
                  <Card 
                    className={`cursor-pointer transition-all hover:shadow-md ${
                      selectedNpc.name === npc.name 
                        ? 'ring-2 ring-amber-400 bg-amber-50' 
                        : 'hover:bg-gray-50'
                    }`}
                    onClick={() => setSelectedNpc(npc)}
                  >
                    <CardContent className="p-4">
                      <div className="flex items-center gap-3">
                        <span className="text-3xl">{npc.emoji}</span>
                        <div className="flex-1">
                          <h3 className="font-semibold text-gray-900">{npc.name}</h3>
                          <div className="flex items-center gap-2 text-sm text-gray-500">
                            <Badge variant="outline" className="text-xs">
                              {npc.difficulty}
                            </Badge>
                          </div>
                        </div>
                        <div className="text-right">
                          <div className="text-sm font-medium text-amber-600">
                            {completed}/{total}
                          </div>
                          <Progress value={progress} className="w-16 h-1.5 mt-1" />
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </motion.div>
              );
            })}
          </div>

          {/* Quest Details */}
          <div className="lg:col-span-2">
            <Card className="overflow-hidden">
              <CardHeader className="bg-gradient-to-r from-amber-400 to-orange-500 text-white">
                <div className="flex items-center gap-3">
                  <span className="text-4xl">{selectedNpc.emoji}</span>
                  <div>
                    <CardTitle className="text-2xl">{selectedNpc.name}</CardTitle>
                    <p className="text-amber-100 text-sm">{selectedNpc.location}</p>
                  </div>
                </div>
                <p className="text-amber-50 mt-2">{selectedNpc.description}</p>
              </CardHeader>

              <CardContent className="p-0">
                <div className="divide-y">
                  {selectedNpc.quests.map((quest, index) => {
                    const isCompleted = completedQuests[`${selectedNpc.name}-${index}`];
                    
                    return (
                      <motion.div
                        key={quest.name}
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ delay: index * 0.05 }}
                        className={`p-4 hover:bg-gray-50 transition-colors ${
                          isCompleted ? 'bg-green-50' : ''
                        }`}
                      >
                        <div className="flex items-start gap-3">
                          <button
                            onClick={() => toggleQuest(selectedNpc.name, index)}
                            className="mt-1 flex-shrink-0"
                          >
                            {isCompleted ? (
                              <CheckCircle className="w-5 h-5 text-green-500" />
                            ) : (
                              <Circle className="w-5 h-5 text-gray-300 hover:text-amber-400 transition-colors" />
                            )}
                          </button>
                          
                          <div className="flex-1">
                            <div className="flex items-center gap-2 mb-1">
                              <h4 className={`font-semibold ${isCompleted ? 'text-green-700 line-through' : 'text-gray-900'}`}>
                                {index + 1}. {quest.name}
                              </h4>
                            </div>
                            
                            <p className="text-sm text-gray-600 mb-2">
                              <span className="font-medium">Task:</span> {quest.task}
                            </p>
                            
                            <div className="flex flex-wrap gap-2 mb-2">
                              <Badge className="bg-amber-100 text-amber-800 border border-amber-200">
                                <Gift className="w-3 h-3 mr-1" />
                                {quest.reward}
                              </Badge>
                            </div>
                            
                            <div className="p-2 bg-blue-50 rounded-lg text-sm text-blue-700 flex items-start gap-2">
                              <Star className="w-4 h-4 flex-shrink-0 mt-0.5 text-blue-500" />
                              <span>{quest.tips}</span>
                            </div>
                          </div>
                        </div>
                      </motion.div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
}