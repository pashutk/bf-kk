import prelude
import parser
import examplePrograms
import memory
import os

fun interpret(n: node, mem: memory): <console, div, exn, readChar | e> memory {
  match n {
    Mvl -> mem.left
    Mvr -> mem.right
    Inc -> mem.inc
    Dec -> mem.dec
    Ior -> mem.write(readChar().int)
    Iow -> {
      print(mem.read.char)
      mem
    }
    Jmp(body) -> {
      var bmemory := mem
      while { bmemory.read.isNonZero } {
        body.foreach(fn (bnode) {
          bmemory := bnode.interpret(bmemory)
        })
      }
      bmemory
    }
    Cmt -> mem
  }
}

fun main() {
  val ast = parserEither(helloWorldProgram)
    .mapLeft(fn(x) { "Parsing error: " ++ x })
    .untry

  var memoryState := createMemory(cellCount = 30_000, cellSize = 256)
    .unjust

  with readlineBuffer
  ast.foreach(fn(n) { memoryState := n.interpret(memoryState) })
}
