import prelude
import listZipper

struct memory {
  zipper: listZipper<int>
  cellSize: int
}

fun createMemory(cellCount: int, cellSize: int): maybe<memory> {
  val l = list(0, cellCount.dec, fn(_) 0)
  listZipper(l).map(fn(zipper) Memory(zipper, cellSize))
}

fun left(this: memory): memory {
  this(zipper = this.zipper.leftW)
}

fun right(this: memory): memory {
  this(zipper = this.zipper.rightW)
}

fun inc(this: memory): memory {
  this(zipper = this.zipper.modify(fn(v) {
    val newVal = v + 1
    if (newVal == this.cellSize)
      then 0
      else newVal
  }))
}

fun dec(this: memory): memory {
  this(zipper = this.zipper.modify(fn(v) {
    if (v == 0)
      then this.cellSize - 1
      else v - 1
  }))
}

fun read(this: memory): int {
  this.zipper.focus
}

fun write(this: memory, value: int): memory {
  this(zipper = this.zipper.set(value % this.cellSize))
}

fun show(m: maybe<memory>): string {
  match m {
    Nothing -> "Nothing"
    Just(x) -> "Just " ++ x.show
  }
}

fun show(this: memory): string {
  "Memory<"
    ++ this.zipper.size.show
    ++ ", "
    ++ this.cellSize.show
    ++ "> {"
    ++ this.zipper.show(show)
    ++ "}"
}
