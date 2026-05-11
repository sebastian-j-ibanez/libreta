import Board from "../components/Board";
import { fetchData } from "./fetch";

// Boards

export interface Board {
  id: number;
  name: string;
}

const getBoardsRoute = "/boards";

export async function getBoards(): Promise<Board[]> {
  const boards = await fetchData<Board[]>(getBoardsRoute);
  if (boards === null) {
    console.warn("empty fetch: no boards");
    return Promise.reject();
  }
  return boards;
}

export function getBoardsMock(): Board[] {
  var boards: Board[] = [];
  boards.push({ id: 0, name: "Libreta" });
  boards.push({ id: 1, name: "Copper" });
  return boards;
}

// Columns

export interface Column {
  id: number;
  name: string;
  order: number;
}

export function getColumnsMock(): Column[] {
  var columns: Column[] = [];
  columns.push({ id: 0, name: "Backlog", order: 0 });
  columns.push({ id: 1, name: "In Progress", order: 1 });
  columns.push({ id: 2, name: "Complete", order: 2 });
  return columns;
}

// Cards

export interface Card {
  id: number;
  title: string;
  description: string;
  complete: boolean;
}

export function getCardsMock(): Card[] {
  var cards: Card[] = [];
  cards.push({
    id: 0,
    title: "Finish board component",
    description:
      "We need to finish the board component. This will probably include making a Card and Column component.",
    complete: false,
  });
  return cards;
}
