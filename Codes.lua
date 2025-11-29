import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Gift, Copy, Check, Clock, AlertCircle, Sparkles } from 'lucide-react';
import { Badge } from '@/components/ui/badge';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Alert, AlertDescription } from '@/components/ui/alert';

const activeCodes = [
  {
    code: "1MFAVORITES",
    rewards: ["Tickets x5", "Royal Jelly", "Gumdrops x10"],
    expires: "Unknown",
    added: "December 2024"
  },
  {
    code: "2YEARS",
    rewards: ["2 Billion Honey", "Tickets x2", "Royal Jelly"],
    expires: "Unknown",
    added: "November 2024"
  },
  {
    code: "BEESMAS2024",
    rewards: ["Gingerbread Bears", "Tickets x5", "Snowflakes x10"],
    expires: "January 2025",
    added: "December 2024"
  },
  {
    code: "WINTER",
    rewards: ["Snowflakes x5", "Tickets x3"],
    expires: "Unknown",
    added: "December 2024"
  },
  {
    code: "SECRETCODE",
    rewards: ["Royal Jelly", "Tickets x3", "Honey x500k"],
    expires: "Unknown",
    added: "November 2024"
  },
  {
    code: "NEWPLAYER",
    rewards: ["Honey x1M", "Tickets x5", "Silver Egg"],
    expires: "Never",
    added: "Permanent"
  },
  {
    code: "BUZZING",
    rewards: ["Treats x50", "Gumdrops x25"],
    expires: "Unknown",
    added: "October 2024"
  },
  {
    code: "FREEBEE",
    rewards: ["Ticket", "Jelly Beans x10"],
    expires: "Unknown",
    added: "September 2024"
  }
];

const expiredCodes = [
  { code: "SUMMER2024", expired: "September 2024" },
  { code: "HALLOWEEN", expired: "November 2024" },
  { code: "TURKEY", expired: "December 2024" },
  { code: "OLDCODE123", expired: "August 2024" }
];

export default function Codes() {
  const [copiedCode, setCopiedCode] = useState(null);

  const handleCopy = async (code) => {
    try {
      await navigator.clipboard.writeText(code);
      setCopiedCode(code);
      setTimeout(() => setCopiedCode(null), 2000);
    } catch (err) {
      console.error('Failed to copy:', err);
    }
  };

  return (
    <div className="min-h-screen py-8 px-4">
      <div className="max-w-4xl mx-auto">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-8"
        >
          <h1 className="text-3xl md:text-4xl font-bold text-amber-900 mb-2">🎁 Promo Codes</h1>
          <p className="text-amber-700">Redeem these codes for free rewards!</p>
        </motion.div>

        {/* How to Redeem */}
        <Alert className="mb-8 border-amber-200 bg-amber-50">
          <Sparkles className="h-4 w-4 text-amber-600" />
          <AlertDescription className="text-amber-800">
            <strong>How to redeem:</strong> In game, click the cogwheel (Settings) in the top left, 
            then scroll down and enter your code in the "Enter Code" box.
          </AlertDescription>
        </Alert>

        {/* Active Codes */}
        <div className="mb-8">
          <h2 className="text-xl font-bold text-gray-900 mb-4 flex items-center gap-2">
            <Gift className="w-5 h-5 text-green-500" />
            Active Codes ({activeCodes.length})
          </h2>

          <div className="grid gap-4">
            {activeCodes.map((item, index) => (
              <motion.div
                key={item.code}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.05 }}
              >
                <Card className="overflow-hidden border-l-4 border-l-green-500 hover:shadow-md transition-shadow">
                  <CardContent className="p-4">
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          <code className="text-lg font-mono font-bold text-amber-700 bg-amber-50 px-3 py-1 rounded">
                            {item.code}
                          </code>
                          <Button
                            size="sm"
                            variant="outline"
                            onClick={() => handleCopy(item.code)}
                            className="flex items-center gap-1"
                          >
                            {copiedCode === item.code ? (
                              <>
                                <Check className="w-4 h-4 text-green-500" />
                                Copied!
                              </>
                            ) : (
                              <>
                                <Copy className="w-4 h-4" />
                                Copy
                              </>
                            )}
                          </Button>
                        </div>

                        <div className="flex flex-wrap gap-2 mb-2">
                          {item.rewards.map((reward, i) => (
                            <Badge key={i} className="bg-amber-100 text-amber-800 border border-amber-200">
                              {reward}
                            </Badge>
                          ))}
                        </div>

                        <div className="flex items-center gap-4 text-xs text-gray-500">
                          <span className="flex items-center gap-1">
                            <Clock className="w-3 h-3" />
                            Expires: {item.expires}
                          </span>
                          <span>Added: {item.added}</span>
                        </div>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            ))}
          </div>
        </div>

        {/* Expired Codes */}
        <div>
          <h2 className="text-xl font-bold text-gray-900 mb-4 flex items-center gap-2">
            <AlertCircle className="w-5 h-5 text-red-500" />
            Expired Codes
          </h2>

          <Card className="bg-gray-50">
            <CardContent className="p-4">
              <div className="flex flex-wrap gap-2">
                {expiredCodes.map((item) => (
                  <div
                    key={item.code}
                    className="flex items-center gap-2 bg-white px-3 py-2 rounded-lg border border-gray-200"
                  >
                    <code className="text-sm font-mono text-gray-400 line-through">
                      {item.code}
                    </code>
                    <span className="text-xs text-gray-400">
                      Expired {item.expired}
                    </span>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Disclaimer */}
        <p className="text-center text-sm text-gray-500 mt-8">
          Codes are collected from official sources and the community. 
          Some codes may expire without notice.
        </p>
      </div>
    </div>
  );
}