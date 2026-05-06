// Copyright 2026 Sebastian Ibanez
use axum::{Json, extract::State, http::StatusCode, response::Html};

use crate::db::{Board, DbManager};

/// Get index.html.
pub async fn root() -> Html<&'static str> {
    Html(include_str!("../frontend/dist/index.html"))
}

// Boards

/// Get all boards from database.
/// This is a mock function right now.
pub async fn get_boards_handler(
    State(db_manager): State<DbManager>,
) -> (StatusCode, Json<Vec<Board>>) {
    match db_manager.get_all_boards().await {
        Ok(boards) => (StatusCode::OK, Json(boards)),
        Err(e) => {
            eprintln!(
                "[ERR] error while getting all boards from db: {}",
                e.to_string()
            );
            (StatusCode::INTERNAL_SERVER_ERROR, Json(Vec::new()))
        }
    }
}
