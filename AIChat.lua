import React, { useState, useRef, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Send, Bot, User, Loader2, Sparkles, Trash2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card } from '@/components/ui/card';
import { base44 } from '@/api/base44Client';

const suggestedQuestions = [
  "What's the best bee for beginners?",
  "How do I get a Mythic bee?",
  "What fields give the most honey?",
  "How do I defeat the Stump Snail?",
  "What are the best quests to complete first?",
  "How do I get more tickets?",
];

export default function AIChat() {
  const [messages, setMessages] = useState([
    {
      role: 'assistant',
      content: "Hey there, beekeeper! 🐝 I'm your Bee Swarm Simulator expert. Ask me anything about bees, fields, quests, strategies, or tips to improve your hive!"
    }
  ]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const messagesEndRef = useRef(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSend = async (question = input) => {
    if (!question.trim() || isLoading) return;

    const userMessage = { role: 'user', content: question };
    setMessages(prev => [...prev, userMessage]);
    setInput('');
    setIsLoading(true);

    try {
      const response = await base44.integrations.Core.InvokeLLM({
        prompt: `You are an expert assistant for the Roblox game "Bee Swarm Simulator" (BSS) created by Onett.

VERIFIED GAME FACTS DATABASE:

BEES BY RARITY:
- Common (10): Basic Bee, Bomber Bee, Brave Bee, Bumble Bee, Cool Bee, Hasty Bee, Looker Bee, Rad Bee, Rascal Bee, Stubborn Bee
- Rare (10): Bubble Bee, Bucko Bee, Commander Bee, Demo Bee, Exhausted Bee, Fire Bee, Frosty Bee, Honey Bee, Riley Bee, Shocked Bee  
- Epic (7): Carpenter Bee, Demon Bee, Diamond Bee, Lion Bee, Music Bee, Ninja Bee, Shy Bee
- Legendary (8): Baby Bee, Carpenter Bee, Demon Bee, Photon Bee, Tabby Bee, Cobalt Bee, Crimson Bee, Lion Bee
- Mythic (6): Fuzzy Bee, Spicy Bee, Tadpole Bee, Vector Bee, Buoyant Bee, Precise Bee
- Event Bees: Festive Bee, Puppy Bee, Cobalt Bee, Crimson Bee, Gummy Bee, Photon Bee, Tabby Bee, Bear Bee, Vicious Bee, Windy Bee, Digital Bee

FIELDS (by zone):
- Starter Zone: Sunflower Field (colorless), Dandelion Field (colorless), Mushroom Field (red), Blue Flower Field (blue)
- 5 Bee Zone: Clover Field, Spider Field, Strawberry Field (red), Bamboo Field (blue)
- 10 Bee Zone: Pineapple Patch
- 15 Bee Zone: Stump Field, Cactus Field, Pumpkin Patch, Pine Tree Forest (blue)
- 25 Bee Zone: Rose Field (red), Mountain Top Field (blue)
- 35 Bee Zone: Pepper Patch (red), Coconut Field

NPCs & QUEST GIVERS:
- Black Bear: Starter quests, gives basic rewards
- Brown Bear: Random daily quests
- Mother Bear: Cub Buddy quests
- Polar Bear: Beesmas quests
- Science Bear: Translator quests, unlocks Gifted Riley/Bucko
- Spirit Bear: End-game quests, Petal Planter
- Dapper Bear: Beequip quests
- Onett: Secret end-game NPC

BOSSES:
- Tunnel Bear: Found in White Tunnel, drops Star Jelly
- Stump Snail: Stump Field, takes hours to defeat, drops Stump Field Boost
- King Beetle: King Beetle's Lair, drops Royal Jelly
- Coconut Crab: Coconut Field, drops Tropical Drink
- Mondo Chick: Spawns every hour, drops Mondo Belt Bag materials

KEY MECHANICS:
- Gifted Bees: 1/250 chance from royal jelly, give +10% hive bonus
- Beequips: Equipment for bees, obtained from Dapper Bear
- Mutations: Random stat boosts from feeding bees Neonberries
- Bond: Increases through treating bees, unlocks abilities
- Amulets: Equipment giving bonuses, obtained from bosses/quests

TOOLS (in order):
Scooper → Vacuum → Porcupine Popper → Electro Magnet → Spark Staff → Honey Dipper → Bubble Wand → Scythe → Dark Scythe → Tide Popper

Answer the following question accurately. If you don't know something for certain or if it might have changed in updates, say "I'm not 100% sure about the current state of this, but..." Be helpful and friendly. Use emojis occasionally.

User Question: ${question}`,
        response_json_schema: {
          type: "object",
          properties: {
            answer: { type: "string" }
          },
          required: ["answer"]
        }
      });

      setMessages(prev => [...prev, { role: 'assistant', content: response.answer }]);
    } catch (error) {
      setMessages(prev => [...prev, { 
        role: 'assistant', 
        content: "Oops! Something went wrong. Please try asking again! 🐝" 
      }]);
    } finally {
      setIsLoading(false);
    }
  };

  const clearChat = () => {
    setMessages([{
      role: 'assistant',
      content: "Chat cleared! What would you like to know about Bee Swarm Simulator? 🐝"
    }]);
  };

  return (
    <div className="min-h-screen flex flex-col">
      {/* Header */}
      <div className="bg-gradient-to-r from-amber-500 to-orange-500 text-white py-6 px-4">
        <div className="max-w-3xl mx-auto">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center">
                <Bot className="w-7 h-7" />
              </div>
              <div>
                <h1 className="text-2xl font-bold">BSS AI Assistant</h1>
                <p className="text-amber-100 text-sm">Ask me anything about Bee Swarm Simulator!</p>
              </div>
            </div>
            <Button
              variant="ghost"
              size="sm"
              onClick={clearChat}
              className="text-white hover:bg-white/20"
            >
              <Trash2 className="w-4 h-4 mr-1" />
              Clear
            </Button>
          </div>
        </div>
      </div>

      {/* Chat Container */}
      <div className="flex-1 overflow-y-auto px-4 py-6">
        <div className="max-w-3xl mx-auto space-y-4">
          <AnimatePresence>
            {messages.map((message, index) => (
              <motion.div
                key={index}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0 }}
                className={`flex gap-3 ${message.role === 'user' ? 'justify-end' : 'justify-start'}`}
              >
                {message.role === 'assistant' && (
                  <div className="w-8 h-8 bg-amber-100 rounded-full flex items-center justify-center flex-shrink-0">
                    <span className="text-lg">🐝</span>
                  </div>
                )}
                
                <Card className={`max-w-[80%] p-4 ${
                  message.role === 'user' 
                    ? 'bg-amber-500 text-white border-0' 
                    : 'bg-white'
                }`}>
                  <p className="text-sm whitespace-pre-wrap">{message.content}</p>
                </Card>

                {message.role === 'user' && (
                  <div className="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center flex-shrink-0">
                    <User className="w-4 h-4 text-gray-600" />
                  </div>
                )}
              </motion.div>
            ))}
          </AnimatePresence>

          {isLoading && (
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              className="flex gap-3"
            >
              <div className="w-8 h-8 bg-amber-100 rounded-full flex items-center justify-center">
                <span className="text-lg">🐝</span>
              </div>
              <Card className="p-4 bg-white">
                <div className="flex items-center gap-2 text-gray-500">
                  <Loader2 className="w-4 h-4 animate-spin" />
                  <span className="text-sm">Thinking...</span>
                </div>
              </Card>
            </motion.div>
          )}

          <div ref={messagesEndRef} />
        </div>
      </div>

      {/* Suggested Questions */}
      {messages.length <= 2 && (
        <div className="px-4 pb-4">
          <div className="max-w-3xl mx-auto">
            <p className="text-sm text-gray-500 mb-2 flex items-center gap-1">
              <Sparkles className="w-4 h-4" />
              Try asking:
            </p>
            <div className="flex flex-wrap gap-2">
              {suggestedQuestions.map((question, index) => (
                <button
                  key={index}
                  onClick={() => handleSend(question)}
                  disabled={isLoading}
                  className="px-3 py-1.5 bg-amber-50 hover:bg-amber-100 text-amber-800 text-sm rounded-full transition-colors border border-amber-200"
                >
                  {question}
                </button>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* Input Area */}
      <div className="border-t bg-white p-4">
        <div className="max-w-3xl mx-auto">
          <form 
            onSubmit={(e) => {
              e.preventDefault();
              handleSend();
            }}
            className="flex gap-2"
          >
            <Input
              value={input}
              onChange={(e) => setInput(e.target.value)}
              placeholder="Ask about bees, fields, quests, strategies..."
              disabled={isLoading}
              className="flex-1 border-amber-200 focus:ring-amber-500"
            />
            <Button 
              type="submit" 
              disabled={isLoading || !input.trim()}
              className="bg-amber-500 hover:bg-amber-600"
            >
              <Send className="w-4 h-4" />
            </Button>
          </form>
        </div>
      </div>
    </div>
  );
}