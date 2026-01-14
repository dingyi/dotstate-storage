return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Extend default options
      opts = opts or {}
      
      -- Configure filesystem source
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      
      -- Add custom keybinding: 'w' to set folder as workspace root (like VS Code)
      -- This sets both Neo-tree root and Neovim working directory
      opts.filesystem.window.mappings["w"] = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          local path = node:get_id()
          -- Use Neo-tree's built-in set_root command
          require("neo-tree.sources.filesystem").commands.set_root(state, path)
          -- Also change Neovim's working directory
          vim.cmd("cd " .. vim.fn.fnameescape(path))
          vim.notify("Opened workspace: " .. path, vim.log.levels.INFO)
        else
          vim.notify("Please select a directory", vim.log.levels.WARN)
        end
      end
      
      -- Add 'cd' keybinding to change directory without changing Neo-tree root
      opts.filesystem.window.mappings["cd"] = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" then
          local path = node:get_id()
          vim.cmd("cd " .. vim.fn.fnameescape(path))
          vim.notify("Changed directory to: " .. path, vim.log.levels.INFO)
        end
      end

      return opts
    end,
  },
}
