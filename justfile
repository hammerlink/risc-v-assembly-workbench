# This is a justfile comment
default:
    @echo "Hello! Run 'just --list' to see available commands"

build-hello:
    riscv64-unknown-elf-as -o target/hello.o src/hello.s
    riscv64-unknown-elf-ld -T ./src/link.ld -o target/hello target/hello.o
    qemu-system-riscv64 -nographic -machine virt -kernel target/hello

