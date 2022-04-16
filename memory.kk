import listZipper;
import boundedInt;

struct memory {
  zipper: listZipper<boundedInt>
}

fun createMemory(cellCount: int, cellSize: int): maybe<memory> {
  val l = list(0, cellCount.dec, fn(i) { uint(cellSize) })
  listZipper(l).map(Memory)
}

fun left(this: memory): memory {
  this(zipper = this.zipper.leftW)
}

fun right(this: memory): memory {
  this(zipper = this.zipper.rightW)
}

fun inc(this: memory): memory {
  this(zipper = this.zipper.modify(inc))
}

fun dec(this: memory): memory {
  this(zipper = this.zipper.modify(dec))
}

fun read(this: memory): int {
  this.zipper.focus.value
}

fun write(this: memory, value: int): memory {
  this(zipper = this.zipper.modify(fn(i) i.set(value)))
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
    ++ this.zipper.focus.size.show
    ++ "> {"
    ++ this.zipper.show(showValue)
    ++ "}"
}
