struct boundedInt {
  bottom: int
  value: int
  top: int
}

fun createBottom(bottom: int, top: int) {
  BoundedInt(bottom, bottom, top)
}

fun uint(size: int) {
  BoundedInt(0, 0, size - 1)
}

fun size(this: boundedInt): int {
  this.top - this.bottom + 1
}

fun show(bi: boundedInt): string {
  "BoundedInt<"
  ++ bi.bottom.show
  ++ ", "
  ++ bi.top.show
  ++ "> "
  ++ bi.value.show
}

fun showValue(bi: boundedInt): string {
  bi.value.show
}

fun inc(this: boundedInt): boundedInt {
  if (this.value == this.top)
    then this(value = this.bottom)
    else this(value = this.value + 1)
}

fun dec(this: boundedInt): boundedInt {
  if (this.value == this.bottom)
    then this(value = this.top)
    else this(value = this.value - 1)
}

fun set(this: boundedInt, v: int) {
  if (this.value == v)
    then this
    else
      val d = this.top - this.bottom + 1
      this(value = v % d)
}
