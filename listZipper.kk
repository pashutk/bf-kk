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

// TODO: get rid of exn eff by rewriting reverse-append so it preserves non-emptiness of newList
fun start(this: listZipper<a>): exn listZipper<a> {
  match this.lefts {
    Nil -> this
    Cons ->
      val newTail = Cons(this.focus, this.rights)
      val newList = this.lefts.reverse-append(newTail)
      ListZipper(Nil, newList.head.unjust, newList.tail)
  }
}

fun end(this: listZipper<a>): exn listZipper<a> {
  match this.rights {
    Nil -> this
    Cons ->
      val newTail = Cons(this.focus, this.lefts)
      val newList = this.rights.reverse-append(newTail)
      ListZipper(newList.tail, newList.head.unjust, Nil)
  }
}

fun left(this: listZipper<a>): maybe<listZipper<a>> {
  match this.lefts {
    Nil -> Nothing
    Cons(head, tail) -> Just(ListZipper(tail, head, Cons(this.focus, this.rights)))
  }
}

fun leftW(this: listZipper<a>): exn listZipper<a> {
  this.left.default(this.end)
}

fun right(this: listZipper<a>): maybe<listZipper<a>> {
  match this.rights {
    Nil -> Nothing
    Cons(head, tail) -> Just(ListZipper(Cons(this.focus, this.lefts), head, tail))
  }
}

fun rightW(this: listZipper<a>): exn listZipper<a> {
  this.right.default(this.start)
}
