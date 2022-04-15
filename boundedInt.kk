struct boundedInt {
  bottom: int
  value: int
  top: int
}

fun createBottom(bottom: int, top: int) {
  BoundedInt(bottom, bottom, top)
}

fun uint(size: int) {
  BoundedInt(0, 0, size)
}

fun show(bi: boundedInt): string {
  "BoundedInt<"
  ++ bi.bottom.show
  ++ ", "
  ++ bi.top.show
  ++ "> "
  ++ bi.value.show
}

fun inc(this: boundedInt): boundedInt {
  if (this.value == this.top)
    then createBottom(this.bottom, this.top)
    else BoundedInt(this.bottom, this.value + 1, this.top)
}
  
fun dec(this: boundedInt): boundedInt {
  if (this.value == this.bottom)
    then BoundedInt(this.bottom, this.top, this.top)
    else BoundedInt(this.bottom, this.value - 1, this.top)
}
