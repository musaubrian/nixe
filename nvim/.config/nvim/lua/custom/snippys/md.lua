local s = require "snippy.init"

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
        "${3}",
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
        "${5}",
      },
    },
    { trig = "fn", desc = "markdown footnote", body = "[^{}]" },
    { trig = "fnr", desc = "markdown footnote reference", body = "[^{}]: ${1}" },
  },
}
