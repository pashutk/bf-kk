import std/os/readline

effect readChar {
  ctl readChar(): char
}

fun readlineBuffer(action) {
  var buffer := ""

  with handler {
    ctl readChar() {
      match buffer.head-char
        Just(c) ->
          buffer := buffer.tail
          resume(c)

        Nothing ->
          val line = readline()
          match line.head-char
            Just(c) ->
              buffer := line.tail ++ "\n"
              resume(c)

            Nothing -> resume('\n')
    }
  }
  action()
}
