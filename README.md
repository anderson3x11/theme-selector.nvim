# theme-selector.nvim

A lightweight Neovim plugin to switch colorschemes on the fly from a simple selection menu.

Each theme lives in its own `.lua` file. Selecting one overwrites your active colorscheme config — no manual editing required.

---

## How it works

`<leader>ts` opens a selection menu listing all `.lua` files in your `lua/colorschemes/` folder. Pick one, and its contents are written into your `lua/plugins/colorscheme.lua`. The new theme is applied on the next Neovim launch.

---

## Requirements

- Neovim 0.9+
- A plugin manager (tested with [lazy.nvim](https://github.com/folke/lazy.nvim))

---

## Installation

### 1. Add the plugin via Lazy

Create a file in your `lua/plugins/` folder (e.g. `colorscheme-selector.lua`) with:

```lua
return {
  "anderson3x11/theme-selector.nvim",
  config = function()
    require("theme-selector").setup()
  end,
}
```

### 2. Create your colorschemes folder

In your Neovim config, create `lua/colorschemes/` and add one `.lua` file per theme.

```
~/.config/nvim/
└── lua/
    ├── colorschemes/
    │   ├── gruvbox.lua
    │   ├── catppuccin.lua
    │   └── tokyonight.lua
    └── plugins/
        ├── colorscheme-selector.lua
        └── colorscheme.lua          ← overwritten on theme change
```

Each file should contain whatever you normally put in your `colorscheme.lua`. For example:

**gruvbox.lua**
```lua
return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- "hard", "soft", or "" for medium
    })
    vim.o.background = "dark" -- or "light"
    vim.cmd.colorscheme("gruvbox")
  end,
}
```

**catppuccin.lua**
```lua
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
}
```

### 3. Make sure you have a `colorscheme.lua` in `lua/plugins/`

This is the file that gets overwritten when you switch themes. It should already exist and contain your current theme config.

---

## Usage

| Keymap | Action |
|---|---|
| `<leader>ts` | Open theme selector |

Select a theme from the menu and restart Neovim — your new colorscheme will be active.

---