# This is a justfile comment
default:
    @echo "Hello! Run 'just --list' to see available commands"

build-hello:
    riscv64-unknown-elf-as -o target/hello.o src/hello.s
    riscv64-unknown-elf-ld -T ./src/link.ld -o target/hello target/hello.o
    qemu-system-riscv64 -nographic -machine virt -kernel target/hello -bios /usr/share/qemu/opensbi-riscv64-generic-fw_dynamic.bin

run-example:
    mkdir -p ./target/assembly-foundations
    # assemble the example
    riscv64-linux-gnu-as -o ./target/assembly-foundations/example.o ./src/assembly-foundations/example.s 
    # link the example
    riscv64-linux-gnu-ld -o ./target/assembly-foundations/example ./target/assembly-foundations/example.o
    # run the example and store exit code
    -qemu-riscv64-static ./target/assembly-foundations/example; echo "exit code: $?"


