import std/text/parse

type node {
  Mvl
  Mvr
  Inc
  Dec
  Ior
  Iow
  Jmp(body: list<node>)
  Cmt(content: string)
}

fun show(n: node): div string {
  match n {
    Mvl -> "mvl"
    Mvr -> "mvr"
    Inc -> "inc"
    Dec -> "dec"
    Ior -> "ior"
    Iow -> "iow"
    Jmp(body) -> "jmp" ++ body.show-list(show)
    Cmt(content) -> "cmt(" ++ content ++ ")"
  }
}

fun pmovl() {
  char('<')
  Mvl
}

fun pmovr() {
  char('>')
  Mvr
}

fun pinc() {
  char('+')
  Inc
}

fun pdec() {
  char('-')
  Dec
}

fun pior() {
  char(',')
  Ior
}

fun piow() {
  char('.')
  Iow
}

fun pjmp() {
  char('[')
  val body = pnodes()
  char(']')
  Jmp(body)
}

fun pcmt() {
  val content = none-of-many1("<>+-,.[]")
  Cmt(content)
}

fun pnode() {
  choose([
    pcmt,
    pmovl,
    pmovr,
    pinc,
    pdec,
    pior,
    piow,
    pjmp,
  ])
}

fun pnodes(): <parse, div> list<node> {
  many(pnode)
}

fun parser(input: string) {
  parse-eof(input.slice, pnodes)
}

fun parserEither(input: string) {
  parser(input).either
}
