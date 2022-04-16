struct nonEmptyList<a> {
  head: a
  tail: list<a>
}

fun cons(h: a, t: list<a>): nonEmptyList<a> {
  NonEmptyList(h, t)
}

fun cons(h: a, t: nonEmptyList<a>): nonEmptyList<a> {
  NonEmptyList(h, Cons(t.head, t.tail))
}

fun reverse-append(this: list<a>, tl: nonEmptyList<a>): nonEmptyList<a> {
  fun reverse-acc(acc: nonEmptyList<a>, ys: list<a> ) : nonEmptyList<a>
    match ys {
      Cons(h, t) -> reverse-acc(cons(h, acc), t)
      _          -> acc
  }

  reverse-acc(tl, this)
}
