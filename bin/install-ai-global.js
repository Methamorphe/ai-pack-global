#!/usr/bin/env node
import { existsSync } from 'node:fs';
import { spawnSync } from 'node:child_process';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const VERSION = '3.2.1';
const here = dirname(fileURLToPath(import.meta.url));
const root = join(here, '..');
const args = process.argv.slice(2);

if (args.includes('--version')) {
  console.log(VERSION);
  process.exit(0);
}

function findBash() {
  if (process.platform !== 'win32') return 'bash';

  const candidates = [
    process.env.AI_PACK_BASH,
    process.env.BASH_PATH,
    process.env.ProgramFiles && join(process.env.ProgramFiles, 'Git', 'bin', 'bash.exe'),
    process.env.ProgramFiles && join(process.env.ProgramFiles, 'Git', 'usr', 'bin', 'bash.exe'),
    process.env['ProgramFiles(x86)'] && join(process.env['ProgramFiles(x86)'], 'Git', 'bin', 'bash.exe'),
    process.env.LOCALAPPDATA && join(process.env.LOCALAPPDATA, 'Programs', 'Git', 'bin', 'bash.exe'),
    'C:\\Program Files\\Git\\bin\\bash.exe',
    'C:\\Program Files\\Git\\usr\\bin\\bash.exe',
  ].filter(Boolean);

  const whereGit = spawnSync('where.exe', ['git.exe'], { encoding: 'utf8', windowsHide: true });
  if (whereGit.status === 0 && whereGit.stdout) {
    for (const line of whereGit.stdout.split(/\r?\n/).filter(Boolean)) {
      const gitPath = resolve(line.trim());
      const gitRoot = dirname(dirname(gitPath));
      candidates.unshift(join(gitRoot, 'bin', 'bash.exe'), join(gitRoot, 'usr', 'bin', 'bash.exe'));
    }
  }

  for (const candidate of candidates) {
    if (existsSync(candidate)) return candidate;
  }

  console.error('AI Global Pack: Git Bash was not found on Windows.');
  console.error('Install Git for Windows (https://git-scm.com/download/win), then rerun this command.');
  console.error('You can also set AI_PACK_BASH to the full path of bash.exe.');
  process.exit(1);
}

const uninstall = args[0] === 'uninstall';
if (uninstall) args.shift();
const script = join(root, uninstall ? 'uninstall-ai-global.sh' : 'install-ai-global.sh');
const bash = findBash();
const result = spawnSync(bash, [script, ...args], { stdio: 'inherit', windowsHide: true });

if (result.error) {
  console.error(`Failed to start ${bash}: ${result.error.message}`);
  process.exit(1);
}

process.exit(result.status ?? 1);
