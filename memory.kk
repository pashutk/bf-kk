import listZipper;
import boundedInt;

struct memory {
  zipper: listZipper<boundedInt>
  cellSize: int
}

fun createMemory(cellCount: int, cellSize: int): maybe<memory> {
  val l = list(0, cellCount.dec, fn(i) { uint(cellSize) })
  listZipper(l).map(fn(i) Memory(i, cellSize))
}

fun left(this: memory): exn memory {
  this(zipper = this.zipper.leftW)
}

fun right(this: memory): exn memory {
  this(zipper = this.zipper.rightW)
}

fun show(m: maybe<memory>): string {
  match m {
    Nothing -> "Nothing"
    Just(x) -> "Just " ++ x.show
  }
}

fun show(this: memory): string {
  fun showContent(lz: listZipper<boundedInt>): string {
    [
      lz.lefts.reverse.map(fn(i) i.value.show).join(", "),
      ("[" ++ lz.focus.value.show ++ "]"),
      lz.rights.map(fn(i) i.value.show).join(", ")
    ].join(" ")
  }

  "Memory<"
    ++ this.cellSize.show
    ++ ", "
    ++ this.zipper.size.show
    ++ "> {"
    ++ this.zipper.showContent
    ++ "}"
}
