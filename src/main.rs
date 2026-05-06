// Copyright 2026 Sebastian Ibanez
mod db;
mod error;
mod handlers;

use axum::{Router, routing::get};
use tower_http::services::ServeDir;

use crate::{
    db::DbManager,
    handlers::{get_all_boards_handler, root},
};

const DEFAULT_URL: &'static str = "127.0.0.1:3030";
const DEFAULT_DB: &'static str = "sqlite://./database/libreta.db";

#[tokio::main]
async fn main() {
    let db = DbManager::init(DEFAULT_DB).await.unwrap();
    let router = app(db);
    let listener = tokio::net::TcpListener::bind(DEFAULT_URL).await.unwrap();
    println!("listening on http://{}", DEFAULT_URL);
    axum::serve(listener, router).await.unwrap();
}

fn app(db: DbManager) -> Router {
    let serve_dir = ServeDir::new("frontend/dist/");
    Router::new()
        .route("/boards", get(get_all_boards_handler))
        .route("/", get(root))
        .fallback_service(serve_dir)
        .with_state(db)
}
