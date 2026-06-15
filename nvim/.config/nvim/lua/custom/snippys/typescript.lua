local s = require "snippy.init"

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
