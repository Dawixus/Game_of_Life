# 🧬 Conway's Game of Life

This project is an implementation of the classic cellular automaton **Conway's Game of Life** written in **Haskell**.  
It simulates the evolution of a grid of cells based on a small set of simple rules.

---

## 📖 Rules

Each cell exists in one of two states: **alive** or **dead**.  
At each step (generation), the state of the grid updates simultaneously according to the number of live neighbors:

- 🟢 A **live cell survives** if it has **2 or 3 live neighbors**
- 🔴 A **live cell dies** if it has fewer than 2 (underpopulation) or more than 3 neighbors (overpopulation)
- ⚪ A **dead cell becomes alive** if it has **exactly 3 live neighbors**

---

## ⚙️ Features

- Terminal animation of cellular automaton
- Load initial state from file
- Pause / resume simulation (`p`)
- Quit simulation (`q`)
- Automatic boundary-safe neighbor calculation
- Simple and readable grid format (`#` alive, `.` dead)

---

## ⌨️ Controls

While simulation is running:

| Key | Action |
|-----|--------|
| `p` | Pause / resume |
| `q` | Quit simulation |

---

## 📃 Input file format

The grid is stored as plain text:

- `#` = alive cell
- `.` = dead cell
- All rows must have the same length

### Example

~~~
.....
..#..
...#.
.###.
.....
~~~

---

## ⏯️ How to run
~~~
./Main [file name]
~~~
