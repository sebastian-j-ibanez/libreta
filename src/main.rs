// Copyright 2026 Sebastian Ibanez
mod db;
mod handlers;

use axum::{Router, routing::get};
use tower_http::services::ServeDir;

use crate::handlers::{get_boards, root};

const DEFAULT_URL: &'static str = "0.0.0.0:3030";

#[tokio::main]
async fn main() {
    let router = app();
    let listener = tokio::net::TcpListener::bind(DEFAULT_URL).await.unwrap();
    println!("listening on ");
    axum::serve(listener, router).await.unwrap();
}

fn app() -> Router {
    let serve_dir = ServeDir::new("frontend/dist/");
    Router::new()
        .route("/boards", get(get_boards))
        .route("/", get(root))
        .fallback_service(serve_dir)
}
