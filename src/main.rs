// Copyright 2026 Sebastian Ibanez
mod db;
mod handlers;

use axum::{Router, routing::get};
use tower_http::services::ServeDir;

use crate::handlers::{get_boards, root};

#[tokio::main]
async fn main() {
    let router = app();
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, router).await.unwrap();
}

fn app() -> Router {
    let serve_dir = ServeDir::new("frontend/dist/");
    Router::new()
        .route("/boards", get(get_boards))
        .route("/", get(root))
        .fallback_service(serve_dir)
}
