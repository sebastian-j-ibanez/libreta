use std::fmt::Display;

pub enum Error {
    DbError(String),
}

impl Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::DbError(msg) => {
                write!(f, "db error: {msg}")
            }
        }
    }
}
