import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Calculator, TrendingUp, Clock, Bug, Zap, Target, Crown, Lock, Sparkles, Check } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Switch } from '@/components/ui/switch';
import { Slider } from '@/components/ui/slider';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsList, TabsTrigger, TabsContent } from '@/components/ui/tabs';
import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from '@/components/ui/dialog';

const fields = {
  "Sunflower Field": { base: 100, color: "Colorless" },
  "Dandelion Field": { base: 110, color: "Colorless" },
  "Mushroom Field": { base: 120, color: "Red" },
  "Blue Flower Field": { base: 120, color: "Blue" },
  "Clover Field": { base: 130, color: "Colorless" },
  "Spider Field": { base: 150, color: "Colorless" },
  "Strawberry Field": { base: 160, color: "Red" },
  "Bamboo Field": { base: 180, color: "Blue" },
  "Pineapple Patch": { base: 200, color: "Colorless" },
  "Rose Field": { base: 250, color: "Red" },
  "Pine Tree Forest": { base: 270, color: "Blue" },
  "Pumpkin Patch": { base: 300, color: "Colorless" },
  "Pepper Patch": { base: 350, color: "Red" },
  "Mountain Top": { base: 400, color: "Blue" }
};

const beeUpgradeCosts = [
  10, 50, 100, 250, 500, 1000, 2500, 5000, 10000, 25000,
  50000, 100000, 250000, 500000, 1000000, 2500000, 5000000
];

const premiumFeatures = [
  "Unlimited access to all calculators",
  "Honey rate optimizer",
  "Grind time estimator",
  "Bee upgrade cost calculator",
  "Advanced field efficiency analysis",
  "No ads experience"
];

export default function Calculators() {
  const [isPremium, setIsPremium] = useState(false);
  const [showPremiumModal, setShowPremiumModal] = useState(true);

  // Honey Calculator State
  const [beeCount, setBeeCount] = useState(25);
  const [averageLevel, setAverageLevel] = useState(5);
  const [selectedField, setSelectedField] = useState("Rose Field");
  const [hasBoost, setHasBoost] = useState(false);
  const [colorMatch, setColorMatch] = useState(false);

  // Grind Time Calculator State
  const [currentHoney, setCurrentHoney] = useState(1000000);
  const [targetHoney, setTargetHoney] = useState(10000000);
  
  // Bee Upgrade Calculator State
  const [currentLevel, setCurrentLevel] = useState(1);
  const [targetLevel, setTargetLevel] = useState(10);

  // Calculations
  const calculatePollenPerMinute = () => {
    const fieldData = fields[selectedField];
    const baseRate = fieldData.base;
    const levelBonus = 1 + (averageLevel * 0.1);
    const boostMultiplier = hasBoost ? 2 : 1;
    const colorBonus = colorMatch ? 1.5 : 1;
    
    return Math.floor(beeCount * baseRate * levelBonus * boostMultiplier * colorBonus);
  };

  const calculateHoneyPerHour = () => {
    const pollenPerMin = calculatePollenPerMinute();
    return Math.floor(pollenPerMin * 60 * 0.8);
  };

  const calculateGrindTime = () => {
    const honeyPerHour = calculateHoneyPerHour();
    const honeyNeeded = targetHoney - currentHoney;
    
    if (honeyPerHour <= 0 || honeyNeeded <= 0) return { hours: 0, minutes: 0 };
    
    const totalMinutes = (honeyNeeded / honeyPerHour) * 60;
    return {
      hours: Math.floor(totalMinutes / 60),
      minutes: Math.floor(totalMinutes % 60)
    };
  };

  const calculateUpgradeCost = () => {
    let totalCost = 0;
    for (let i = currentLevel; i < targetLevel && i < beeUpgradeCosts.length; i++) {
      totalCost += beeUpgradeCosts[i];
    }
    return totalCost;
  };

  const formatNumber = (num) => {
    if (num >= 1000000000) return (num / 1000000000).toFixed(1) + "B";
    if (num >= 1000000) return (num / 1000000).toFixed(1) + "M";
    if (num >= 1000) return (num / 1000).toFixed(1) + "K";
    return num.toString();
  };

  const pollenPerMin = calculatePollenPerMinute();
  const honeyPerHour = calculateHoneyPerHour();
  const grindTime = calculateGrindTime();
  const upgradeCost = calculateUpgradeCost();

  // Premium Modal
  if (!isPremium && showPremiumModal) {
    return (
      <div className="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-amber-50 via-orange-50 to-yellow-50">
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          className="max-w-md w-full"
        >
          <Card className="overflow-hidden border-0 shadow-2xl">
            {/* Premium Header */}
            <div className="bg-gradient-to-r from-amber-400 via-yellow-400 to-amber-500 p-8 text-center relative overflow-hidden">
              <div className="absolute inset-0 opacity-20">
                <div className="absolute top-0 left-1/4 w-32 h-32 bg-white rounded-full blur-3xl"></div>
                <div className="absolute bottom-0 right-1/4 w-40 h-40 bg-white rounded-full blur-3xl"></div>
              </div>
              
              <motion.div
                initial={{ rotate: 0 }}
                animate={{ rotate: [0, -10, 10, -10, 0] }}
                transition={{ duration: 0.5, delay: 0.3 }}
                className="inline-flex p-4 bg-white/20 rounded-2xl mb-4"
              >
                <Crown className="w-12 h-12 text-white" />
              </motion.div>
              
              <h2 className="text-3xl font-bold text-white mb-2">Premium Calculators</h2>
              <p className="text-amber-100">Unlock powerful tools to optimize your hive!</p>
            </div>

            <CardContent className="p-6 space-y-6">
              {/* Features List */}
              <div className="space-y-3">
                {premiumFeatures.map((feature, index) => (
                  <motion.div
                    key={feature}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: index * 0.1 }}
                    className="flex items-center gap-3"
                  >
                    <div className="w-5 h-5 bg-green-100 rounded-full flex items-center justify-center">
                      <Check className="w-3 h-3 text-green-600" />
                    </div>
                    <span className="text-gray-700">{feature}</span>
                  </motion.div>
                ))}
              </div>

              {/* Pricing */}
              <div className="bg-gradient-to-r from-amber-50 to-yellow-50 rounded-xl p-4 text-center border border-amber-200">
                <div className="flex items-center justify-center gap-2 mb-1">
                  <span className="text-gray-400 line-through text-lg">$9.99</span>
                  <Badge className="bg-red-500 text-white">50% OFF</Badge>
                </div>
                <div className="text-4xl font-bold text-amber-600 mb-1">$4.99</div>
                <div className="text-sm text-gray-500">One-time payment • Lifetime access</div>
              </div>

              {/* Buttons */}
              <div className="space-y-3">
                <Button 
                  onClick={() => setIsPremium(true)}
                  className="w-full bg-gradient-to-r from-amber-500 to-yellow-500 hover:from-amber-600 hover:to-yellow-600 text-white py-6 text-lg font-semibold shadow-lg"
                >
                  <Sparkles className="w-5 h-5 mr-2" />
                  Unlock Premium
                </Button>
                
                <Button
                  variant="ghost"
                  onClick={() => setShowPremiumModal(false)}
                  className="w-full text-gray-500 hover:text-gray-700"
                >
                  Maybe later
                </Button>
              </div>

              <p className="text-xs text-center text-gray-400">
                🔒 Secure payment • Instant access • Cancel anytime
              </p>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    );
  }

  // Locked Preview (when user clicks "Maybe later")
  if (!isPremium) {
    return (
      <div className="min-h-screen py-8 px-4">
        <div className="max-w-6xl mx-auto">
          {/* Header */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="text-center mb-8"
          >
            <div className="inline-flex items-center gap-2 bg-amber-100 text-amber-800 px-4 py-2 rounded-full text-sm font-medium mb-4">
              <Crown className="w-4 h-4" />
              Premium Feature
            </div>
            <h1 className="text-3xl md:text-4xl font-bold text-amber-900 mb-2">🔢 Calculators</h1>
            <p className="text-amber-700">Unlock premium to access all calculators</p>
          </motion.div>

          {/* Blurred Preview */}
          <div className="relative">
            <div className="absolute inset-0 bg-white/60 backdrop-blur-sm z-10 flex items-center justify-center rounded-2xl">
              <div className="text-center p-8">
                <div className="w-16 h-16 bg-amber-100 rounded-full flex items-center justify-center mx-auto mb-4">
                  <Lock className="w-8 h-8 text-amber-600" />
                </div>
                <h3 className="text-xl font-bold text-gray-900 mb-2">Premium Content</h3>
                <p className="text-gray-600 mb-4">Unlock to access all calculators and tools</p>
                <Button 
                  onClick={() => setShowPremiumModal(true)}
                  className="bg-gradient-to-r from-amber-500 to-yellow-500 hover:from-amber-600 hover:to-yellow-600"
                >
                  <Crown className="w-4 h-4 mr-2" />
                  Unlock Premium
                </Button>
              </div>
            </div>

            {/* Blurred Content Preview */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 opacity-50">
              <Card>
                <CardHeader>
                  <CardTitle>Honey Calculator</CardTitle>
                </CardHeader>
                <CardContent className="h-64 bg-gray-100 rounded-lg"></CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <CardTitle>Grind Time Estimator</CardTitle>
                </CardHeader>
                <CardContent className="h-64 bg-gray-100 rounded-lg"></CardContent>
              </Card>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Full Calculator (Premium Users)
  return (
    <div className="min-h-screen py-8 px-4">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-8"
        >
          <div className="inline-flex items-center gap-2 bg-gradient-to-r from-amber-100 to-yellow-100 text-amber-800 px-4 py-2 rounded-full text-sm font-medium mb-4 border border-amber-200">
            <Crown className="w-4 h-4" />
            Premium Unlocked
          </div>
          <h1 className="text-3xl md:text-4xl font-bold text-amber-900 mb-2">🔢 Calculators</h1>
          <p className="text-amber-700">Optimize your grinding with these powerful tools</p>
        </motion.div>

        <Tabs defaultValue="honey" className="space-y-6">
          <TabsList className="bg-white border w-full justify-start flex-wrap h-auto py-2">
            <TabsTrigger value="honey" className="flex items-center gap-2">
              <Calculator className="w-4 h-4" />
              Honey Rate
            </TabsTrigger>
            <TabsTrigger value="grind" className="flex items-center gap-2">
              <Clock className="w-4 h-4" />
              Grind Time
            </TabsTrigger>
            <TabsTrigger value="upgrade" className="flex items-center gap-2">
              <TrendingUp className="w-4 h-4" />
              Upgrade Cost
            </TabsTrigger>
          </TabsList>

          {/* Honey Rate Calculator */}
          <TabsContent value="honey">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Zap className="w-5 h-5 text-amber-500" />
                    Input Settings
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div className="space-y-2">
                    <Label>Number of Bees: {beeCount}</Label>
                    <Slider
                      value={[beeCount]}
                      onValueChange={([value]) => setBeeCount(value)}
                      min={1}
                      max={50}
                      step={1}
                      className="py-4"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label>Average Bee Level: {averageLevel}</Label>
                    <Slider
                      value={[averageLevel]}
                      onValueChange={([value]) => setAverageLevel(value)}
                      min={1}
                      max={25}
                      step={1}
                      className="py-4"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label>Field</Label>
                    <Select value={selectedField} onValueChange={setSelectedField}>
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        {Object.entries(fields).map(([name, data]) => (
                          <SelectItem key={name} value={name}>
                            {name} ({data.color})
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="flex items-center justify-between">
                    <Label>Field Boost Active</Label>
                    <Switch checked={hasBoost} onCheckedChange={setHasBoost} />
                  </div>

                  <div className="flex items-center justify-between">
                    <Label>Matching Bee Colors</Label>
                    <Switch checked={colorMatch} onCheckedChange={setColorMatch} />
                  </div>
                </CardContent>
              </Card>

              <Card className="bg-gradient-to-br from-amber-50 to-orange-50">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Target className="w-5 h-5 text-amber-500" />
                    Results
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="bg-white rounded-xl p-4 text-center shadow-sm">
                      <div className="text-3xl font-bold text-amber-600">
                        {formatNumber(pollenPerMin)}
                      </div>
                      <div className="text-sm text-gray-500">Pollen/Minute</div>
                    </div>
                    <div className="bg-white rounded-xl p-4 text-center shadow-sm">
                      <div className="text-3xl font-bold text-amber-600">
                        {formatNumber(honeyPerHour)}
                      </div>
                      <div className="text-sm text-gray-500">Honey/Hour</div>
                    </div>
                  </div>

                  <div className="bg-white rounded-xl p-4 shadow-sm">
                    <h4 className="font-medium text-gray-900 mb-2">Efficiency Tips:</h4>
                    <ul className="text-sm text-gray-600 space-y-1">
                      <li>• Use bees that match the field color for +50% pollen</li>
                      <li>• Field boosters double your pollen rate</li>
                      <li>• Higher level bees gather faster</li>
                    </ul>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Grind Time Calculator */}
          <TabsContent value="grind">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Clock className="w-5 h-5 text-blue-500" />
                    Honey Goal
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div className="space-y-2">
                    <Label>Current Honey</Label>
                    <Input
                      type="number"
                      value={currentHoney}
                      onChange={(e) => setCurrentHoney(parseInt(e.target.value) || 0)}
                      className="text-lg"
                    />
                    <p className="text-sm text-gray-500">{formatNumber(currentHoney)} honey</p>
                  </div>

                  <div className="space-y-2">
                    <Label>Target Honey</Label>
                    <Input
                      type="number"
                      value={targetHoney}
                      onChange={(e) => setTargetHoney(parseInt(e.target.value) || 0)}
                      className="text-lg"
                    />
                    <p className="text-sm text-gray-500">{formatNumber(targetHoney)} honey</p>
                  </div>

                  <div className="flex flex-wrap gap-2">
                    <Badge 
                      variant="outline" 
                      className="cursor-pointer hover:bg-amber-100"
                      onClick={() => setTargetHoney(1000000)}
                    >
                      1M
                    </Badge>
                    <Badge 
                      variant="outline"
                      className="cursor-pointer hover:bg-amber-100"
                      onClick={() => setTargetHoney(10000000)}
                    >
                      10M
                    </Badge>
                    <Badge 
                      variant="outline"
                      className="cursor-pointer hover:bg-amber-100"
                      onClick={() => setTargetHoney(100000000)}
                    >
                      100M
                    </Badge>
                    <Badge 
                      variant="outline"
                      className="cursor-pointer hover:bg-amber-100"
                      onClick={() => setTargetHoney(1000000000)}
                    >
                      1B
                    </Badge>
                  </div>
                </CardContent>
              </Card>

              <Card className="bg-gradient-to-br from-blue-50 to-indigo-50">
                <CardHeader>
                  <CardTitle>Time Estimate</CardTitle>
                  <CardDescription>Based on your current settings</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-6">
                    <div className="text-5xl font-bold text-blue-600 mb-2">
                      {grindTime.hours}h {grindTime.minutes}m
                    </div>
                    <p className="text-gray-500">
                      to earn {formatNumber(targetHoney - currentHoney)} honey
                    </p>
                  </div>

                  <div className="bg-white rounded-xl p-4 mt-4">
                    <div className="grid grid-cols-2 gap-4 text-center">
                      <div>
                        <div className="text-xl font-bold text-gray-900">{formatNumber(honeyPerHour)}</div>
                        <div className="text-xs text-gray-500">Honey/Hour</div>
                      </div>
                      <div>
                        <div className="text-xl font-bold text-gray-900">{formatNumber(honeyPerHour * 24)}</div>
                        <div className="text-xs text-gray-500">Honey/Day</div>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Upgrade Cost Calculator */}
          <TabsContent value="upgrade">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Bug className="w-5 h-5 text-green-500" />
                    Bee Level Range
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-6">
                  <div className="space-y-2">
                    <Label>Current Level: {currentLevel}</Label>
                    <Slider
                      value={[currentLevel]}
                      onValueChange={([value]) => {
                        setCurrentLevel(value);
                        if (value >= targetLevel) setTargetLevel(value + 1);
                      }}
                      min={1}
                      max={24}
                      step={1}
                      className="py-4"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label>Target Level: {targetLevel}</Label>
                    <Slider
                      value={[targetLevel]}
                      onValueChange={([value]) => setTargetLevel(Math.max(value, currentLevel + 1))}
                      min={2}
                      max={25}
                      step={1}
                      className="py-4"
                    />
                  </div>
                </CardContent>
              </Card>

              <Card className="bg-gradient-to-br from-green-50 to-emerald-50">
                <CardHeader>
                  <CardTitle>Upgrade Cost</CardTitle>
                  <CardDescription>Total honey needed for upgrades</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-6">
                    <div className="text-4xl font-bold text-green-600 mb-2">
                      {formatNumber(upgradeCost)}
                    </div>
                    <p className="text-gray-500">
                      honey to level {currentLevel} → {targetLevel}
                    </p>
                  </div>

                  <div className="space-y-2 mt-4">
                    <h4 className="font-medium">Level-by-Level Breakdown:</h4>
                    <div className="bg-white rounded-lg p-3 max-h-40 overflow-y-auto">
                      {Array.from({ length: targetLevel - currentLevel }, (_, i) => {
                        const level = currentLevel + i;
                        return (
                          <div key={level} className="flex justify-between text-sm py-1 border-b last:border-0">
                            <span>Level {level} → {level + 1}</span>
                            <span className="font-medium">{formatNumber(beeUpgradeCosts[level] || 0)}</span>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}