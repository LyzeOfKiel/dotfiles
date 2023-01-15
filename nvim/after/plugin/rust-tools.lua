local rt = require("rust-tools")

rt.setup({
    tools = {
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        }
    }
})
