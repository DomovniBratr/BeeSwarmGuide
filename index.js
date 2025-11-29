// Simple static file server with JSON endpoints for the web UI
const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.static(path.join(__dirname, 'public')));
// Serve the JSON data directory at /data so the SPA can fetch /data/*.json
app.use('/data', express.static(path.join(__dirname, 'data')));
app.use(express.json());

function safeReadJson(file) {
	try {
		const raw = fs.readFileSync(path.join(__dirname, 'data', file), 'utf8');
		return JSON.parse(raw);
	} catch (e) {
		return { error: 'not found' };
	}
}

const beesData = safeReadJson('bees.json');
const fieldsData = safeReadJson('fields.json');
const npcsData = safeReadJson('npcs.json');

app.get('/api/bees', (req, res) => res.json(beesData));
app.get('/api/fields', (req, res) => res.json(fieldsData));
app.get('/api/npcs', (req, res) => res.json(npcsData));
app.get('/api/codes', (req, res) => res.json(safeReadJson('codes.json')));
app.get('/api/scripts', (req, res) => res.json(safeReadJson('scripts.json')));
app.get('/api/calculators', (req, res) => res.json(safeReadJson('calculators.json')));

// Simple mock AI endpoint — returns canned helpful responses or echoes user message.
app.post('/api/ai', (req, res) => {
	const input = (req.body && req.body.message) ? req.body.message.toString().trim() : '';
	if (!input) return res.json({ reply: "Please send a question in the 'message' field." });

	// Use a lightweight data-backed answerer first (no external LLM required)
	const text = input.toLowerCase();

	function findBeeByName(query){
		const q = query.toLowerCase().replace(/[^a-z0-9\s]/gi,'').trim();
		// exact match first
		for(const b of beesData){ if(b.name.toLowerCase() === q) return b; }
		// partial match: check if bee name (word) appears in query or vice versa
		for(const b of beesData){ if(q.includes(b.name.toLowerCase().replace(/ bee$/,'')) || b.name.toLowerCase().includes(q)) return b; }
		// token match
		const qTokens = q.split(/\s+/).filter(Boolean);
		for(const token of qTokens){
			for(const b of beesData){ if(b.name.toLowerCase().includes(token)) return b; }
		}
		return null;
	}

	function findFieldByName(query){
		const q = query.toLowerCase().replace(/[^a-z0-9\s]/gi,'').trim();
		for(const f of fieldsData){ if(f.name.toLowerCase() === q) return f; }
		for(const f of fieldsData){ if(f.name.toLowerCase().includes(q) || q.includes(f.name.toLowerCase())) return f; }
		return null;
	}

	// try to answer bee-focused queries
	const bee = findBeeByName(text);
	if(bee){
		// detect what the user is asking about the bee
		if(text.includes('color')) return res.json({ reply: `${bee.name} is a ${bee.color} bee.` });
		if(text.includes('rarity')) return res.json({ reply: `${bee.name} is a ${bee.rarity} rarity bee.` });
		if(text.includes('attack')) return res.json({ reply: `${bee.name} has attack ${bee.attack}.` });
		if(text.includes('speed')) return res.json({ reply: `${bee.name} has speed ${bee.speed}.` });
		if(text.includes('energy') || text.includes('health') || text.includes('hp')) return res.json({ reply: `${bee.name} has energy ${bee.energy}.` });
		if(text.includes('ability')) return res.json({ reply: `${bee.name}'s ability is: ${bee.ability}.` });
		if(text.includes('obtain') || text.includes('where') || text.includes('how do i get') || text.includes('how to get')) return res.json({ reply: `${bee.name} can be obtained from: ${bee.obtain}.` });

		// general summary
		return res.json({ reply: `${bee.name} — ${bee.rarity} ${bee.color} bee. Ability: ${bee.ability}. ${bee.description}` });
	}

	// try field-focused queries
	const field = findFieldByName(text);
	if(field){
		if(text.includes('pollen') || text.includes('color') || text.includes('type')) return res.json({ reply: `${field.name} produces ${field.pollenType} pollen.` });
		if(text.includes('tips') || text.includes('how') || text.includes('strategy')) return res.json({ reply: `Tips for ${field.name}: ${field.tips.join(' ')}.` });
		return res.json({ reply: `${field.name} — ${field.zone}. ${field.description}` });
	}

	// Try NPC/quest lookup
	for(const npc of npcsData){
		if(text.includes(npc.name.toLowerCase())){
			return res.json({ reply: `${npc.name} quests: ${npc.quests.map(q=>q.name).slice(0,4).join(', ')}${npc.quests.length>4? '...' : ''}` });
		}
	}

	// fallback to previous helpful heuristics
	if (text.includes('mythic') || text.includes('how do i get a mythic')) {
		return res.json({ reply: "Mythic bees are usually obtained from very rare eggs or special boss drops — in-game chances change with updates. I'm not 100% sure about the current drop rates, but aim for events and high-tier eggs." });
	}
	if (text.includes('best bee') || text.includes('best bees')) {
		return res.json({ reply: "Depends on your task — for grinding choose bees with high collection (e.g. 'Honey' or 'Buoyant' for certain fields). For combat, use strong attack bees. Tell me the field or task and I'll suggest a setup." });
	}
	if (text.includes('how many bees') || text.includes('25 bees')) {
		return res.json({ reply: "A common milestone is 25 bees — many mid-game mechanics unlock around there. Focus on building a balanced team of collection and support bees." });
	}

	return res.json({ reply: `I got your question: "${input}" — I couldn't find a direct match in the data. Try asking about a specific bee or field name like "what color is Vector" or "what does Photon Bee do".` });
});

// fallback for SPA routing
app.get('*', (req, res) => {
	res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => console.log(`bee-swarm-ai server running on http://localhost:${PORT}`));
