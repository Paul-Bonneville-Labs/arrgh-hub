---
name: local-servers-kill
description: Kill all locally running development servers (frontend and backend)
---

# Kill Local Servers

Terminates all locally running development servers for the current project.

## Usage

```bash
/local-servers-kill
```

## What it does

- Kills all Next.js frontend servers
- Kills all FastAPI/uvicorn backend servers  
- Clears ports 3000, 3001, and 8000
- Provides verification of server termination

## Implementation

```javascript
const path = require('path');
const { execSync } = require('child_process');

// Find the project root by looking for local-servers-kill.sh
let currentDir = process.cwd();
let scriptPath = null;

while (currentDir !== '/') {
  const possibleScript = path.join(currentDir, 'local-servers-kill.sh');
  try {
    require('fs').accessSync(possibleScript, require('fs').constants.F_OK);
    scriptPath = possibleScript;
    break;
  } catch (e) {
    currentDir = path.dirname(currentDir);
  }
}

if (!scriptPath) {
  console.log('❌ Error: local-servers-kill.sh not found in current directory or parent directories');
  process.exit(1);
}

try {
  const result = execSync(`cd "${path.dirname(scriptPath)}" && ./local-servers-kill.sh`, { 
    encoding: 'utf8',
    stdio: 'inherit'
  });
} catch (error) {
  console.log('❌ Error executing kill script:', error.message);
  process.exit(1);
}
```