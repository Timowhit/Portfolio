const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// API endpoint to get projects configuration
app.get('/api/projects', (req, res) => {
  const projectsPath = path.join(__dirname, 'projects.json');
  const projects = JSON.parse(fs.readFileSync(projectsPath, 'utf8'));
  res.json(projects);
});

// GitHub raw content proxy to avoid CORS issues
app.get('/api/github-file', async (req, res) => {
  const { url } = req.query;
  if (!url) {
    return res.status(400).json({ error: 'URL required' });
  }
  
  try {
    const response = await fetch(url);
    const content = await response.text();
    res.type('text/plain').send(content);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch file' });
  }
});

// Serve index.html for all other routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`🚀 Portfolio running at http://localhost:${PORT}`);
});
