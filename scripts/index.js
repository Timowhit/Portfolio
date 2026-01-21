    // ============================================================
    // PROJECT DATA - Edit this section to update your projects
    // ============================================================
    const SITE_DATA = {
      projects: [
        {
          name: "Algorithmic Trading Platform",
          description: "Custom algorithmic trading system achieving 20% monthly returns with 70% consistency. Features automated stock, options, and crypto trades with real-time order tracking.",
          tags: ["Python", "API", "Trading", "Automation"],
          type: "python",
          repoUrl: "https://github.com/timowhit/Trading-Bot",
          liveUrl: null, // No live preview for Python projects
          sourceFile: "https://raw.githubusercontent.com/timowhit/Trading-Bot/main/main.py",
          color: "#00ff88"
        },
        {
          name: "Trading Analytics Dashboard",
          description: "Front-end dashboard for visualizing trading data and performance trends with interactive charts and equity reports.",
          tags: ["HTML", "CSS", "JavaScript", "Data Viz"],
          type: "web",
          repoUrl: "https://github.com/timowhit/Trading-Bot",
          liveUrl: "https://timowhit.github.io/Trading-Bot/templates/dashboard.html",
          sourceFile: "https://raw.githubusercontent.com/timowhit/Trading-Bot/main/templates/dashboard.html",
          color: "#00d4ff"
        },
        {
          name: "Portfolio Website",
          description: "This very site! A modern, responsive portfolio featuring an auto-playing project carousel with live previews and syntax-highlighted source code.",
          tags: ["HTML", "CSS", "JavaScript"],
          type: "web",
          repoUrl: "https://github.com/timowhit/timowhit.github.io",
          liveUrl: "https://timowhit.github.io",
          sourceFile: "https://raw.githubusercontent.com/timowhit/timowhit.github.io/main/index.html",
          color: "#ff6b6b"
        }
        // Add more projects here following the same structure:
        // {
        //   name: "Project Name",
        //   description: "Brief description of the project",
        //   tags: ["Tag1", "Tag2"],
        //   type: "web" | "python" | "csharp",
        //   repoUrl: "https://github.com/...",
        //   liveUrl: "https://..." or null,
        //   sourceFile: "https://raw.githubusercontent.com/.../filename.ext",
        //   color: "#hexcolor"
        // }
      ]
    };
    // ============================================================

    class ProjectCarousel {
      constructor() {
        this.projects = SITE_DATA.projects;
        this.currentIndex = 0;
        this.isPlaying = true;
        this.timer = null;
        this.duration = 8000;
        this.init();
      }

      init() {
        this.setupElements();
        this.createProgressSegments();
        this.setupEventListeners();
        this.showProject(0);
        this.startAutoPlay();
        
        // Set dynamic year in footer
        document.getElementById('currentYear').textContent = new Date().getFullYear();
      }

      setupElements() {
        this.elements = {
          previewTitle: document.getElementById('previewTitle'),
          previewTags: document.getElementById('previewTags'),
          previewDescription: document.getElementById('previewDescription'),
          previewContent: document.getElementById('previewContent'),
          liveLink: document.getElementById('liveLink'),
          repoLink: document.getElementById('repoLink'),
          codeFilename: document.getElementById('codeFilename'),
          codeContent: document.getElementById('codeContent'),
          projectNumber: document.getElementById('projectNumber'),
          progressContainer: document.getElementById('progressContainer'),
          prevBtn: document.getElementById('prevBtn'),
          nextBtn: document.getElementById('nextBtn'),
          playPauseBtn: document.getElementById('playPauseBtn'),
          copyBtn: document.getElementById('copyBtn')
        };
      }

      setupEventListeners() {
        this.elements.prevBtn.addEventListener('click', () => this.prev());
        this.elements.nextBtn.addEventListener('click', () => this.next());
        this.elements.playPauseBtn.addEventListener('click', () => this.togglePlayPause());
        this.elements.copyBtn.addEventListener('click', () => this.copyCode());

        document.addEventListener('keydown', (e) => {
          if (e.key === 'ArrowLeft') this.prev();
          if (e.key === 'ArrowRight') this.next();
          if (e.key === ' ') { e.preventDefault(); this.togglePlayPause(); }
        });
      }

      createProgressSegments() {
        this.elements.progressContainer.innerHTML = '';
        this.projects.forEach((_, index) => {
          const segment = document.createElement('div');
          segment.className = 'progress-segment';
          segment.addEventListener('click', () => this.goTo(index));
          this.elements.progressContainer.appendChild(segment);
        });
      }

      getProjectIcon(type, tags) {
        const tagStr = (tags || []).join(' ').toLowerCase();
        if (type === 'python' || tagStr.includes('python')) return '🐍';
        if (type === 'csharp' || tagStr.includes('c#')) return '⚙️';
        if (tagStr.includes('trading') || tagStr.includes('finance')) return '📈';
        if (tagStr.includes('api')) return '🔌';
        return '💻';
      }

      isWebProject(project) {
        return project.type === 'web' && project.liveUrl;
      }

      async showProject(index) {
        const project = this.projects[index];
        if (!project) return;

        // Update basic info
        this.elements.previewTitle.textContent = project.name;
        this.elements.previewDescription.textContent = project.description;
        this.elements.repoLink.href = project.repoUrl;
        this.elements.projectNumber.textContent = String(index + 1).padStart(2, '0');
        
        // Update tags
        this.elements.previewTags.innerHTML = project.tags
          .map(tag => `<span class="tag">${tag}</span>`)
          .join('');

        // Determine project type and update preview
        const isWeb = this.isWebProject(project);

        if (isWeb) {
          this.elements.previewContent.innerHTML = `
            <iframe src="${project.liveUrl}" title="Project preview"></iframe>
          `;
          this.elements.liveLink.innerHTML = 'View Live →';
          this.elements.liveLink.href = project.liveUrl;
        } else {
          const icon = this.getProjectIcon(project.type, project.tags);
          this.elements.previewContent.innerHTML = `
            <div class="project-placeholder">
              <div class="placeholder-icon">${icon}</div>
              <h3 class="placeholder-title">${project.name}</h3>
              <p class="placeholder-subtitle">${project.description}</p>
              <a href="${project.repoUrl}" target="_blank" class="placeholder-btn">
                View on GitHub →
              </a>
            </div>
          `;
          this.elements.liveLink.innerHTML = 'View Repo →';
          this.elements.liveLink.href = project.repoUrl;
        }

        // Load source code
        await this.loadSourceCode(project.sourceFile, project.repoUrl);

        // Update progress and color
        this.updateProgress(index);
        document.documentElement.style.setProperty('--accent', project.color || '#00ff88');
      }

      async loadSourceCode(url, repoUrl) {
        if (!url) {
          this.showCodeError('No source file configured', repoUrl);
          this.elements.codeFilename.textContent = 'No file';
          return;
        }

        try {
          const response = await fetch(url);
          const code = await response.text();
          
          if (!response.ok || code.includes('404:') || code.includes('Not Found')) {
            throw new Error('File not found');
          }
          
          const filename = url.split('/').pop();
          this.elements.codeFilename.textContent = filename;
          
          const ext = filename.split('.').pop();
          const langMap = {
            'html': 'html', 'htm': 'html', 'js': 'javascript', 'jsx': 'javascript',
            'ts': 'javascript', 'css': 'css', 'py': 'python', 'cs': 'csharp', 'json': 'javascript'
          };
          const lang = langMap[ext] || 'markup';
          
          this.elements.codeContent.innerHTML = `<pre><code class="language-${lang}" id="codeDisplay"></code></pre>`;
          const codeDisplay = document.getElementById('codeDisplay');
          codeDisplay.textContent = code;
          Prism.highlightElement(codeDisplay);
        } catch (error) {
          console.error('Failed to load source code:', error);
          const filename = url ? url.split('/').pop() : 'unknown';
          this.elements.codeFilename.textContent = filename;
          this.showCodeError('Could not load source file', repoUrl);
        }
      }

      showCodeError(message, repoUrl) {
        this.elements.codeContent.innerHTML = `
          <div class="code-error">
            <div class="code-error-icon">📄</div>
            <p class="code-error-message">${message}</p>
            <a href="${repoUrl}" target="_blank" class="code-error-link">Browse source on GitHub →</a>
          </div>
        `;
      }

      updateProgress(index) {
        const segments = this.elements.progressContainer.querySelectorAll('.progress-segment');
        segments.forEach((segment, i) => {
          segment.classList.remove('active', 'completed', 'paused');
          if (i < index) segment.classList.add('completed');
          else if (i === index) {
            segment.classList.add('active');
            if (!this.isPlaying) segment.classList.add('paused');
          }
        });
      }

      startAutoPlay() {
        this.stopAutoPlay();
        if (!this.isPlaying) return;
        this.timer = setTimeout(() => this.next(), this.duration);
      }

      stopAutoPlay() {
        if (this.timer) { clearTimeout(this.timer); this.timer = null; }
      }

      togglePlayPause() {
        this.isPlaying = !this.isPlaying;
        this.elements.playPauseBtn.textContent = this.isPlaying ? '❚❚' : '▶';
        this.elements.playPauseBtn.classList.toggle('playing', this.isPlaying);
        
        const activeSegment = this.elements.progressContainer.querySelector('.active');
        if (activeSegment) activeSegment.classList.toggle('paused', !this.isPlaying);
        
        if (this.isPlaying) this.startAutoPlay();
        else this.stopAutoPlay();
      }

      next() {
        this.currentIndex = (this.currentIndex + 1) % this.projects.length;
        this.showProject(this.currentIndex);
        this.startAutoPlay();
      }

      prev() {
        this.currentIndex = (this.currentIndex - 1 + this.projects.length) % this.projects.length;
        this.showProject(this.currentIndex);
        this.startAutoPlay();
      }

      goTo(index) {
        this.currentIndex = index;
        this.showProject(index);
        this.startAutoPlay();
      }

      copyCode() {
        const codeEl = document.getElementById('codeDisplay');
        if (!codeEl) return;
        navigator.clipboard.writeText(codeEl.textContent).then(() => {
          this.elements.copyBtn.textContent = 'Copied!';
          setTimeout(() => { this.elements.copyBtn.textContent = 'Copy'; }, 2000);
        });
      }
    }

    document.addEventListener('DOMContentLoaded', () => new ProjectCarousel());