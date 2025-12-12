# GTA 5 Mod Menu Database

A comprehensive database website for GTA 5 mod menu content including Lua scripts, modded outfits, and modded vehicles for Scooby, Nenyoo, and Atlas mod menus.

##  Features

- **Three Mod Menus**: Scooby, Nenyoo, and Atlas
- **Three Categories**: Lua Scripts, Outfits, and Vehicles
- **Search Functionality**: Easily find files by name or description
- **Responsive Design**: Works on desktop and mobile devices
- **Dark Theme**: Easy on the eyes with a modern gradient design
- **AUTOMATED**: No manual JSON editing required!

##  Project Structure

```
luas/
 index.html              # Main website file
 README.md               # This file
 package.json            # Node.js configuration
 generate-database.js    # Auto-generator script
 src/                    # Website source files
    styles.css         # Stylesheet
    script.js          # JavaScript functionality
 data/                  # Content database
     scooby/
        lua-scripts/
        outfits/
        vehicles/
     nenyoo/
        lua-scripts/
        outfits/
        vehicles/
     atlas/
         lua-scripts/
         outfits/
         vehicles/
```

##  Quick Start

### Step 1: Add Your Files

Simply drop your files into the appropriate folder:

**For Scooby Mod Menu:**
- `data/scooby/lua-scripts/` - Add .lua or .txt files
- `data/scooby/outfits/` - Add .json, .xml, or .txt files
- `data/scooby/vehicles/` - Add .json, .xml, .txt, or .ini files

**For Nenyoo Mod Menu:**
- `data/nenyoo/lua-scripts/`
- `data/nenyoo/outfits/`
- `data/nenyoo/vehicles/`

**For Atlas Mod Menu:**
- `data/atlas/lua-scripts/`
- `data/atlas/outfits/`
- `data/atlas/vehicles/`

### Step 2: Run Auto-Generator

After adding your files, run:

```bash
npm run update
```

Or directly:

```bash
node generate-database.js
```

**That's it!** The script automatically scans all folders and creates the database files. No manual editing needed!

### Step 3: View Your Website

Open `index.html` in your browser to see your files displayed, or push to GitHub Pages.

##  Hosting on GitHub Pages

1. Create a new repository on GitHub
2. Add all files: `git add .`
3. Commit: `git commit -m "Initial commit"`
4. Push: `git push origin main`
5. Go to Settings > Pages
6. Select the branch (`main`) and root directory
7. Click Save
8. Your site will be live at `https://yourusername.github.io/repository-name`

**Before pushing**: Always run `npm run update` to regenerate the database!

##  Updating Your Database

Whenever you add new files:

1. Drop files into the appropriate `data/` folder
2. Run `npm run update`
3. Commit and push changes

The script automatically:
- Scans all folders
- Generates proper file names from filenames
- Creates download links
- Updates all `files.json` files

##  How It Works

- The website is pure HTML/CSS/JS (no backend needed)
- Browsers can't read directories directly (security)
- The `generate-database.js` script scans your folders locally
- It creates `files.json` files that the website reads
- GitHub Pages serves everything statically

##  Customization

### Edit the Auto-Generator

Open `generate-database.js` to customize:
- File name formatting
- Default descriptions
- Author names
- Supported file extensions

### Edit the Website

- `src/styles.css` - Change colors and styling
- `src/script.js` - Add new features
- `index.html` - Change the layout

##  Disclaimer

This website is for educational purposes only. Users are responsible for ensuring their use complies with all applicable terms of service and laws.

##  License

Free to use and modify for personal projects.
