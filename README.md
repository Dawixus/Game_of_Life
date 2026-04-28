# 🧬 Conway's Game of Life (Haskell)

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

- Grid representation using lists (or other functional structures)
- Pure functional computation of next generations
- Custom initial configurations

---

## 🧠 Concepts Used

- Pure functions and immutability
- Recursion and higher-order functions (`map`, `filter`)
- Lazy evaluation and infinite data structures

---

## ▶️ Running the Project

Run directly:

```bash
runhaskell Main.hs
