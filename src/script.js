// Database structure
const database = {
    scooby: {
        'lua-scripts': [],
        'outfits': [],
        'vehicles': []
    },
    nenyoo: {
        'lua-scripts': [],
        'outfits': [],
        'vehicles': []
    },
    atlas: {
        'lua-scripts': [],
        'outfits': [],
        'vehicles': []
    }
};

let currentMenu = 'scooby';
let currentCategory = 'lua-scripts';
let allFiles = [];

// Initialize the app
document.addEventListener('DOMContentLoaded', () => {
    initializeEventListeners();
    loadFiles();
});

function initializeEventListeners() {
    // Menu buttons
    document.querySelectorAll('.menu-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.menu-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentMenu = btn.dataset.menu;
            displayFiles();
        });
    });

    // Category buttons
    document.querySelectorAll('.category-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.category-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentCategory = btn.dataset.category;
            displayFiles();
        });
    });

    // Search input
    document.getElementById('searchInput').addEventListener('input', (e) => {
        displayFiles(e.target.value);
    });
}

// Load files from data folder
async function loadFiles() {
    const menus = ['scooby', 'nenyoo', 'atlas'];
    const categories = ['lua-scripts', 'outfits', 'vehicles'];

    for (const menu of menus) {
        for (const category of categories) {
            try {
                const response = await fetch(`data/${menu}/${category}/files.json`);
                if (response.ok) {
                    const files = await response.json();
                    database[menu][category] = files;
                }
            } catch (error) {
                // If files.json doesn't exist, try to list directory
                console.log(`No files.json found for ${menu}/${category}`);
            }
        }
    }

    displayFiles();
}

// Display files based on current selection
function displayFiles(searchQuery = '') {
    const contentDiv = document.getElementById('content');
    const files = database[currentMenu][currentCategory];

    // Filter files based on search query
    const filteredFiles = files.filter(file => 
        file.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        (file.description && file.description.toLowerCase().includes(searchQuery.toLowerCase()))
    );

    if (filteredFiles.length === 0) {
        contentDiv.innerHTML = `
            <div class="empty-state">
                <p>${searchQuery ? 'No files match your search.' : 'No files found. Add files to the data folder to get started.'}</p>
                <p style="margin-top: 1rem; font-size: 0.9rem;">Add a files.json to data/${currentMenu}/${currentCategory}/</p>
            </div>
        `;
        return;
    }

    contentDiv.innerHTML = filteredFiles.map(file => createFileCard(file)).join('');
}

// Create HTML for a file card
function createFileCard(file) {
    const categoryLabel = currentCategory.replace('-', ' ').toUpperCase();
    const authorHtml = file.author ? `<p><strong>Author:</strong> ${file.author}</p>` : '';
    const versionHtml = file.version ? `<p><strong>Version:</strong> ${file.version}</p>` : '';
    
    return `
        <div class="file-card">
            <h3>${file.name}</h3>
            <div class="file-info">
                <p>${file.description || 'No description available'}</p>
                ${authorHtml}
                ${versionHtml}
            </div>
            <a href="${file.path}" class="download-btn" download>Download</a>
        </div>
    `;
}

// Helper function to get file extension icon
function getFileIcon(category) {
    const icons = {
        'lua-scripts': '',
        'outfits': '',
        'vehicles': ''
    };
    return icons[category] || '';
}
