import React from 'react';
import { Link } from 'react-router-dom';
import { createPageUrl } from '@/utils';
import { Bug, Map, ScrollText, Bot, Gift, Calculator, ChevronRight, Sparkles, Crown, Code } from 'lucide-react';
import { motion } from 'framer-motion';

const features = [
  {
    title: "Bee Database",
    description: "Explore all bees, their stats, abilities, and how to obtain them",
    icon: Bug,
    page: "BeeDatabase",
    color: "from-amber-400 to-orange-500"
  },
  {
    title: "Field Guide",
    description: "Learn about all fields, pollen types, and best strategies",
    icon: Map,
    page: "FieldGuide",
    color: "from-green-400 to-emerald-500"
  },
  {
    title: "Quest Guides",
    description: "Complete walkthroughs for all NPC quests",
    icon: ScrollText,
    page: "QuestGuide",
    color: "from-blue-400 to-indigo-500"
  },
  {
    title: "Active Codes",
    description: "Get free honey, tickets, and items with promo codes",
    icon: Gift,
    page: "Codes",
    color: "from-pink-400 to-rose-500"
  },
  {
    title: "AI Chat Assistant",
    description: "Ask our AI anything about Bee Swarm Simulator",
    icon: Bot,
    page: "AIChat",
    color: "from-purple-400 to-violet-500"
  },
  {
    title: "Lua Scripts",
    description: "Download working scripts for VS Code & Roblox Studio",
    icon: Code,
    page: "Scripts",
    color: "from-indigo-400 to-purple-500"
  },
  {
    title: "Calculators",
    description: "Honey calculators and bee recommendations",
    icon: Calculator,
    page: "Calculators",
    color: "from-cyan-400 to-teal-500",
    isPremium: true
  }
];

const tips = [
  "Always complete quests from Black Bear first - they give great early rewards!",
  "Focus on getting your first 25 bees before upgrading them",
  "Use the sprinklers strategically for passive honey collection",
  "Join the official BSS Discord for community tips and giveaways"
];

export default function Home() {
  const [currentTip, setCurrentTip] = React.useState(0);

  React.useEffect(() => {
    const interval = setInterval(() => {
      setCurrentTip((prev) => (prev + 1) % tips.length);
    }, 5000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="min-h-screen bg-gradient-to-br from-amber-50 via-orange-50 to-yellow-50">
      {/* Hero Section */}
      <div className="relative overflow-hidden">
        <div className="absolute inset-0 opacity-10">
          <div className="absolute top-10 left-10 w-32 h-32 bg-amber-400 rounded-full blur-3xl"></div>
          <div className="absolute top-40 right-20 w-48 h-48 bg-orange-400 rounded-full blur-3xl"></div>
          <div className="absolute bottom-10 left-1/3 w-40 h-40 bg-yellow-400 rounded-full blur-3xl"></div>
        </div>
        
        <div className="relative max-w-6xl mx-auto px-4 py-16 md:py-24">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="text-center"
          >
            <div className="inline-flex items-center gap-2 bg-amber-100 text-amber-800 px-4 py-2 rounded-full text-sm font-medium mb-6">
              <Sparkles className="w-4 h-4" />
              <span>Your Ultimate BSS Companion</span>
            </div>
            
            <h1 className="text-4xl md:text-6xl font-bold text-amber-900 mb-4">
              Bee Swarm Simulator
              <span className="block text-transparent bg-clip-text bg-gradient-to-r from-amber-500 to-orange-600">
                Complete Guide
              </span>
            </h1>
            
            <p className="text-lg md:text-xl text-amber-700 max-w-2xl mx-auto mb-8">
              Master the art of beekeeping with comprehensive guides, bee stats, 
              field strategies, and ready-to-use scripts for your hive.
            </p>

            {/* Rotating Tips */}
            <motion.div
              key={currentTip}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              className="bg-white/60 backdrop-blur-sm border border-amber-200 rounded-2xl p-4 max-w-xl mx-auto"
            >
              <p className="text-amber-800 font-medium">
                💡 <span className="text-amber-600">Tip:</span> {tips[currentTip]}
              </p>
            </motion.div>
          </motion.div>
        </div>
      </div>

      {/* Features Grid */}
      <div className="max-w-6xl mx-auto px-4 pb-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {features.map((feature, index) => (
            <motion.div
              key={feature.title}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.4, delay: index * 0.1 }}
            >
              <Link to={createPageUrl(feature.page)}>
                <div className="group relative bg-white rounded-2xl p-6 shadow-sm hover:shadow-xl transition-all duration-300 border border-amber-100 overflow-hidden">
                  <div className={`absolute top-0 right-0 w-32 h-32 bg-gradient-to-br ${feature.color} opacity-10 rounded-full blur-2xl group-hover:opacity-20 transition-opacity`}></div>
                  
                  {feature.isPremium && (
                    <div className="absolute top-3 right-3 bg-gradient-to-r from-amber-400 to-yellow-500 text-white text-xs font-bold px-2 py-1 rounded-full flex items-center gap-1">
                      <Crown className="w-3 h-3" />
                      PREMIUM
                    </div>
                  )}
                  
                  <div className={`inline-flex p-3 rounded-xl bg-gradient-to-br ${feature.color} mb-4`}>
                    <feature.icon className="w-6 h-6 text-white" />
                  </div>
                  
                  <h3 className="text-xl font-semibold text-gray-900 mb-2 group-hover:text-amber-700 transition-colors">
                    {feature.title}
                  </h3>
                  
                  <p className="text-gray-600 mb-4">
                    {feature.description}
                  </p>
                  
                  <div className="flex items-center text-amber-600 font-medium group-hover:gap-2 transition-all">
                    <span>Explore</span>
                    <ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                  </div>
                </div>
              </Link>
            </motion.div>
          ))}
        </div>
      </div>

      {/* Quick Stats */}
      <div className="bg-gradient-to-r from-amber-500 to-orange-500 py-12">
        <div className="max-w-6xl mx-auto px-4">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
            {[
              { value: "50+", label: "Unique Bees" },
              { value: "30+", label: "Fields" },
              { value: "10+", label: "NPCs" },
              { value: "100+", label: "Quests" }
            ].map((stat, i) => (
              <motion.div
                key={stat.label}
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: i * 0.1 }}
                className="text-white"
              >
                <div className="text-3xl md:text-4xl font-bold">{stat.value}</div>
                <div className="text-amber-100">{stat.label}</div>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}