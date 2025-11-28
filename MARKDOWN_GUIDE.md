# Markdown Content System - Tournament Info

## Overview

The tournament info pages now use Markdown files for content management. This allows you to easily edit text content without modifying Dart code.

## File Structure

```
assets/
  markdown/
    tournament_info/
      general.md              # Información General
      tournament_system.md    # Sistema de Torneo
      prizes_and_funding.md   # Premios y Financiamiento
      participants.md         # Participantes
      schedule.md             # Cronograma
      md1.md                  # Tournament Subsection: MD1
      md3.md                  # Tournament Subsection: MD3
      mulligan.md             # Tournament Subsection: Mulligan
      scoring.md              # Tournament Subsection: Puntuación
      timing.md               # Tournament Subsection: Tiempos
```

## How to Edit Content

1. Navigate to the appropriate `.md` file in `assets/markdown/tournament_info/`
2. Edit the file using any text editor
3. Save the file
4. Hot reload your Flutter app to see changes

## Markdown Syntax

### Headers
```markdown
# H1 Header
## H2 Header
### H3 Header
```

### Text Formatting
```markdown
**Bold text**
*Italic text*
**_Bold and italic_**
```

### Lists

Unordered:
```markdown
- Item 1
- Item 2
  - Nested item
```

Ordered:
```markdown
1. First item
2. Second item
3. Third item
```

### Links
```markdown
[Link text](https://example.com)
```

### Images

**Important**: Images must be in the `assets/images/` folder and referenced in `pubspec.yaml`.

```markdown
![Image description](assets/images/your_image.png)
```

Example:
```markdown
![Tournament logo](assets/images/logo.png)
```

### Code Blocks
````markdown
```
Code block
```
````

### Blockquotes
```markdown
> This is a quote
```

### Horizontal Rule
```markdown
---
```

## Adding Images

1. Place your image in `assets/images/`
2. Ensure the image is referenced in `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/images/
   ```
3. Reference it in your markdown:
   ```markdown
   ![Description](assets/images/your_image.png)
   ```

## Styling

The markdown is styled with the app's color scheme:
- **Text**: Beige (#EAddCF)
- **Headers**: Beige, bold, varying sizes
- **Bullet points**: Ocher (#D69C41)
- **Code**: Ocher on dark background
- **Background**: Coal Grey (#2D2D2D)

## Examples

### Example 1: Simple Content
```markdown
# Welcome

This is a simple tournament page with **important** information.

## Rules

1. Be respectful
2. Follow the schedule
3. Have fun!
```

### Example 2: Content with Image
```markdown
# Tournament Logo

Here's our official logo:

![Tournament Logo](assets/images/tournament_logo.png)

## About

This tournament features...
```

### Example 3: Complex Content
```markdown
# Tournament Schedule

## Day 1 - Opening

### Morning Session (9:00 AM - 12:00 PM)
- Registration
- Opening ceremony
- **First round begins**

### Afternoon Session (2:00 PM - 6:00 PM)
- Second round
- Third round

![Schedule diagram](assets/images/schedule.png)

> Note: Times are approximate and subject to change.

---

For more information, contact the organizers.
```

## Technical Details

### Service Class
The `MarkdownContentService` handles loading markdown files:
- Location: `lib/feature/tournament_info/services/markdown_content_service.dart`
- Loads content based on section/subsection
- Provides error handling

### Content Widgets
All content widgets now use `FutureBuilder` to:
1. Load markdown content asynchronously
2. Show loading indicator while loading
3. Display error message if loading fails
4. Render markdown with custom styling

### Package Used
- **flutter_markdown**: ^0.7.4+1
- Automatically handles markdown parsing and rendering
- Supports images, links, and all standard markdown features
