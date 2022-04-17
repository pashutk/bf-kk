fun untry(t: either<string, a>): exn a {
  match t {
    Left(exn) -> throw(exn)
    Right(x) -> x
  }
}

fun mapLeft(t: either<e1, a>, f: e1 -> e e2): e either<e2, a> {
  match t {
    Right(x) -> Right(x)
    Left(x) -> Left(f(x))
  }
}

fun isNonZero(i: int): bool {
  !i.is-zero
}