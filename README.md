# Simple LÖVE2D Lua Game

This is a simple 2D game built with [LÖVE2D](https://love2d.org/) and Lua.

## How to Run

1. **Install LÖVE2D** (if you don't have it):
	```sh
	brew install love
	```

2. **Run the game**:
	```sh
	cd /path/to/this/folder
	love .
	```

## Gameplay

- Control a rotating cannon and shoot bullets at falling enemies.
- Use **A** and **D** to rotate the cannon.
- Press **Space** to shoot.
`game in progress`

## Project Structure

- `main.lua` — main game logic
- `sprites/` — all game graphics
  - `player/` — cannon and bullet images
  - `enemy/` — enemy sprites
  - `ground/` — ground image

## Dependencies

- [LÖVE2D](https://love2d.org/) (tested with 11.x)