import std/os/readline

fun readChar(): <div, console, exn> char {
  val line = readline()
  match head-char(line) {
    Just(c) -> c
    Nothing -> readChar()
  }
}
