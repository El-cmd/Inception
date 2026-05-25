# AGENT.md

## Project Snapshot
- Repository: `El-cmd/Inception`
- Default branch: `main`
- Detected stack: static web, shell scripts
- Notable root entries: `Doc+script/`, `Inception_v1/`, `Inception_v2/`, `README.md`
- Source mix: .sh:10, dockerfile:6, .dockerignore:6, .md:3, makefile:2, .html:2

## Working Guidelines
- Keep changes scoped to the requested behavior and follow the style already present in the touched files.
- Check `README.md`, `Makefile`, package scripts, and Docker files before introducing new commands or tooling.
- Keep changes small and aligned with the current repository structure.
- Do not commit local secrets, `.env` files, generated dependency folders, build artifacts, or editor metadata.

## Setup
- `No explicit dependency install command is defined in the repository.`

## Run
- `No canonical run command is defined; inspect README/Makefile/package scripts first.`

## Validate
- `Run the most relevant local build or smoke test before pushing changes.`
