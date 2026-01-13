# Timothy A. Whitehead - Portfolio

A stunning carousel-based portfolio showcasing projects with live demos and source code side-by-side.

![Portfolio Preview](https://via.placeholder.com/800x400/0a0a0b/00ff88?text=Portfolio+Preview)

## Features

- 🎠 **Auto-rotating carousel** - Projects cycle automatically with 8-second intervals
- 🖼️ **Live iframe preview** - See your projects in action
- 💻 **Source code viewer** - Syntax-highlighted code alongside demos
- ⏯️ **Playback controls** - Pause, play, and navigate manually
- ⌨️ **Keyboard shortcuts** - Arrow keys + spacebar for navigation
- 📱 **Fully responsive** - Works on all devices
- 🎨 **Dynamic theming** - Each project can have its own accent color

## Quick Start

### Local Development

```bash
# Install dependencies
npm install

# Start the server
npm start

# Visit http://localhost:3000
```

### Deploy to Railway

1. **Push to GitHub**

   ```bash
   git init
   git add .
   git commit -m "Initial portfolio"
   git remote add origin https://github.com/YOUR_USERNAME/portfolio.git
   git push -u origin main
   ```

2. **Deploy on Railway**
   - Go to [Railway](https://railway.app)
   - Click "New Project" → "Deploy from GitHub repo"
   - Select your portfolio repository
   - Railway will auto-detect Node.js and deploy!

3. **Get your URL**
   - Railway provides a free `*.railway.app` subdomain
   - Or add your custom domain in Settings

## Customization

### Edit Your Projects

Open `projects.json` and update with your actual projects:

```json
{
  "author": {
    "name": "Your Name",
    "title": "Your Title",
    "github": "https://github.com/yourusername",
    "tagline": "Your tagline here"
  },
  "projects": [
    {
      "id": "unique-id",
      "name": "Project Name",
      "description": "Brief description of what this project does.",
      "tags": ["HTML", "CSS", "JavaScript"],
      "liveUrl": "https://yourusername.github.io/project/",
      "repoUrl": "https://github.com/yourusername/project",
      "sourceFile": "https://raw.githubusercontent.com/yourusername/project/main/index.html",
      "color": "#00ff88"
    }
  ]
}
```

### Project Properties

| Property | Description |
| -------- | ----------- |
| `id` | Unique identifier (lowercase, no spaces) |
| `name` | Display name for the project |
| `description` | Short description (1-2 sentences) |
| `tags` | Array of technology tags |
| `liveUrl` | URL where the project is hosted (for iframe) |
| `repoUrl` | GitHub repository URL |
| `sourceFile` | Raw GitHub URL to the main source file |
| `color` | Hex color for accent theming |

### Timing Configuration

To change the carousel timing, edit the CSS variable in `public/index.html`:

```css
:root {
  --carousel-duration: 8000; /* milliseconds */
}
```

And update the JavaScript:

```javascript
this.duration = 8000; // Match the CSS value
```

## Project Structure

```txt
portfolio/
├── server.js           # Express server
├── package.json        # Dependencies & scripts
├── projects.json       # Your project data
├── public/
│   └── index.html      # Main portfolio page
└── README.md           # This file
```

## Keyboard Shortcuts

| Key     | Action              |
| ------- | ------------------- |
| `←`     | Previous project    |
| `→`     | Next project        |
| `Space` | Play/Pause carousel |

## Tech Stack

- **Server**: Express.js
- **Styling**: Custom CSS with CSS Variables
- **Fonts**: Syne (headings) + Space Mono (body)
- **Syntax Highlighting**: Prism.js
- **Hosting**: Railway (recommended)

## Tips for Best Results

1. **GitHub Pages Projects** - If your projects are hosted on GitHub Pages, they'll embed perfectly in the iframe
2. **Source Files** - Use raw GitHub URLs (`raw.githubusercontent.com`) for source code
3. **X-Frame-Options** - Some sites block iframe embedding; use your own GitHub Pages projects for best results
4. **Colors** - Choose distinct accent colors for each project to make the carousel more dynamic

## License

MIT License - Feel free to use this template for your own portfolio!

---

Built with ❤️ by Timothy A. Whitehead
