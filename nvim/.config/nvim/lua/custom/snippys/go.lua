local s = require "snippy.init"

s.add {
  go = {
    {
      trig = "gof",
      desc = "Go anonymous function",
      body = {
        "go func() {",
        "\t${1:body}",
        "}()",
      },
    },
    {
      trig = "ei",
      desc = "Error handling golang",
      body = {
        "if err != nil {",
        "\t${1:handle}",
        "}",
        "${2}",
      },
    },
  },
}
