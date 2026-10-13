local s = require "snippy.init"

s.add {
  typescript = {
    {
      trig = "efg",
      desc = "Effect.gen(function* () {...})",
      body = "Effect.gen(function* () { ${1} })",
    },
    {
      trig = "efn",
      desc = "Effect.fn('...')(function* (...) {})",
      body = {
        'const ${1} = Effect.fn("${2}")(function* (${3}) {',
        "   ${4}",
        "}",
      },
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
