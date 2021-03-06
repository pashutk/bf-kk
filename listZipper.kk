import nonEmptyList;

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

fun listZipper(l: nonEmptyList<a>): listZipper<a> {
  ListZipper(Nil, l.head, l.tail)
}

fun size(this: listZipper<a>): int {
  this.lefts.length + 1 + this.rights.length
}

fun start(this: listZipper<a>): listZipper<a> {
  match this.lefts {
    Nil -> this
    Cons ->
      val newTail = cons(this.focus, this.rights)
      val newList = this.lefts.reverse-append(newTail)
      ListZipper(Nil, newList.head, newList.tail)
  }
}

fun end(this: listZipper<a>): listZipper<a> {
  match this.rights {
    Nil -> this
    Cons ->
      val newTail = cons(this.focus, this.lefts)
      val newList = this.rights.reverse-append(newTail)
      ListZipper(newList.tail, newList.head, Nil)
  }
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
    Cons(head, tail) -> Just(ListZipper(Cons(this.focus, this.lefts), head, tail))
  }
}

fun rightW(this: listZipper<a>): listZipper<a> {
  this.right.default(this.start)
}

fun show(this: listZipper<a>, showItem: (a) -> e string): e string {
  [
    this.lefts.reverse.show-list(showItem),
    this.focus.showItem,
    this.rights.show-list(showItem)
  ].join(" ")
}

fun set(this: listZipper<a>, a: a): listZipper<a> {
  this(focus = a)
}

fun modify(this: listZipper<a>, f: (a) -> a): listZipper<a> {
  this.set(f(this.focus))
}
