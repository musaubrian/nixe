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
      },
    },
  },
}

s.add {
  markdown = {
    {
      trig = "nm",
      desc = "notes metadata block",
      body = {
        "---",
        "tags:",
        "- '#${1}'",
        "meta: ${2}",
        "status: researching",
        "---",
      },
    },
    {
      trig = "meta",
      desc = "blog front-matter",
      body = {
        "---",
        "title: '${1:post title}'",
        "description: '${2:post description}'",
        "date: ${3:2024-05-07}",
        "tags: ['${4}']",
        "showTags: true",
        "readTime: true",
        "---",
      },
    },
    { trig = "fn", desc = "markdown footnote", body = "[^{}]" },
    { trig = "fnr", desc = "markdown footnote reference", body = "[^{}]: ${1}" },
  },
}

s.add {
  typescript = {
    {
      trig = "efg",
      desc = "Effect.gen(function* () {...})",
      body = "Effect.gen(function* () { ${1} })",
    },
    {
      trig = "etp",
      desc = "Effect.tryPromise({...})",
      body = {
        "Effect.tryPromise({",
        "  try: () => ${1},",
        "  catch: (error) => new ${2}",
        "})",
      },
    },
    {
      trig = "erp",
      desc = "Effect.runPromise(...)",
      body = "Effect.runPromise(${1})",
    },
  },
}
