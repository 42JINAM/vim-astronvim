return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
  },
  opts = function(_, opts)
    local cmp = require("cmp")

    -- 기본 매핑 설정
    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<CR>"] = cmp.mapping.confirm({ select = true }),

      -- 자동완성을 위한 매핑
      ["<C-Space>"] = cmp.mapping.complete(),  -- 자동완성 시작
      ["<C-n>"] = cmp.mapping.select_next_item(), -- 다음 항목 선택
      ["<C-p>"] = cmp.mapping.select_prev_item(), -- 이전 항목 선택

      -- 기본 탭 동작
      ["<Tab>"] = cmp.mapping(function(fallback)
        -- 기본 탭 입력으로 동작
        fallback()
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        -- 기본 Shift+탭 입력으로 동작
        fallback()
      end, { "i", "s" }),
    })

    -- 소스 및 포맷팅 설정
    opts.sources = vim.list_extend(opts.sources or {}, {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
    })

    opts.formatting = {
      format = function(entry, item)
        item.menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return item
      end,
    }

    opts.experimental = {
      ghost_text = true,
    }

    return opts
  end,
}
