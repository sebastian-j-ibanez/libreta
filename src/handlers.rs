// Copyright 2026 Sebastian Ibanez
use axum::{Json, http::StatusCode, response::Html};
use serde::Serialize;

/// Get index.html.
pub async fn root() -> Html<&'static str> {
    Html(include_str!("../frontend/dist/index.html"))
}

// Boards

/// Represents a todo Board.
#[derive(Debug, Clone, Serialize)]
pub struct Board {
    id: u32,
    name: String,
}

/// Get all boards from database.
/// This is a mock function right now.
pub async fn get_boards() -> (StatusCode, Json<Vec<Board>>) {
    let mut boards = Vec::new();
    boards.push(Board {
        id: 0,
        name: String::from("Main"),
    });
    (StatusCode::OK, Json(boards))
}
