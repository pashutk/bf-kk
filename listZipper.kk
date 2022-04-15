struct listZipper<a> {
  lefts: list<a>
  focus: a
  rights: list<a>
}

fun listZipper(l: list<a>): maybe<listZipper<a>> {
  match l {
    Nil -> Nothing
    Cons(head, tail) -> Just(ListZipper(Nil, head, tail))
  }
}

fun size(this: listZipper<a>): int {
  this.lefts.length + 1 + this.rights.length
}

fun start(this: listZipper<a>): listZipper<a> {
  // TODO
}

fun left(this: listZipper<a>): maybe<listZipper<a>> {
  match this.lefts {
    Nil -> Nothing
    Cons(head, tail) -> Just(ListZipper(tail, head, Cons(this.focus, this.rights)))
  }
}

fun leftW(this: listZipper<a>): listZipper<a> {
  this.left.default(this.end)
}

fun right(this: listZipper<a>): maybe<listZipper<a>> {
  match this.rights {
    Nil -> Nothing
    Const(head, tail) -> Just(ListZipper(Cons(this.focus, this.lefts), head, tail))
  }
}

fun rightW(this: listZipper<a>): listZipper<a> {
  this.right.default(this.start)
}
