# Cellular Automaton Simulator – Code Documentation

## Overview

This project is a simple terminal-based cellular automaton simulator inspired by Conway’s Game of Life.

The program:
- Loads a grid from a file
- Converts it into a 2D integer matrix
- Simulates evolution over time
- Renders the grid in the terminal
- Supports pause (`p`) and quit (`q`)

Cell representation:
- `#` = alive (1)
- `.` = dead (0)

---

## Modules Used

- `System.IO` – terminal input/output
- `System.Environment` – command-line arguments
- `System.Directory` – file existence checking
- `Control.Concurrent` – delays (animation timing)
- `Control.Exception` – runtime errors

---

## Grid Parsing

### `cellToInt :: Char -> Int`

Converts a character into a numeric cell state.

| Character | Meaning | Value |
|----------|--------|-------|
| `#` | alive | 1 |
| `.` | dead | 0 |

---

### `generateGrid :: String -> [[Int]]`

Converts raw file content into a grid.

Steps:
- Split input into lines
- Convert each character using `cellToInt`


---

### `generateMapFromFile :: String -> IO [[Int]]`

Loads a file and parses it into a grid.

Steps:
1. Read file content
2. Convert string to grid

---

## Validation

### `checkGridSize :: [[Int]] -> Bool`

Ensures the grid is rectangular.

Rules:
- All rows must have equal length
- Empty grid is invalid (`False`)

---

## Grid Access

### `getCellValue :: [[Int]] -> Int -> Int -> Int`

Safely returns the value of a cell.

Behavior:
- Out of bounds → returns `0`
- Otherwise returns actual value

---

### `getNeighborSum :: [[Int]] -> Int -> Int -> Int`

Calculates sum of the 8 neighboring cells

---

## Simulation Logic

### `getNextCellValue :: [[Int]] -> Int -> Int -> Int`

Applies rules to determine next state:

| Neighbors | Result |
|----------|--------|
| 3 | alive (1) |
| 2 | unchanged |
| otherwise | dead (0) |

---

### `calculateNextMove :: [[Int]] -> [[Int]]`

Generates the next generation of the grid.

- Applies rules to every cell
- Produces a new grid

---

## Rendering

### `printGrid :: [[Int]] -> IO ()`

Prints grid to terminal.

Mapping:
- `0 → .`
- `1 → #`

---

## Simulation Engine

### `simulate :: [[Int]] -> IO ()`

Main loop:

1. Clear terminal (`\ESC[2J`)
2. Print grid
3. Wait (`threadDelay`)
4. Compute next generation
5. Handle input:
   - `q` → quit
   - `p` → pause
   - other → continue

---

### `paused :: [[Int]] -> IO ()`

Pause loop:

- Waits for keyboard input
- `p` resumes simulation
- other keys are ignored

---

## Program Entry Point

### `main :: IO ()`

Execution flow:

1. Set terminal buffering and echo settings
2. Read command-line arguments
3. Validate file existence
4. Load and parse grid
5. Validate grid shape
6. Start simulation

Error cases:
- No argument → error
- File not found → error
- Invalid grid → error

---

## Input File Format

Grid must be a rectangular text file:

- `#` = alive cell
- `.` = dead cell

