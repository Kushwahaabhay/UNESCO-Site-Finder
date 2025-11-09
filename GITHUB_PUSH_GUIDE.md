# 📤 How to Push This Project to GitHub

Follow these steps to upload your project to GitHub:

## Step 1: Verify Everything is Ready

✅ **Check that sensitive files are protected:**
```bash
# Make sure these files exist and are configured:
# - .gitignore (already created)
# - lib/config/api_keys_example.dart (template file)
# - android/local.properties.example (template file)

# Make sure these files will NOT be committed (they're in .gitignore):
# - lib/config/api_keys.dart (your actual keys)
# - android/local.properties (your paths and keys)
```

## Step 2: Initialize Git Repository

```powershell
cd d:\APP

# Initialize git
git init

# Add all files (gitignore will exclude sensitive files automatically)
git add .

# Check what will be committed (verify no API keys are included)
git status
```

**⚠️ IMPORTANT: Verify these files are NOT in the git status list:**
- `lib/config/api_keys.dart`
- `android/local.properties`

## Step 3: Make First Commit

```powershell
git commit -m "Initial commit: UNESCO Sites Flutter App

- Complete Flutter app with 42 UNESCO sites in India
- GPS location and distance calculation
- Google Maps integration
- AI chatbot with Gemini/Perplexity
- Search, filter, and sort functionality
- Favorites system
- Dark mode support
- Material Design 3 UI"
```

## Step 4: Create GitHub Repository

1. Go to https://github.com
2. Click the **"+"** icon → **"New repository"**
3. Fill in:
   - **Repository name:** `nearest-unesco-site` (or your preferred name)
   - **Description:** "Flutter app to discover India's UNESCO World Heritage Sites with GPS, maps, and AI chatbot"
   - **Visibility:** Choose Public or Private
   - **DO NOT** initialize with README (we already have one)
4. Click **"Create repository"**

## Step 5: Connect and Push to GitHub

GitHub will show you commands, but here's the detailed version:

```powershell
# Add GitHub as remote origin (replace YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/nearest-unesco-site.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

**If you have 2FA enabled or get password errors:**
```powershell
# You'll need a Personal Access Token instead of password
# Go to: GitHub Settings → Developer settings → Personal access tokens → Generate new token
# Give it 'repo' permissions
# Use the token as your password when pushing
```

## Step 6: Update README on GitHub

After pushing, you should:

1. **Replace README.md with README_GITHUB.md:**
   ```powershell
   # Remove old README and rename the GitHub version
   Remove-Item README.md
   Rename-Item README_GITHUB.md README.md
   
   # Commit the change
   git add README.md
   git commit -m "Update README for GitHub"
   git push
   ```

2. **Update README with your info:**
   - Replace `[Your Name]` with your actual name
   - Replace `[@yourtwitter]` with your Twitter/social handle
   - Replace `https://github.com/yourusername` with your actual GitHub URL
   - Add screenshots if you have them

## Step 7: Add Screenshots (Optional but Recommended)

```powershell
# Create screenshots directory
mkdir screenshots

# Add your app screenshots (take screenshots from your phone)
# Copy images to: screenshots/home.png, screenshots/map.png, etc.

# Update README.md to include screenshots:
# Replace the placeholder with:
# ![Home Screen](screenshots/home.png)
# ![Map View](screenshots/map.png)

# Commit screenshots
git add screenshots/
git commit -m "Add app screenshots"
git push
```

## Step 8: Verify Everything is Secure

**Double-check on GitHub web interface:**

1. ✅ Go to your repository on GitHub
2. ✅ Click on **"lib/config/"** folder
3. ✅ Verify you see `api_keys_example.dart` but **NOT** `api_keys.dart`
4. ✅ Click on **"android/"** folder
5. ✅ Verify you see `local.properties.example` but **NOT** `local.properties`
6. ✅ Search your repo for your actual API keys (they should NOT appear anywhere)

## Step 9: Add GitHub Repository Details

1. Go to your repository on GitHub
2. Click **"Settings"** (repository settings)
3. Scroll to **"About"** section
4. Add:
   - **Description:** "Flutter app to discover India's UNESCO World Heritage Sites"
   - **Website:** (if you have a demo/website)
   - **Topics:** Add tags like: `flutter`, `dart`, `android`, `unesco`, `maps`, `gps`, `ai-chatbot`, `material-design`, `mobile-app`

## Step 10: Share Your Project!

Your project is now on GitHub! Share it:

```
Repository URL: https://github.com/YOUR_USERNAME/nearest-unesco-site
```

**Share on:**
- Twitter/X with hashtags: #Flutter #AndroidDev #UNESCO
- LinkedIn
- Reddit (r/FlutterDev)
- Dev.to or Medium (write a blog post about it!)

## 🎯 Future Updates

When you make changes to your project:

```powershell
# Add changes
git add .

# Commit with a descriptive message
git commit -m "Add feature: [describe your change]"

# Push to GitHub
git push
```

## 🔒 Security Checklist

Before pushing, verify:
- [ ] `.gitignore` file exists and is properly configured
- [ ] `lib/config/api_keys.dart` is in `.gitignore`
- [ ] `android/local.properties` is in `.gitignore`
- [ ] Example files (`api_keys_example.dart`, `local.properties.example`) exist
- [ ] README includes setup instructions for API keys
- [ ] No API keys visible in any committed files

## 🆘 If You Accidentally Committed API Keys

**If you pushed API keys by mistake:**

1. **Immediately revoke/regenerate all exposed keys:**
   - Google Maps: Create new key in Google Cloud Console
   - Gemini: Generate new key in Google AI Studio
   - Perplexity: Generate new key in Perplexity settings

2. **Remove from Git history:**
   ```powershell
   # Remove file from git but keep local copy
   git rm --cached lib/config/api_keys.dart
   git commit -m "Remove sensitive file"
   
   # If already pushed, you'll need to force push (DANGEROUS!)
   # This rewrites history - only do if repo is new/private
   git push -f origin main
   ```

3. **Verify `.gitignore` is working:**
   ```powershell
   # This should show the file is ignored
   git status
   ```

---

## 📝 Common Git Commands Reference

```powershell
# Check status
git status

# Add specific file
git add filename.dart

# Add all changes
git add .

# Commit changes
git commit -m "Your message"

# Push to GitHub
git push

# Pull latest changes
git pull

# View commit history
git log --oneline

# Create new branch
git checkout -b feature-name

# Switch branches
git checkout main
```

---

**🎉 Congratulations! Your project is now on GitHub!**

**Don't forget to:**
- ⭐ Star your own repo (why not!)
- 📝 Write a good README
- 📸 Add screenshots
- 🏷️ Add topic tags
- 📢 Share with the community

Good luck with your project! 🚀
