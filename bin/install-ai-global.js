#!/usr/bin/env node
import { spawnSync } from 'node:child_process';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const root = join(here, '..');
const args = process.argv.slice(2);
const uninstall = args[0] === 'uninstall';
if (uninstall) args.shift();
const script = join(root, uninstall ? 'uninstall-ai-global.sh' : 'install-ai-global.sh');
const result = spawnSync('bash', [script, ...args], { stdio: 'inherit' });
if (result.error) {
  console.error(result.error.message);
  process.exit(1);
}
process.exit(result.status ?? 1);
