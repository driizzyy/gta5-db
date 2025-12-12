const fs = require('fs');
const path = require('path');

const menus = ['scooby', 'nenyoo', 'atlas'];
const categories = ['lua-scripts', 'outfits', 'vehicles'];

// File extensions for each category
const categoryExtensions = {
    'lua-scripts': ['.lua', '.txt'],
    'outfits': ['.json', '.xml', '.txt'],
    'vehicles': ['.json', '.xml', '.txt', '.ini']
};

function scanDirectory(dirPath) {
    if (!fs.existsSync(dirPath)) {
        return [];
    }
    
    const files = fs.readdirSync(dirPath);
    return files.filter(file => {
        const filePath = path.join(dirPath, file);
        const stat = fs.statSync(filePath);
        return stat.isFile() && file !== 'files.json';
    });
}

function generateFileEntry(menu, category, filename) {
    const ext = path.extname(filename);
    const nameWithoutExt = path.basename(filename, ext);
    
    return {
        name: nameWithoutExt.replace(/-|_/g, ' ').replace(/\b\w/g, l => l.toUpperCase()),
        description: `${nameWithoutExt} for ${menu.charAt(0).toUpperCase() + menu.slice(1)} Mod Menu`,
        author: "Community",
        version: "1.0",
        path: `data/${menu}/${category}/${filename}`
    };
}

console.log('Scanning directories and generating files.json...\n');

menus.forEach(menu => {
    categories.forEach(category => {
        const dirPath = path.join('data', menu, category);
        const files = scanDirectory(dirPath);
        
        // Filter out files.json itself
        const contentFiles = files.filter(f => f !== 'files.json');
        
        const fileEntries = contentFiles.map(file => 
            generateFileEntry(menu, category, file)
        );
        
        const jsonPath = path.join(dirPath, 'files.json');
        fs.writeFileSync(jsonPath, JSON.stringify(fileEntries, null, 4));
        
        console.log(` ${menu}/${category}: ${contentFiles.length} files found`);
    });
});

console.log('\n All files.json generated successfully!');
console.log('You can now commit and push your changes.');
