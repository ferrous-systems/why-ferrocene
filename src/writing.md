# Writing and running a program

## The demo

* I have the `aarch64-unknown-none` target
* I want run to run a binary on an ARMv8-A machine in Aarch64 mode
* I'm using QEMU
* I'll need a UART driver so you can see the output
* I'll need some assembly code to boot the chip
* All the demo source code is available

## Building the demo

* You can build this with `cargo build`
* You can drive `rustc` manually with `$MY_FAVOURITE` build system
* I show both

## The boot.S file

Set the stack pointer, jump to a symbol called `kmain`.

```asm
.section .text.startup
.global _start

_start:
    ldr x30, =stack_top
    mov sp, x30
    mov x0, #3 << 20
    msr cpacr_el1, x0
    msr daifclr, #0x4
    bl kmain
    b .
```

## The skeleton

```rust [] ignore
#![no_std]
#![no_main]

#[no_mangle]
pub extern "C" fn kmain() {
    todo!()
}

#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! { }
```

Note:

We turned off name-mangling with `#[no_mangle]` so `boot.S` could jump to
`kmain`. We also set the function to have `C` linkage (i.e. use a C compatible
ABI), like assembly branch assumed.

## The UART

```rust []
struct Uart { base: *mut u32 }

impl Uart {
    pub fn uart0() -> Uart {
        const UART0_ADDR: usize = 0x0000_0000_0900_0000;
        Uart { base: UART0_ADDR as *mut u32 }
    }

    pub fn putchar(&mut self, byte: u8) {
        unsafe { self.base.write_volatile(u32::from(byte)); }
    }
}
```

## Writing to the UART

```rust [] ignore
impl core::fmt::Write for Uart {
    fn write_str(&mut self, s: &str) -> core::fmt::Result {
        for b in s.bytes() {
            self.putchar(b);
        }
        Ok(())
    }
}
```

## Handling panics

```rust [] ignore
#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! {
    const SYS_REPORTEXC: u64 = 0x18;
    let mut c = Uart::uart0();
    let _ = writeln!(c, "PANIC: {:?}", info);
    loop {
        unsafe {
            core::arch::asm!(
                "hlt 0xf000",
                in("x0") SYS_REPORTEXC
            )
        }
    }
}
```

## Some application code

```rust [] ignore
fn main() -> Result<(), core::fmt::Error> {
    let mut c = Uart::uart0();
    writeln!(c, "Hello, this is Rust!")?;
    for x in 1..=10 {
        for y in 1..=10 {
            let z = x * y;
            write!(c, "{z:4}")?;
        }
        writeln!(c)?;
    }
    panic!("I am a panic");
}
```

## And fixing up kmain

```rust [] ignore
#[no_mangle]
pub extern "C" fn kmain() {
    if let Err(e) = main() {
        panic!("main returned {:?}", e);
    }
}
```

## Let's run it

```console
$ cargo run
   Compiling basic-rust v0.1.0 (/work)
    Finished dev [unoptimized + debuginfo] target(s) in 12.17s
     Running `qemu-system-aarch64 -machine virt -cpu cortex-a57 -semihosting
     -nographic -kernel target/aarch64-unknown-none/debug/basic-rust`
Hello, this is Rust!
   1   2   3   4   5   6   7   8   9  10
   2   4   6   8  10  12  14  16  18  20
   3   6   9  12  15  18  21  24  27  30
   4   8  12  16  20  24  28  32  36  40
   5  10  15  20  25  30  35  40  45  50
   6  12  18  24  30  36  42  48  54  60
   7  14  21  28  35  42  49  56  63  70
   8  16  24  32  40  48  56  64  72  80
   9  18  27  36  45  54  63  72  81  90
  10  20  30  40  50  60  70  80  90 100
PANIC: PanicInfo { payload: Any { .. }, message: Some(I am a panic),
location: Location { file: "src/main.rs", line: 72, col: 5 }, can_unwind: true }
$
```

## Wait, how did boot.S get assembled?

There's a long and boring `build.rs` file which shells out to `as` and `ar` to
assemble `boot.S` into `libboot.a`.

## If you don't want to use cargo

```sh
 # snip some variable set up...
RUSTC="rustc \
    --target aarch64-unknown-none \
    -Clinker=${CC} \
    -Clinker-flavor=gcc \
    -Clink-arg=-ffreestanding \
    -Clink-arg=-nostdlib \
    -L ${TARGET_DIR}"
${AS} src/boot.S -o ${TARGET_DIR}/boot.o
${AR} rcs ${TARGET_DIR}/libboot.a ${TARGET_DIR}/boot.o
${RUSTC} src/main.rs \
    --edition 2021 \
    -Clink-arg=-Tlinker.ld \
    -Copt-level=s \
    -lboot \
    -o ${OUTPUT_BINARY}
```
