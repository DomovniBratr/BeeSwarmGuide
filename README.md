Bee Swarm AI — Local Preview & AI Chat

Quick start (Windows PowerShell):

1) Install dependencies
```powershell
npm install
```

2) Start the local server
```powershell
npm start
```

3) Open the site in your browser
http://localhost:3000

AI chat notes
- The local server includes a data-backed `/api/ai` endpoint that uses the repository JSON data (bees, fields, npcs) to answer factual queries without an external LLM.
- Example (PowerShell):
```powershell
$body = @{message='what color is vector'} | ConvertTo-Json
Invoke-WebRequest -Uri http://localhost:3000/api/ai -Method Post -Body $body -ContentType 'application/json' -UseBasicParsing | Select-Object -ExpandProperty Content
```
- The endpoint will reply like: "Vector Bee is a ..." based on the data files.

GitHub Pages / static hosting
- The `docs/` folder contains a full static copy of the site suitable for GitHub Pages.
- GitHub Pages is static-only — the `/api/ai` endpoint will NOT be available on Pages since it requires a running server or serverless function.
- To make AI chat work on GitHub Pages you can either:
  * Deploy a small serverless function (Netlify Functions, Vercel Serverless, or GitHub Actions + a tiny backend) and update the client to call that endpoint; or
  * Integrate an external LLM (OpenAI, etc.) and store the API key in a server-side function (do NOT embed keys in the client).

If you'd like, I can add a serverless example (Netlify / Vercel) or wire in OpenAI — tell me which provider and I'll add an example with environment configuration.
