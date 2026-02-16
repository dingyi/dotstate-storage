return {
  {
    "snacks.nvim",
    opts = {
      dashboard = { example = "compact_files" },
      notifier = {
        timeout = 5000, -- 5秒，默认是3000ms
      },
    },
    keys = {
      {
        "<leader>snh",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Show notification history",
      },
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
