# WezTerm Configuration

Gruvbox Material · Powerline · Smart Splits · Workspaces · Git-aware

---

## 1. Leader Key

The leader key is the foundation of everything. It works exactly like tmux's prefix key.

### How it works

- Press `Ctrl+A`, then release both keys
- You now have **1.5 seconds** to press the next key
- The status bar at the bottom-left shows **LEADER** in yellow when active
- To send a real `Ctrl+A` to the terminal (e.g. jump to start of line in bash), press `Ctrl+A` twice

```
┌─────────────────────────────────────────────┐
│  Ctrl+A  →  status bar shows LEADER         │
│  then press next key within 1.5 seconds     │
│  Ctrl+A, Ctrl+A  →  sends real Ctrl+A       │
└─────────────────────────────────────────────┘
```

---

## 2. Pane Splits

| Shortcut            | Action                                               | Visual           |
| ------------------- | ---------------------------------------------------- | ---------------- |
| `Ctrl+A` then `\`   | Split **horizontally** (side by side)                | `[left \| right]` |
| `Ctrl+A` then `-`   | Split **vertically** (top and bottom)                | `[top / bottom]` |
| `Ctrl+A` then `x`   | **Close** current pane (asks confirmation)           |                  |
| `Ctrl+A` then `z`   | **Zoom** current pane to full screen (toggle)        |                  |
| `Ctrl+A` then `o`   | **Rotate** panes clockwise                           |                  |
| `Ctrl+A` then `Space` | **Swap** panes — shows labels, pick one to swap with |                |
| `Ctrl+A` then `q`   | **Pick** pane visually (labelled overlay)            |                  |

---

## 3. Smart Splits — Seamless Neovim ↔ WezTerm Navigation

The same keys move between WezTerm panes **and** Neovim splits without thinking about which one you're in.

| Shortcut | Action                |
| -------- | --------------------- |
| `Ctrl+H` | Move focus **left**   |
| `Ctrl+J` | Move focus **down**   |
| `Ctrl+K` | Move focus **up**     |
| `Ctrl+L` | Move focus **right**  |
| `Alt+H`  | **Resize** pane left  |
| `Alt+J`  | **Resize** pane down  |
| `Alt+K`  | **Resize** pane up    |
| `Alt+L`  | **Resize** pane right |

> **Neovim side:** install [`mrjones2014/smart-splits.nvim`](https://github.com/mrjones2014/smart-splits.nvim) — the plugin spec is already at `~/.config/nvim/lua/plugins/smart-splits.lua`.
> Without it the WezTerm side still navigates between WezTerm panes; you just won't get the seamless split-crossing.

> **Note on resize:** `Alt+H/L` resize WezTerm panes only and are **not** forwarded to Neovim, avoiding a conflict with aerial's `Alt+J/K` symbol-jump bindings.

---

## 4. Tab Management

Tabs are like browser tabs — each one contains its own set of panes.

| Shortcut              | Action                                    |
| --------------------- | ----------------------------------------- |
| `Ctrl+A` then `c`     | **Create** new tab                        |
| `Ctrl+A` then `n`     | **Next** tab                              |
| `Ctrl+A` then `p`     | **Previous** tab                          |
| `Ctrl+A` then `1`–`9` | Jump to tab **by number**                 |
| `Ctrl+A` then `&`     | **Close** current tab (asks confirmation) |
| `Ctrl+A` then `f`     | **Fuzzy search** all tabs                 |
| `Ctrl+A` then `T`     | **Rename** current tab                    |

The tab bar lives at the **bottom** and shows a process icon, the tab title, and indicators for zoomed (``) and tabs with unseen output (`●`).

```
┌────────────────────────────────────────────────────────────────┐
│  terminal content                                              │
│                                                                │
├──────────┬──────────┬──────────┬─────────────────────────────┤
│ ◀1▶  zsh │  2  nvim │  3  htop │  ~/projects  main  default 14:32 │
└──────────┴──────────┴──────────┴─────────────────────────────┘
  tabs ↑                              cwd ↑  branch ↑  workspace ↑  time ↑
```

---

## 5. Workspaces — Project-Based Sessions

Workspaces are named groups of tabs and panes. Think of them as separate desktops for different projects — this is what replaces tmux sessions.

| Shortcut              | Action                                      |
| --------------------- | ------------------------------------------- |
| `Ctrl+A` then `s`     | **List / switch** workspaces (fuzzy finder) |
| `Ctrl+A` then `w`     | **Create** new workspace (prompts for name) |
| `Ctrl+A` then `$`     | **Rename** current workspace                |
| `Ctrl+A` then `[`     | Switch to **previous** workspace            |
| `Ctrl+A` then `]`     | Switch to **next** workspace                |
| `Ctrl+A` then `l`     | **Fuzzy launcher** — search tabs + workspaces together |

```
1. Start WezTerm → you're in workspace "default"

2. Ctrl+A, w → type "api-server" → Enter
   → New workspace created, you're now in "api-server"
   → Open tabs, split panes, run your server

3. Ctrl+A, w → type "frontend" → Enter
   → Another workspace, set up your dev server

4. Ctrl+A, s → fuzzy finder shows:
   ┌─────────────────────────┐
   │  > default              │
   │    api-server           │
   │    frontend             │
   └─────────────────────────┘
   → Select one to switch instantly
   → All your panes and tabs are exactly where you left them
```

---

## 6. Session Persistence (Unix Domain)

Terminal sessions survive closing the WezTerm window. Re-open WezTerm and re-attach to pick up exactly where you left off.

| Shortcut                | Action                                     |
| ----------------------- | ------------------------------------------ |
| `Ctrl+A` then `Shift+A` | **Attach** to persistent session           |
| `Ctrl+A` then `Shift+D` | **Detach** from session (keeps it running) |

---

## 7. Utility

| Shortcut              | Action                                                        |
| --------------------- | ------------------------------------------------------------- |
| `Ctrl+A` then `u`     | **Quick select** — label & copy any git SHA, URL, IP on screen |
| `Ctrl+Shift+[`        | **Copy mode** — vi-style keyboard selection without the mouse |
| `F1`                  | **Command palette** — searchable list of all actions         |
| `Ctrl+=`              | Increase font size                                            |
| `Ctrl+-`              | Decrease font size                                            |
| `Ctrl+0`              | Reset font size                                               |
| `Ctrl+A` then `b`     | **Toggle opacity** — distraction-free transparent mode        |
| `Ctrl+click`          | Open hyperlink in default browser                             |

---

## 8. Status Bar

```
[ ▶ ] [ workspace ]          ~/projects  main  default  14:32
  ↑        ↑                     ↑         ↑       ↑       ↑
 mode   workspace name          cwd      branch  workspace  clock
```

- **Left:** shows `LEADER` in yellow while the prefix is active; otherwise a quiet `` icon
- **Right:** current directory (shortened) → git branch → battery % → clock
- Git branch is cached for 10 seconds to avoid shell-out overhead

---

## 9. Mouse

| Action               | Result                                              |
| -------------------- | --------------------------------------------------- |
| Left-click drag      | Select text (copied to clipboard on release)        |
| Right-click          | Copy selection if active, otherwise paste           |
| `Ctrl+click`         | Open link at cursor in default browser              |

---

## 10. Process Icons in Tabs

The tab title automatically picks an icon based on the running process:

| Process              | Icon |
| -------------------- | ---- |
| `nvim` / `vim`       |  |
| `zsh` / `fish` / `bash` |  |
| `node`               |  |
| `python` / `python3` |  |
| `cargo` / `rustc`    |  |
| `go`                 |  |
| `docker`             |  |
| `git` / `lazygit`    |  |
| `ssh`                | 󰒋 |
| `htop` / `btop`      |  |
| `psql`               |  |

---

## Files

```
~/.config/wezterm/
└── wezterm.lua          # single-file config — all settings in one place

~/.config/nvim/lua/plugins/
└── smart-splits.lua     # Neovim plugin for seamless pane navigation
```
