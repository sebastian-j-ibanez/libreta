import { For, createResource } from "solid-js";
import { getBoardNames } from "../api/boards";

export default function Sidebar() {
    const [boardNames] = createResource(getBoardNames);

    return (
        <div class="text-2xl fixed left-0 top-0 h-screen w-60 border-r flex flex-col items-center py-4">
            <ul>
                <For each={boardNames()}>
                    {(board) => (
                        <li>
                            <button class="font-bold">{board.name}</button>
                        </li>
                    )}
                </For>
            </ul>
        </div >
    )
}
