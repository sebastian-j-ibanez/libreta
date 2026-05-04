import { fetchData } from "./fetch";

export interface Board {
    id: number,
    name: string
}

const getBoardsRoute = "/boards";

export async function getBoardNames(): Promise<Board[]> {
    const boards = await fetchData<Board[]>(getBoardsRoute);
    if (boards === null) {
        console.warn("empty fetch: no boards");
        return Promise.reject();
    }
    return boards;
}
