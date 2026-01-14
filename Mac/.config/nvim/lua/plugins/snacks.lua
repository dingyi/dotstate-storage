return {
  {
    "snacks.nvim",
    opts = {
      dashboard = { example = "compact_files" },
    },
    keys = {
      {
        "<leader>pp",
        function()
          if not Snacks.profiler.toggle() then
            Snacks.profiler.pick({ min_time = 0.2 })
          end
        end,
      },
      {
        "<leader>ph",
        function()
          Snacks.profiler.highlight()
        end,
      },
      {
        "<leader>pd",
        function()
          if not Snacks.profiler.enabled then
            Snacks.notify("Profiler debug started")
            Snacks.profiler.start()
          else
            Snacks.profiler.debug()
            Snacks.notify("Profiler debug stopped")
          end
          if not Snacks.profiler.enabled then
            Snacks.profiler.pick({})
          end
        end,
      },
    },
  },
}
