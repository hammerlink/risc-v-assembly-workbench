# This is a justfile comment
default:
    @echo "Hello! Run 'just --list' to see available commands"

build-hello:
    riscv64-unknown-elf-as -o target/hello.o src/hello.s
    riscv64-unknown-elf-ld -T ./src/link.ld -o target/hello target/hello.o
    qemu-system-riscv64 -nographic -machine virt -kernel target/hello -bios /usr/share/qemu/opensbi-riscv64-generic-fw_dynamic.bin

example-build:
    mkdir -p ./target/assembly-foundations
    # assemble the example
    riscv64-linux-gnu-as -o ./target/assembly-foundations/example.o ./src/assembly-foundations/example.s 
    # link the example
    riscv64-linux-gnu-ld -o ./target/assembly-foundations/example ./target/assembly-foundations/example.o

example-run: example-build
    # run the example and store exit code
    -qemu-riscv64-static ./target/assembly-foundations/example; echo "exit code: $?"

example-objdump: example-build
    # get object dump
    riscv64-linux-gnu-objdump -sd ./target/assembly-foundations/example > ./src/assembly-foundations/example.dump

# Create GDB init file
create-gdb-init:
    @mkdir -p ./target
    @echo "target remote :1234" > ./target/gdbinit
    @echo "display /3i \$pc" >> ./target/gdbinit

example-debug: example-build create-gdb-init
    ## commands
    # target remote :1234
    # display /3i $pc
    # si
    # c
    qemu-riscv64-static -g 1234 ./target/assembly-foundations/example & gdb-multiarch -x ./target/gdbinit ./target/assembly-foundations/example

