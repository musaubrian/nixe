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
  javascript = {
    {
      trig = "res5",
      desc = "500 result express",
      body = "return res.status(500).json({message: '${1}'})",
    },
    {
      trig = "res4",
      desc = "400 result express",
      body = "return res.status(400).json({message: '[BAD REQUEST]: ${1}'})",
    },
    {
      trig = "res2",
      desc = "200 result express",
      body = 'return res.status(200).json({message: "${1}", ${2}})',
    },
    {
      trig = "fba",
      desc = "initialize firebase admin and db",
      body = {
        'const firebaseAdmin = require("firebase-admin")',
        "const db = firebaseAdmin.firestore()",
      },
      {
        trig = "imp",
        desc = "Import stuff",
        body = {
          "const firebaseAdmin = require('firebase-admin')",
          "const db = firebaseAdmin.firestore()",
          "const router = require('express').Router()",
        },
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
