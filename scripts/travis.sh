#!/bin/bash

curl https://sh.rustup.rs -sSf -o rustup.sh
chmod +x ./rustup.sh
./rustup.sh -y
export PATH=/home/travis/.cargo/bin:$PATH
rustup override set nightly-2016-11-06
rustup component add rust-src
cargo install xargo
cargo --version
xargo --version
rustc --version
arm-none-eabi-gcc --version

cp examples/config.rs.sample examples/config.rs

for example_file in examples/*.rs; do
    example=$(basename ${example_file/.rs/})
    ./build.sh --example ${example}
    ./build.sh --example ${example} --release
done
