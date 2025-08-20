---
name: local-servers-restart
description: Kill and restart all local development servers (frontend and backend)
---

# Restart Local Servers

Kills all existing development servers and restarts both frontend and backend servers.

## Usage

```bash
/local-servers-restart
```

## What it does

- Kills all existing Next.js and FastAPI servers
- Clears ports 3000, 3001, and 8000
- Starts FastAPI backend on port 8000
- Starts Next.js frontend on port 3000
- Provides server health verification and log file locations

## Implementation

```javascript
const path = require('path');
const { execSync } = require('child_process');

// Find the project root by looking for local-servers-restart.sh
let currentDir = process.cwd();
let scriptPath = null;

while (currentDir !== '/') {
  const possibleScript = path.join(currentDir, 'local-servers-restart.sh');
  try {
    require('fs').accessSync(possibleScript, require('fs').constants.F_OK);
    scriptPath = possibleScript;
    break;
  } catch (e) {
    currentDir = path.dirname(currentDir);
  }
}

if (!scriptPath) {
  console.log('❌ Error: local-servers-restart.sh not found in current directory or parent directories');
  process.exit(1);
}

try {
  const result = execSync(`cd "${path.dirname(scriptPath)}" && ./local-servers-restart.sh`, { 
    encoding: 'utf8',
    stdio: 'inherit'
  });
} catch (error) {
  console.log('❌ Error executing restart script:', error.message);
  process.exit(1);
}
```