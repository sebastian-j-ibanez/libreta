// Copyright 2026 Sebastian Ibanez

use serde::Serialize;
use sqlx::{Row, SqlitePool};

use crate::error::Error;

#[derive(Debug, Clone)]
pub struct DbManager {
    pool: SqlitePool,
}

impl DbManager {
    /// CAUTION: be responsible with the db_url you provide.
    pub async fn init(db_url: &str) -> Result<Self, sqlx::Error> {
        let pool = SqlitePool::connect(db_url).await?;
        Ok(Self { pool })
    }

    /// Get all `Boards` from database.
    pub async fn get_all_boards(&self) -> Result<Vec<Board>, Error> {
        let query = sqlx::query("SELECT id, name FROM boards;");
        let rows = query
            .fetch_all(&self.pool)
            .await
            .map_err(|e| Error::DbError(e.to_string()))?;

        let mut boards = Vec::new();
        for row in rows.iter() {
            let id = row.get::<u32, &str>("id");
            let name = row.get::<String, &str>("name");
            boards.push(Board { id: id, name: name });
        }
        Ok(boards)
    }
}

/// Represents a todo Board.
#[derive(Debug, Clone, Serialize)]
pub struct Board {
    pub(crate) id: u32,
    pub(crate) name: String,
}
