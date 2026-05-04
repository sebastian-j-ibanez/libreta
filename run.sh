#! /usr/bin/env bash

# Build frontend
cd ./frontend/
npm run build

# Run server
cd ../
cargo run